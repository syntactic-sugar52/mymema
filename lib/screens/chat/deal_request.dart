// import 'package:flutter/material.dart';
// import 'package:my_mema/components/chat_item.dart';
//
// class DealRequest extends StatelessWidget {
//   List<dynamic> groups = [];
//   @override
//   Widget build(BuildContext context) {
//     return ListView.separated(
//       padding: EdgeInsets.all(10),
//       separatorBuilder: (BuildContext context, int index) {
//         return Align(
//           alignment: Alignment.centerRight,
//           child: Container(
//             height: 0.5,
//             width: MediaQuery.of(context).size.width / 1.3,
//             child: Divider(),
//           ),
//         );
//       },
//       itemCount: 2,
//       itemBuilder: (BuildContext context, int index) {
//         Map chat = groups[index];
//         return ChatItem(
//           dp: chat['dp'],
//           name: chat['name'],
//           isOnline: chat['isOnline'],
//           counter: chat['counter'],
//           msg: chat['msg'],
//           time: chat['time'],
//         );
//       },
//     );
//   }
// }
