import 'package:flutter/material.dart';
import 'package:hackathon/auth/career_path_AI.dart';
import 'package:hackathon/model/career_path_model.dart';

class CareerPathController
    extends ChangeNotifier {

  bool isLoading = false;

  CareerPathModel? data;

  Future<void> loadCareerPath(
    String stream,
    String degree,
  ) async {

    isLoading = true;
    notifyListeners();

    data = await getCareerPathAI(
      stream,
      degree,
    );

    isLoading = false;
    notifyListeners();
  }
}