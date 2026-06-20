import 'package:flutter/material.dart';
import 'package:hackathon/auth/degree_AI.dart';
import 'package:hackathon/model/degreeModel.dart';
class DegreeChooserController
    extends ChangeNotifier {

  bool isLoading = false;

  List<DegreeModel> degrees = [];

  Future<void> loadDegrees(
    String stream,
  ) async {

    isLoading = true;
    notifyListeners();

    final result =
        await getDegreesAI(stream);

    if (result != null) {
      degrees = result.degrees;
    }

    isLoading = false;
    notifyListeners();
  }
}