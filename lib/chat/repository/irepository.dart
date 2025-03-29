import 'package:aia/chat/models/general_message_model.dart';

abstract class IChatRepository {
  Future<GeneralMessageModel> sendMessage({required String question});

  Future<void> initializeSpeechToText();

  Future<void> speak({required String content});

  Future<void> stopSpeak();
}
