import 'package:aia/chat/bloc/chat_bloc/chat_bloc.dart';
import 'package:aia/chat/bloc/speech_bloc/speech_bloc.dart';
import 'package:aia/chat/models/general_message_model.dart';
import 'package:aia/chat/widgets/animated_record_button.dart';
import 'package:aia/global/methods_helpers_functions/media_query.dart';
import 'package:aia/global/methods_helpers_functions/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendMessageBarWidget extends StatefulWidget {
  const SendMessageBarWidget({
    super.key,
    required this.controller,
    required this.onSendMessage,
    required this.chatState,
  });

  final TextEditingController controller;
  final Function(GeneralMessageModel) onSendMessage;
  final ChatState chatState;

  @override
  State<SendMessageBarWidget> createState() => _SendMessageBarWidgetState();
}

class _SendMessageBarWidgetState extends State<SendMessageBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: BlocConsumer<SpeechBloc, SpeechState>(
        listener: (context, speechState) {
          if (speechState is SpeechError) {
            ToastClass.toast(
              context: context,
              data: speechState.error,
              seconds: 3,
            );
          }

          if (speechState is SpeechRecognized) {
            String text = speechState.text;
            final message = GeneralMessageModel(content: text, isMe: true);
            widget.onSendMessage(message);
            context.read<ChatBloc>().add(SendMessage(text: text));
          }
        },
        builder: (context, speechState) {
          return Row(
            children: [
              Expanded(
                child:
                    speechState is SpeechListening
                        ? Center(child: Text("Recording Now ..."))
                        : TextField(
                          controller: widget.controller,
                          onChanged: (v) {
                            setState(() {});
                          },
                          decoration: InputDecoration(
                            labelText: 'Message',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
              ),
              SizedBox(width: MQuery.getWidth(context, 5)),

              if (widget.controller.text.trim().isEmpty)
                AnimatedRecordButton(
                  speechState: speechState,
                  onPressed: () {
                    if (speechState is SpeechListening) {
                      context.read<SpeechBloc>().add(StopListening());
                    } else {
                      context.read<SpeechBloc>().add(StartListening());
                    }
                  },
                ),

              if (widget.controller.text.trim().isNotEmpty)
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    final text = widget.controller.text.trim();
                    final message = GeneralMessageModel(
                      content: text,
                      isMe: true,
                    );
                    widget.onSendMessage(message);
                    context.read<ChatBloc>().add(SendMessage(text: text));
                  },
                ),
            ],
          );
        },
      ),
    );
  }
}
