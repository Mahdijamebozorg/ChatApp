import 'dart:html';

import 'package:flutter/material.dart';

class ChatInputs extends StatelessWidget {
  const ChatInputs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController? textController;
    FocusNode? _textFocus;
    return Container(
      height: 45,
      decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
      child: Row(
        children: <Widget>[
          //emoji
          IconButton(
            icon: const Icon(Icons.emoji_emotions),
            onPressed: () {},
          ),

          //textField
          Expanded(
            child: TextField(
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              minLines: null,
              maxLines: null,
              expands: true,
              decoration: const InputDecoration(
                hintText: "Message...",
                hintStyle: TextStyle(color: Colors.black54),
                border: InputBorder.none,
              ),
              controller: textController,
              onSubmitted: (text) {},
              focusNode: _textFocus,
            ),
          ),

          _textFocus!.hasFocus
              ?
              //other inputs
              Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.record_voice_over),
                    ),
                  ],
                )
              //send message
              : IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {},
                ),
        ],
      ),
    );
  }
}
