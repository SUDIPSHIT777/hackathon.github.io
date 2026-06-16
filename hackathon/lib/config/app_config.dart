import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static late String api;
  static late String apikey;
  static void loadeApikey() async {
    await dotenv.load(fileName: '.env');
    apikey = dotenv.env['apikey']!;
      api = dotenv.env['api']!;
  }
}
