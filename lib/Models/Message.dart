class Message {
  ///message text
  String text;

  ///message sending time
  final sendTime;

  ///is this message edited by user
  bool isEdited;

  ///a list of id of users who seen this message with seen time
  Map<String, DateTime> usersSeen;

  Message({
    required this.text,
    required this.sendTime,
    this.isEdited = false,
    this.usersSeen = const {},
  });
}
