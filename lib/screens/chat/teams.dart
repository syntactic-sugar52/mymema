// import 'package:flutter/material.dart';
// import 'package:my_mema/components/chat_item.dart';
// import 'package:my_mema/screens/create_team/create_team.dart';
// import 'package:my_mema/screens/join/join_group.dart';
//
// class Teams extends StatelessWidget {
//   @override
//   Widget build(context) {
//     void _goToJoin(context) {
//       Navigator.push(
//           context, MaterialPageRoute(builder: (context) => JoinGroup()));
//     }
//
//     void _goToCreate(context) {
//       Navigator.push(
//           context, MaterialPageRoute(builder: (context) => CreateTeam()));
//     }
//
//     return Scaffold(
//       body: Column(
//         children: [
//           // Spacer(
//           //   flex: 1,
//           // ),
//           SizedBox(
//             height: 40.0,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 40.0),
//             child: Text(
//               "Welcome to Teams",
//               textAlign: TextAlign.center,
//               style: TextStyle(fontSize: 40.0, color: Colors.grey[600]),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(30.0),
//             child: Text(
//               "Since you are not in a team, You can select either " +
//                   "to join a team or create one.",
//               textAlign: TextAlign.center,
//               style: TextStyle(fontSize: 20.0, color: Colors.grey[600]),
//             ),
//           ),
//           Spacer(
//             flex: 1,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 20.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 RaisedButton(
//                   color: Colors.white,
//                   child: Text("Create"),
//                   onPressed: () => _goToCreate(context),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20.0),
//                     side: BorderSide(color: Colors.black, width: 2),
//                   ),
//                 ),
//                 RaisedButton(
//                   color: Colors.white,
//                   child: Text("Join"),
//                   onPressed: () => _goToJoin(context),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20.0),
//                     side: BorderSide(color: Colors.black, width: 2),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
