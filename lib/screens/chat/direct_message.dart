// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:my_mema/components/chat_item.dart';
// import 'package:my_mema/screens/auth/login_container.dart';
// import 'package:my_mema/screens/chat/conversations.dart';
// import 'package:my_mema/states/current_user.dart';
// import 'package:provider/provider.dart';
// import 'package:my_mema/services/database.dart';
//
// final _firestore = FirebaseFirestore.instance;
// User loggedInUser;
//
// class DirectMessage extends StatefulWidget {
//   @override
//   _DirectMessageState createState() => _DirectMessageState();
// }
//
// class _DirectMessageState extends State<DirectMessage> {
//   final _messageTextController = TextEditingController();
//
//   List<dynamic> groups = [];
//
//   void _createMessage(BuildContext context, String messageText) async {
//     CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
//     String _returnString = await Database()
//         .createTeam(messageText, _currentUser.getCurrentUser.uid);
//     if (_returnString == "success") {
//       print(messageText);
//       // Navigator.pushAndRemoveUntil(
//       //     context,
//       //     MaterialPageRoute(builder: (context) => Conversation()),
//       //         (route) => false);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: LoginContainer(
//         child: Row(
//           children: [Text(_messageTextController.text)],
//         ),
//       ),
//     );
//   }
// }
