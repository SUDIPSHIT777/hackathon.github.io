import 'package:flutter_dotenv/flutter_dotenv.dart';
class AppConfig {
  static late String apikey;
  static late String openRouterkey;
  static void loadeApikey() async {
    await dotenv.load(fileName: '.env');
    apikey = dotenv.env['apikey']!;
    openRouterkey = dotenv.env['openrouterKey']!;
  }
}