import 'package:aia/chat/bloc/chat_bloc/chat_bloc.dart';
import 'package:aia/chat/models/general_message_model.dart';
import 'package:aia/chat/widgets/messages_list.dart';
import 'package:aia/chat/widgets/send_message_bar_widget.dart';
import 'package:aia/chat/widgets/shimmer_message.dart';
import 'package:aia/global/methods_helpers_functions/media_query.dart';
import 'package:aia/global/methods_helpers_functions/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController controller = TextEditingController();
  List<GeneralMessageModel> messages = [];
  final ScrollController scrollController = ScrollController();
  FlutterTts flutterTts = FlutterTts();

  @override
  void dispose() {
    controller.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.jumpTo(scrollController.position.minScrollExtent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: MQuery.getWidth(context, 16)),
        child: BlocConsumer<ChatBloc, ChatState>(
          listener: (context, chatState) async {
            if (chatState is ErrorToSendMessageState) {
              ToastClass.toast(
                context: context,
                data: chatState.errorMessage,
                seconds: 3,
              );
            }

            if (chatState is DoneToSendMessageState) {
              setState(() {
                messages.insert(0, chatState.message);
              });
              scrollToBottom();
            }
          },
          builder: (context, chatState) {
            return Column(
              children: [
                SizedBox(height: MQuery.getheight(context, 45)),
                Text(
                  "AIA AI",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 22,
                    color: Colors.green,
                  ),
                ),
                SizedBox(height: MQuery.getheight(context, 10)),

                Expanded(
                  child: MessagesList(
                    messages: messages,
                    scrollController: scrollController,
                  ),
                ),

                if (chatState is LoadingToSendMessageState)
                  SizedBox(height: 15),
                if (chatState is LoadingToSendMessageState) ShimmerMessage(),

                SizedBox(height: MQuery.getheight(context, 10)),
                SendMessageBarWidget(
                  chatState: chatState,
                  controller: controller,
                  onSendMessage: (questionMessage) {
                    messages.insert(0, questionMessage);
                    controller.clear();
                    setState(() {});
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
