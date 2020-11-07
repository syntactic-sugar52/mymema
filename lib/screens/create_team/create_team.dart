// import 'package:flutter/material.dart';
// import 'package:my_mema/screens/auth/login_container.dart';
// import 'package:my_mema/screens/home.dart';
// import 'package:provider/provider.dart';
// import 'package:my_mema/services/database.dart';
// import 'package:my_mema/screens/chat/chats.dart';
// import 'package:my_mema/states/current_user.dart';
//
// class CreateTeam extends StatefulWidget {
//   @override
//   _CreateTeamState createState() => _CreateTeamState();
// }
//
// class _CreateTeamState extends State<CreateTeam> {
//   TextEditingController _teamNameController = TextEditingController();
//
//   void _createTeam(BuildContext context, String teamName) async {
//     CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
//     String _returnString =
//         await Database().createTeam(teamName, _currentUser.getCurrentUser.uid);
//     if (_returnString == "success") {
//       Navigator.pushAndRemoveUntil(context,
//           MaterialPageRoute(builder: (context) => Home()), (route) => false);
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
//                     controller: _teamNameController,
//                     decoration: InputDecoration(
//                         prefixIcon: Icon(Icons.group), hintText: "Team Name"),
//                   ),
//                   SizedBox(
//                     height: 20.0,
//                   ),
//                   RaisedButton(
//                     child: Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 100.0),
//                       child: Text(
//                         "Create",
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 20.0,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     onPressed: () =>
//                         _createTeam(context, _teamNameController.text),
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
