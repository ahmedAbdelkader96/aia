import 'package:aia/chat/controller/controller.dart';
import 'package:aia/chat/models/general_message_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_event.dart';

part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatController controller;

  static ChatBloc get(BuildContext context) {
    return BlocProvider.of(context);
  }

  ChatBloc(this.controller) : super(ChatInitialState()) {
    on<SendMessage>(_onSendMessage);
  }

  Future<void> _onSendMessage(
    SendMessage event,
    Emitter<ChatState> emit,
  ) async {
    try {
      emit(LoadingToSendMessageState());

      GeneralMessageModel message = await controller.sendMessage(
        question: event.text,
      );

      emit(DoneToSendMessageState(message: message));
    } catch (e) {
      emit(ErrorToSendMessageState(errorMessage: e.toString()));
    }
  }
}
