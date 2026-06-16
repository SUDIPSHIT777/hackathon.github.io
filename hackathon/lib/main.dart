import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hackathon/config/app_config.dart';
import 'package:hackathon/firebase_options.dart';
import 'package:hackathon/screen/bottomNav/bottom_nav.dart';
import 'package:hackathon/screen/chatboat/controller/chatcontroller.dart';
import 'package:hackathon/screen/home/home_screen.dart';
import 'package:hackathon/screen/login/login.dart';
import 'package:hackathon/screen/resume_result/controller/resume_result_controller.dart';
import 'package:hackathon/screen/resume_upload/controller/resume_upload_controller.dart';
import 'package:hackathon/screen/explore_careers/stream_chooser/exploer_careers_screen.dart';
import 'package:hackathon/screen/tasks/controller/allupdatefunction.dart';
import 'package:hackathon/screen/tasks/controller/taskprovider.dart';
import 'package:hackathon/screen/tasks/controller/userprovider.dart';
import 'package:hackathon/screen/tasks/ui/taskpageui.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

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
      ],
      child: MyApp(isLoggedIn: isLoggedIn),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
<<<<<<< HEAD
      home: Taskpageui(),
      // home: ResumeAnalysisResultsScreen(page: '',),
=======
      title: 'Career Compass',
      // Define a unified dark theme
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xff051429), // Your deep dark blue
        canvasColor: const Color(0xff051429), // For sheets, drawers, dropdowns
        colorScheme: const ColorScheme.dark().copyWith(
          surface: const Color(0xff051429), // For fallback surface blends
        ),
      ),
      home: BottomNav(),
      // home: const ChooseStreamScreen(),
>>>>>>> e60bce106835aea4c2c212ca2798370fb4b13fd9
    );
  }
}
