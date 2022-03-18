import 'package:chatapp/Providers/Message.dart';
import 'package:chatapp/Providers/User.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatMessages extends StatelessWidget {
  final User currentUser;
  const ChatMessages({required this.currentUser, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Message>(builder: (context, message, child) {
      //seen message by current user
      //await???
      message.seenMessage(currentUser);
      return Align(
        alignment: currentUser.id == message.senderId
            ? Alignment.topRight
            : Alignment.topLeft,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: (message.senderId == currentUser.id
              ? Colors.blue[700]
              : Colors.grey.shade700),
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  message.text,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              Positioned(
                right: 5,
                bottom: 2,
                child: Text(
                  //test
                  "22:53",
                  // message.sendTime.hour.toString() ??
                  //     "TimeError",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              Positioned(
                left: 2,
                bottom: 2,
                child: message.senderId == currentUser.id
                    ? Icon(
                        message.usersSeen.isNotEmpty
                            ? Icons.keyboard_double_arrow_left_sharp
                            : Icons.arrow_back_ios_new,
                        size: 10,
                      )
                    : Container(),
              )
            ],
          ),
        ),
      );
    });
  }
}
