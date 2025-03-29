import 'package:aia/chat/repository/repository.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'speech_event.dart';

part 'speech_state.dart';

class SpeechBloc extends Bloc<SpeechEvent, SpeechState> {
  final speech = ChatRepository.speech;
  final AudioPlayer audioPlayer = AudioPlayer();

  SpeechBloc() : super(SpeechInitial()) {
    on<StartListening>((event, emit)  {
      emit(SpeechListening());
      try {
        bool available = speech.isAvailable;

        if (available) {
          audioPlayer.play(AssetSource('start_record.mp3'));
          speech.listen(
            onResult: (result) {
              if (result.finalResult) {
                add(SpeechResult(result.recognizedWords));
              }
            },
          );
        } else {
          emit(SpeechError("Speech recognition not available"));
        }
      } catch (e) {
        emit(SpeechError(e.toString()));
      }
    });

    on<StopListening>((event, emit) async {
      if (speech.hasRecognized) {
        await speech.stop();
        emit(SpeechInitial());
      } else {
        await speech.stop();
        emit(SpeechError("No words recognized"));
      }
    });

    on<SpeechResult>((event, emit) {
      emit(SpeechRecognized(text: event.text));
    });
  }
}
