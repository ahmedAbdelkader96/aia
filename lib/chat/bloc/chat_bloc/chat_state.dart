part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();
}

class ChatInitialState extends ChatState {
  @override
  List<Object> get props => [];
}

class LoadingToSendMessageState extends ChatState {
  @override
  List<Object> get props => [];
}

class DoneToSendMessageState extends ChatState {
  final GeneralMessageModel message;

  const DoneToSendMessageState({required this.message});

  @override
  List<Object> get props => [message];
}

class ErrorToSendMessageState extends ChatState {
  final String errorMessage;

  const ErrorToSendMessageState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
