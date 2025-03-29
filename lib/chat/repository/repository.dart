import 'dart:convert';

import 'package:aia/chat/models/general_message_model.dart';
import 'package:aia/chat/repository/irepository.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../../global/methods_helpers_functions/constants.dart';

class ChatRepository implements IChatRepository {
  static stt.SpeechToText speech = stt.SpeechToText();
  static FlutterTts flutterTts = FlutterTts();

  @override
  Future<GeneralMessageModel> sendMessage({required String question}) async {
    const apiKey = "AIzaSyD0C51kcPfgX_JDG5QZT-Z-BXM3HwMI8Oc";

    final response = await http.post(
      Uri.parse(Constants.aiEndPoint),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        "contents": [
          {
            "parts": [
              {"text": question},
            ],
          },
        ],
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final content =
          data['candidates'][0]['content']['parts'][0]['text'].trim();
      final message = GeneralMessageModel(content: content, isMe: false);
      return message;
    } else {
      throw Exception('Failed to send message');
    }
  }

  @override
  Future<void> initializeSpeechToText() async {
    await speech.initialize();
  }

  @override
  Future<void> speak({required String content}) async {
    await flutterTts.speak(content);
  }

  @override
  Future<void> stopSpeak() async {
    await flutterTts.stop();
  }
}
