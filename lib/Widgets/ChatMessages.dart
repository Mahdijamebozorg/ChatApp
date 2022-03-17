import 'package:chatapp/Providers/Chat/Chat.dart';
import 'package:chatapp/Providers/User.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatefulWidget {
  final Chat chat;
  final User currentUser;
  const ChatMessages({required this.chat, required this.currentUser, Key? key})
      : super(key: key);

  @override
  State<ChatMessages> createState() => _ChatMessagesState();
}

class _ChatMessagesState extends State<ChatMessages> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.chat.messages.length,
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      itemBuilder: (context, index) => Align(
        alignment: widget.currentUser.id == widget.chat.messages[index].senderId
            ? Alignment.topRight
            : Alignment.topLeft,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: (widget.chat.messages[index].senderId == widget.currentUser.id
              ? Colors.blue[700]
              : Colors.grey.shade700),
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  widget.chat.messages[index].text,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              Positioned(
                right: 5,
                bottom: 2,
                child: Text(
                  //test
                  "22:53",
                  // chat.messages[index].sendTime.hour.toString() ??
                  //     "TimeError",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              Positioned(
                left: 2,
                bottom: 2,
                child: widget.chat.messages[index].senderId ==
                        widget.currentUser.id
                    ? Icon(
                        widget.chat.messages[index].usersSeen.isNotEmpty
                            ? Icons.keyboard_double_arrow_left_sharp
                            : Icons.arrow_back_ios_new,
                        size: 10,
                      )
                    : Container(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
