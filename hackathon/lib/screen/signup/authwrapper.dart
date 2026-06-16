import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isLoading = false;

  Future<bool> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      isLoading = true;
      notifyListeners();

      UserCredential credential = await _auth
          .createUserWithEmailAndPassword(
            email: email,
            password: password,
          );

      await credential.user?.updateDisplayName(name);

      final prefs = await SharedPreferences.getInstance();

      await prefs.setBool("isLoggedIn", true);
      await prefs.setString("name", name);
      await prefs.setString("email", email);

      return true;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      isLoading = true;
      notifyListeners();

      UserCredential credential = await _auth
          .signInWithEmailAndPassword(
            email: email,
            password: password,
          );

      final prefs = await SharedPreferences.getInstance();

      await prefs.setBool("isLoggedIn", true);
      await prefs.setString(
        "name",
        credential.user?.displayName ?? "",
      );
      await prefs.setString(
        "email",
        credential.user?.email ?? "",
      );

      return true;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await _auth.signOut();

    final prefs = await SharedPreferences.getInstance();

    await prefs.clear();

    notifyListeners();
  }

  User? get currentUser => _auth.currentUser;
}