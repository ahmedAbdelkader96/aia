import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants {
  static String get aiEndPoint =>
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=${dotenv.env['apiKey'].toString()}";
}
