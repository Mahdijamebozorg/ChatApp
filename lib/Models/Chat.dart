import 'package:flutter/material.dart';

import 'package:chatapp/Models/Message.dart';
import 'package:chatapp/Models/User.dart';

class Chat {
  List<User> users;
  List<Message> messages;
  final DateTime createdDate;

  Chat({
    required this.users,
    required this.messages,
    required this.createdDate,
  });
}
