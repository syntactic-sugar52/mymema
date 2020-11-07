import 'package:cloud_firestore/cloud_firestore.dart';

//step 1
class Cards {
  String img;
  String requirements;
  String description;
  String type;
  String views;
  String id;
  String location;
  String reason;
  String item;
  Timestamp created;

  Cards(
      {this.description,
      this.img,
      this.item,
      this.created,
      this.type,
      this.views,
      this.id,
      this.location,
      this.reason,
      this.requirements});

  factory Cards.fromDocument(DocumentSnapshot doc) {
    return Cards(
        id: doc["id"],
        type: doc["type"],
        requirements: doc["requirements"],
        reason: doc["reason"],
        views: doc["views"],
        item: doc["item"],
        description: doc["description"],
        location: doc["location"],
        created: doc["created"],
        img: doc["img"]);
  }
}
