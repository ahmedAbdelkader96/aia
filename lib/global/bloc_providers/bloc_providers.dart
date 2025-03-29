import 'package:aia/chat/bloc/chat_bloc/chat_bloc.dart';
import 'package:aia/chat/bloc/speech_bloc/speech_bloc.dart';
import 'package:aia/chat/controller/controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocProviders {
  static final List<BlocProvider> providers = [
    BlocProvider<ChatBloc>(create: (_) => ChatBloc(ChatController())),
    BlocProvider<SpeechBloc>(create: (_) => SpeechBloc()),
  ];
}
