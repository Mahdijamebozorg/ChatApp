import 'package:flutter/material.dart';

const Color backGround = Color.fromARGB(255, 46, 45, 45);

class ChatInputs extends StatefulWidget {
  final Function addMessage;
  const ChatInputs({
    required this.addMessage,
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
              onSubmitted: (text) {},
            ),
          ),

          _textController.text.isNotEmpty
              //send message
              ? IconButton(
                  icon: const Icon(
                    Icons.send,
                  ),
                  color: Theme.of(context).primaryIconTheme.color,
                  highlightColor: Theme.of(context).scaffoldBackgroundColor,
                  splashColor: Theme.of(context).scaffoldBackgroundColor,
                  onPressed: () {},
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
