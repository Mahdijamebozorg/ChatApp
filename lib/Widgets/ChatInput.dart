import 'package:flutter/material.dart';

class ChatInputs extends StatefulWidget {
  const ChatInputs({Key? key}) : super(key: key);

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
      height: 45,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Card(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Center(
          child: Row(
            children: <Widget>[
              //emoji
              IconButton(
                icon: const Icon(Icons.emoji_emotions),
                color: Theme.of(context).primaryIconTheme.color,
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
                  decoration: InputDecoration(
                    hintText: "Message...",
                    hintStyle: Theme.of(context).textTheme.bodySmall,
                    border: InputBorder.none,
                  ),
                  controller: _textController,
                  onSubmitted: (text) {},
                  focusNode: _textFocus,
                  onEditingComplete: () {
                    _textFocus.dispose();
                  },
                  onTap: () {
                    _textFocus.requestFocus();
                  },
                ),
              ),

              _textController.text.isNotEmpty
                  //send message
                  ? IconButton(
                      icon: const Icon(
                        Icons.send,
                      ),
                      color: Theme.of(context).primaryIconTheme.color,
                      onPressed: () {},
                    )
                  //other inputs
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.link),
                          color: Theme.of(context).primaryIconTheme.color,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.record_voice_over),
                          color: Theme.of(context).primaryIconTheme.color,
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
