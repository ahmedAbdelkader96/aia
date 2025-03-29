import 'package:aia/chat/controller/controller.dart';
import 'package:aia/chat/models/general_message_model.dart';
import 'package:aia/chat/repository/repository.dart';
import 'package:aia/global/methods_helpers_functions/media_query.dart';
import 'package:flutter/material.dart';

class MessagesList extends StatefulWidget {
  const MessagesList({
    super.key,
    required this.messages,
    required this.scrollController,
  });

  final List<GeneralMessageModel> messages;
  final ScrollController scrollController;

  @override
  State<MessagesList> createState() => _MessagesListState();
}

class _MessagesListState extends State<MessagesList> {
  bool isPlaying = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ChatRepository.flutterTts.setStartHandler(() {
      setState(() {
        print("Playing");
        isPlaying = true;
      });
    });

    ChatRepository.flutterTts.setCancelHandler(() {
      setState(() {
        print("Cancel");
        isPlaying = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: widget.scrollController,
      reverse: true,
      itemCount: widget.messages.length,
      itemBuilder: (context, index) {
        GeneralMessageModel message = widget.messages[index];

        return Row(
          mainAxisAlignment:
              message.isMe == true
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              constraints: BoxConstraints(
                minWidth: 80,
                maxWidth: MQuery.getWidth(context, 260),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color:
                    message.isMe == true
                        ? Colors.blueGrey.shade100
                        : Colors.cyan.shade50,
              ),
              child: Text(message.content, textAlign: TextAlign.start),
            ),
            IconButton(
              onPressed: () async {
                final controller = ChatController();
                if (isPlaying) {
                  await controller.stopSpeak();
                } else {
                  await controller.speak(content: message.content);
                }
              },
              icon: Icon(Icons.volume_up),
            ),
          ],
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: 15);
      },
    );
  }
}
