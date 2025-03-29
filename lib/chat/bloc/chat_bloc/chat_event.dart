part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent extends Equatable {
  const ChatEvent();
}

class SendMessage extends ChatEvent {
  final String text;

  const SendMessage({required this.text});

  @override
  List<Object?> get props => [];
}
