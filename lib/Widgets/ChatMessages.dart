import 'package:chatapp/Providers/Chat/Chat.dart';
import 'package:chatapp/Providers/Message.dart';
import 'package:chatapp/Providers/User.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatMessages extends StatelessWidget {
  final User currentUser;
  const ChatMessages({required this.currentUser, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final chatId = Provider.of<Chat>(context, listen: false).id;
    if (kDebugMode) print("##### State Managing: ChatMessages rebuilt");
    return Consumer<Message>(
      builder: (context, message, child) {
//seen message by current user
        message.seenMessage(currentUser, chatId);
        return Align(
//alignment
          alignment: currentUser.id == message.senderId
              ? Alignment.topRight
              : Alignment.topLeft,
//shape and color
          child: Container(
            constraints: BoxConstraints(
              minWidth: 70,
              maxWidth: MediaQuery.of(context).size.width * 0.8,
            ),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: (message.senderId == currentUser.id
                  ? const Color.fromARGB(255, 25, 86, 176)
                  : const Color.fromARGB(255, 40, 40, 55)),
              child: Stack(
                children: [
                  //text
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 12,
                      right: 12,
                      bottom: 17,
                      top: 10,
                    ),
                    child: Text(
                      message.text,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),

                  //time
                  Positioned(
                    right: 5,
                    bottom: 2,
                    child: Text(
                      //test
                      message.sendTime == null ? "" : message.sendTimePreview,
                      // message.sendTime.hour.toString() ??
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),

                  //read state
                  Positioned(
                    left: 2,
                    bottom: 2,
                    //if message has sent
                    child: (message.sendTime != null)
                        //if sender is current user
                        ? (message.senderId == currentUser.id)
                            //show read state
                            ? Icon(
                                message.usersSeen.isNotEmpty
                                    ? Icons.keyboard_double_arrow_left_sharp
                                    : Icons.arrow_back_ios_new,
                                size: 12,
                              )
                            //don't show read state
                            : Container()

                        //message hasn't sent
                        : const Icon(
                            Icons.timelapse,
                            size: 12,
                          ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
