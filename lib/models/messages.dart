import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Messages {
  String messageText;
  String sender;
  bool isOnline;
  String id;
  Timestamp chatCreated;
  String dp;
  Timestamp timeSent;
  Messages(
      {this.sender,
      this.messageText,
      this.id,
      this.chatCreated,
      this.dp,
      this.timeSent});
  factory Messages.fromDocument(DocumentSnapshot doc) {
    return Messages(
        sender: doc['sender'],
        messageText: doc['messageText'],
        id: doc["Id"],
        chatCreated: doc["chatCreated"],
        dp: doc["dp"],
        timeSent: doc["timeSent"]);
  }
}
