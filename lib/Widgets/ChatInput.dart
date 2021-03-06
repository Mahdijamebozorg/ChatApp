import 'package:chatapp/Providers/Chat/Chat.dart';
import 'package:chatapp/Providers/Message.dart';
import 'package:chatapp/Providers/User.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const Color backGround = Color.fromARGB(255, 46, 45, 45);

class ChatInputs extends StatefulWidget {
  final User currentUser;
  const ChatInputs({
    required this.currentUser,
    Key? key,
  }) : super(key: key);

  @override
  State<ChatInputs> createState() => _ChatInputsState();
}

class _ChatInputsState extends State<ChatInputs> {
  FocusNode _textFocus = FocusNode();
  TextEditingController _textController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _textController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _textFocus.dispose();
    super.dispose();
  }

  bool _checkInput(String text) {
    if (text.isEmpty) return false;
    for (var char in text.characters) {
      if (char != ' ' && char != '\n') return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 50,
      decoration: const BoxDecoration(
        color: backGround,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          //emoji
          IconButton(
            icon: const Icon(
              Icons.emoji_emotions,
            ),
            color: Theme.of(context).primaryIconTheme.color,
            highlightColor: Theme.of(context).scaffoldBackgroundColor,
            splashColor: Theme.of(context).scaffoldBackgroundColor,
            onPressed: () {},
          ),

          //textField
          Expanded(
            child: TextField(
              keyboardType: TextInputType.multiline,
              // textInputAction: TextInputAction.newline,
              maxLines: null,
              // expands: true,
              decoration: InputDecoration(
                hintText: "Message...",
                hintStyle: Theme.of(context).textTheme.bodySmall,
                border: InputBorder.none,
              ),
              controller: _textController,
              focusNode: _textFocus,
            ),
          ),

          _checkInput(_textController.text)
              //send message
              ? IconButton(
                  icon: const Icon(
                    Icons.send,
                  ),
                  color: Theme.of(context).primaryIconTheme.color,
                  highlightColor: Theme.of(context).scaffoldBackgroundColor,
                  splashColor: Theme.of(context).scaffoldBackgroundColor,
                  //send message
                  onPressed: () {
                    final chat = Provider.of<Chat>(context, listen: false);
                    if (chat.canSendMessage(widget.currentUser)) {
                      chat.sendMessage(
                        Message(
                          chat.idGearator(),
                          _textController.text,
                          widget.currentUser.id,
                          DateTime.now(),
                          false,
                          {},
                        ),
                        widget.currentUser,
                      );
                      //show error
                    } else {
                      Scaffold.of(context).showBottomSheet(
                        (context) => const Center(
                          child: Card(
                            child: Text("Can't send Message"),
                          ),
                        ),
                      );
                    }
                    _textController.clear();
                  },
                )
              //other inputs
              : Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.link),
                      color: Theme.of(context).primaryIconTheme.color,
                      highlightColor: Theme.of(context).scaffoldBackgroundColor,
                      splashColor: Theme.of(context).scaffoldBackgroundColor,
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.record_voice_over),
                      color: Theme.of(context).primaryIconTheme.color,
                      highlightColor: Theme.of(context).scaffoldBackgroundColor,
                      splashColor: Theme.of(context).scaffoldBackgroundColor,
                      onPressed: () {},
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
