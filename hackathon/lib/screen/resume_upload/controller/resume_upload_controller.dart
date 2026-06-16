import 'dart:developer';
import 'package:doc_text_extractor/doc_text_extractor.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackathon/auth/ai_feature.dart';
import 'package:hackathon/screen/bottomNav/bottom_nav.dart';
import 'package:hackathon/screen/loading_screen.dart';
import 'package:hackathon/screen/resume_result/controller/resume_result_controller.dart';
import 'package:hackathon/screen/resume_result/resume_result_screen.dart';
import 'package:hackathon/widgets/custom_Snackbar.dart';
import 'package:provider/provider.dart';

class ResumeUploadController extends ChangeNotifier {
  String fileName = "";
  String pdfPath = "";
  String pdfText = "";
  String fileSize = "";
  void pickFile() async {
    FilePickerResult? result = await FilePicker.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      cancelUploadOnWindowBlur: true,
    );
    if (result?.paths[0] != null) {
      pdfPath = result!.paths[0].toString();
      getText();
      log(result.paths[0].toString());
    }
    notifyListeners();
  }

  // ------- get text from pdf
  void getText() async {
    final extrector = TextExtractor();
    try {
      var result = await extrector.extractText(pdfPath, isUrl: false);
      // log(result.byte.toString());
      pdfText = result.text;
      // fileSize=;
      fileName = result.filename;
    } catch (e) {
      log("geting text err: ${e.toString()}");
    }
    notifyListeners();
  }

  //              onCancelPdf
  // void onCancel() {
  //   fileName = "";
  //   // log('message');
  //   notifyListeners();
  // }

  // // ------- reset data
  void onCancel() {
    fileName = "";
    pdfPath = "";
    pdfText = "";
    fileSize = "";
    notifyListeners();
  }

  //              onSubmit
  void onSubmit(BuildContext context) async {
    // final router = GoRouter.of(context);
    final resultController = context.read<ResumeResultController>();
    if (!validateResume(pdfText)) {
      customSnackbar(
        context: context,
        message: "Please upload a valid resume PDF.",
        color: Colors.red,
        ico: Icons.error,
      );
      return;
    }
    Get.off(() => LoadingScreen());
    final data = await AiFeature.openRouterAI(pdfText);
    if (data != null) {
      resultController.respons = data;
      Get.to(ResumeResultScreen(page: "page"));
    } else {
      Get.offAll(() => BottomNav());
      customSnackbar(
        context: context,
        message:
            "Error: Somthing went wrong please upload the right pdf or try again later",
        color: Colors.red,
        ico: Icons.error,
      );
    }
    onCancel();
    notifyListeners();
  }

  // ------------- clean string
  String cleanResumeText(String text) {
    return text
        .replaceAll(RegExp(r'\r'), '')
        .replaceAll(RegExp(r'\t+'), ' ')
        .replaceAll(RegExp(r' +'), ' ')
        .replaceAll(RegExp(r'\n\s*\n+'), '\n\n')
        .trim();
  }

  // ---------------- checks
  bool hasResumeSignals(String text) {
    final hasEmail = RegExp(r'\S+@\S+\.\S+').hasMatch(text);
    final hasPhone = RegExp(r'\d{10}').hasMatch(text);
    final hasLinkedIn = text.toLowerCase().contains("linkedin");
    return hasEmail || hasPhone || hasLinkedIn;
  }

  bool isResumeText(String text) {
    final lower = text.toLowerCase();

    final keywords = [
      "resume",
      "cv",
      "education",
      "experience",
      "skills",
      "projects",
      "objective",
      "summary",
      "certification",
      "work experience",
    ];
    int score = 0;
    for (final word in keywords) {
      if (lower.contains(word)) score++;
    }
    // log("score $score");
    return score >= 3;
  }

  bool validateResume(String text) {
    // log(
    //   (text.length > 100).toString() +
    //       isResumeText(text).toString() +
    //       hasResumeSignals(text).toString(),
    // );
    return text.length > 100 && isResumeText(text) && hasResumeSignals(text);
  }
}
