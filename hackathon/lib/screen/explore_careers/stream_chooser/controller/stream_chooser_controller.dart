// import 'package:flutter/material.dart';
// import 'package:hackathon/auth/stream_AI.dart';
// import 'package:hackathon/model/degreeModel.dart';

// class StreamChooserController extends ChangeNotifier {
//   bool isLoading = false;

//   List<StreamModel> streams = [];

//   Future<void> loadStreams() async {
//     isLoading = true;
//     notifyListeners();

//     final result =
//         await getStreamsAI();

//     if (result != null) {
//       streams = result.streams;
//     }

//     isLoading = false;
//     notifyListeners();
//   }
// }