// import 'package:flutter/material.dart';
// import 'package:my_mema/components/chat_item.dart';
// import 'package:my_mema/screens/chat/deal_request.dart';
// import 'package:my_mema/screens/chat/direct_message.dart';
// import 'package:my_mema/screens/chat/teams.dart';
// import 'package:my_mema/util/data.dart';
// import 'package:my_mema/states/current_user.dart';
// import 'package:my_mema/states/currentTeam.dart';
// import 'package:provider/provider.dart';
//
// class Chats extends StatefulWidget {
//   @override
//   _ChatsState createState() => _ChatsState();
// }
//
// class _ChatsState extends State<Chats>
//     with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
//   TabController _tabController;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _tabController = TabController(vsync: this, initialIndex: 0, length: 3);
//     // CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
//     // CurrentTeam _currentTeam = Provider.of<CurrentTeam>(context, listen: false);
//     // _currentTeam.updateStateFromDatabase(_currentUser.getCurrentUser.groupId);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         automaticallyImplyLeading: false,
//         title: TextField(
//           decoration: InputDecoration.collapsed(
//             hintText: 'Search',
//           ),
//         ),
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(
//               Icons.filter_list,
//             ),
//             onPressed: () {},
//           ),
//         ],
//         bottom: TabBar(
//           controller: _tabController,
//           indicatorColor: Color(0xff6886c5),
//           indicatorSize: TabBarIndicatorSize.label,
//           labelColor: Colors.black,
//           unselectedLabelColor: Theme.of(context).textTheme.caption.color,
//           isScrollable: false,
//           tabs: <Widget>[
//             Tab(
//               text: "Message",
//             ),
//             Tab(
//               text: "Teams",
//             ),
//             Tab(
//               text: "Deal Request",
//             )
//           ],
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: <Widget>[DirectMessage(), Teams(), DealRequest()],
//       ),
//       // floatingActionButton: FloatingActionButton(
//       //   heroTag: "chatbtn",
//       //   backgroundColor: Color(0xff6886c5),
//       //   child: Icon(
//       //     Icons.add,
//       //     color: Colors.white,
//       //   ),
//       //   onPressed: () {},
//       // ),
//     );
//   }
//
//   @override
//   bool get wantKeepAlive => true;
// }
