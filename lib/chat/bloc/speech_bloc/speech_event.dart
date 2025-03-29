part of 'speech_bloc.dart';

abstract class SpeechEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class StartListening extends SpeechEvent {}

class StopListening extends SpeechEvent {}

class SpeechResult extends SpeechEvent {
  final String text;

  SpeechResult(this.text);

  @override
  List<Object> get props => [text];
}
