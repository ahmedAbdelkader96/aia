import 'package:aia/chat/models/general_message_model.dart';
import 'package:aia/chat/repository/repository.dart';

class ChatController {
  final repo = ChatRepository();

  Future<GeneralMessageModel> sendMessage({required String question}) {
    return repo.sendMessage(question: question);
  }

  Future<void> initializeSpeechToText() {
    return repo.initializeSpeechToText();
  }

  Future<void> speak({required String content}) {
    return repo.speak(content: content);
  }

  Future<void> stopSpeak() {
    return repo.stopSpeak();
  }
}
