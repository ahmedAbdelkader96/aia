part of 'speech_bloc.dart';

abstract class SpeechState extends Equatable {
  @override
  List<Object> get props => [];
}

class SpeechInitial extends SpeechState {}

class SpeechListening extends SpeechState {}

class SpeechRecognized extends SpeechState {
  final String text;

  SpeechRecognized({required this.text});

  @override
  List<Object> get props => [text];
}

class SpeechError extends SpeechState {
  final String error;

  SpeechError(this.error);

  @override
  List<Object> get props => [error];
}
