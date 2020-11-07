import 'package:cloud_firestore/cloud_firestore.dart';

class Teams {
  String id;
  String name;
  String leader;
  List<String> members;
  Timestamp groupCreated;
  String message;
  String cardId;
  Timestamp timeCardWasSent;
  Teams(
      {this.id,
      this.name,
      this.leader,
      this.members,
      this.message,
      this.cardId,
      this.timeCardWasSent,
      this.groupCreated});
  factory Teams.fromDocument(DocumentSnapshot doc) {
    return Teams(
        id: doc["id"],
        name: doc["name"],
        leader: doc["leader"],
        members: doc["members"],
        groupCreated: doc["groupCreated"],
        message: doc["message"],
        cardId: doc["cardId"],
        timeCardWasSent: doc["timeCardWasSent"]);
  }
}
