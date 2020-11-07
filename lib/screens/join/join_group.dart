// import 'package:flutter/material.dart';
// import 'package:my_mema/screens/auth/login_container.dart';
// import 'package:provider/provider.dart';
// import 'file:///C:/Users/angka/AndroidStudioProjects/my_mema/lib/states/current_user.dart';
// import 'package:my_mema/services/database.dart';
// import 'package:my_mema/screens/chat/chats.dart';
//
// class JoinGroup extends StatefulWidget {
//   @override
//   _JoinGroupState createState() => _JoinGroupState();
// }
//
// class _JoinGroupState extends State<JoinGroup> {
//   TextEditingController _teamIdController = TextEditingController();
//   void _joinTeam(BuildContext context, String teamId) async {
//     CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
//     String _returnString =
//         await Database().joinTeam(teamId, _currentUser.getCurrentUser.uid);
//     if (_returnString == "success") {
//       Navigator.pushAndRemoveUntil(context,
//           MaterialPageRoute(builder: (context) => Chats()), (route) => false);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.all(20.0),
//             child: Row(
//               children: [BackButton()],
//             ),
//           ),
//           Spacer(),
//           Padding(
//             padding: EdgeInsets.all(20.0),
//             child: LoginContainer(
//               child: Column(
//                 children: [
//                   TextFormField(
//                     controller: _teamIdController,
//                     decoration: InputDecoration(
//                         prefixIcon: Icon(Icons.group), hintText: "Team Id"),
//                   ),
//                   SizedBox(
//                     height: 20.0,
//                   ),
//                   RaisedButton(
//                     onPressed: () => _joinTeam(context, _teamIdController.text),
//                     child: Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 100.0),
//                       child: Text(
//                         "Join",
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 20.0,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
