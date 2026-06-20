import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hackathon/config/app_config.dart';
import 'package:hackathon/firebase_options.dart';
import 'package:hackathon/screen/chatboat/controller/chatcontroller.dart';
import 'package:hackathon/screen/explore_careers/degree_chooser/controller/DegreeChooserController.dart';
import 'package:hackathon/screen/explore_careers/path_chooser/controller/path_chooser_controller.dart';
import 'package:hackathon/screen/resume_result/controller/resume_result_controller.dart';
import 'package:hackathon/screen/resume_upload/controller/resume_upload_controller.dart';
import 'package:hackathon/screen/signup/authwrapper.dart';
import 'package:hackathon/screen/splash_screen.dart';
import 'package:hackathon/screen/tasks/controller/allupdatefunction.dart';
import 'package:hackathon/screen/tasks/controller/taskprovider.dart';
import 'package:hackathon/screen/tasks/controller/userprovider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Load environment variables
  await dotenv.load(fileName: '.env');
  AppConfig.loadeApikey();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ResumeUploadController()),
        ChangeNotifierProvider(create: (context) => ResumeResultController()),
        ChangeNotifierProvider(create: (context) => DateTimeProvider()),
        ChangeNotifierProvider(create: (context) => Taskprovider()),
        ChangeNotifierProvider(create: (context) => Userprovider()),
        ChangeNotifierProvider(create: (context) => ChatProvider()),
        ChangeNotifierProvider(create: (_) => DegreeChooserController()),
        ChangeNotifierProvider(create: (_) => CareerPathController()),
        ChangeNotifierProvider(create: (_) => AuthController()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Career Compass',
      // Define a unified dark theme
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xff051429), // Your deep dark blue
        canvasColor: const Color(0xff051429), // For sheets, drawers, dropdowns
        colorScheme: const ColorScheme.dark().copyWith(
          surface: const Color(0xff051429), // For fallback surface blends
        ),
      ),
      home: const CareerCompassPage(),
      // home: const CareerPathReadyScreen(),
    );
  }
}
