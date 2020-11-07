import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_mema/components/progress.dart';
import 'file:///C:/Users/angka/AndroidStudioProjects/my_mema/lib/states/current_user.dart';
import 'package:my_mema/util/data.dart';
import 'package:my_mema/search.dart';
import 'package:my_mema/models/user.dart';
import 'package:my_mema/services/database.dart';
import 'package:provider/provider.dart';

class Friends extends StatefulWidget {
  @override
  _FriendsState createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
  TextEditingController searchController = TextEditingController();
  Future<QuerySnapshot> searchResultsFuture;
  String userName = "";

  clearSearch() {
    searchController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Card(
          child: TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search), hintText: 'Search...'),
            onChanged: (val) {
              setState(() {
                userName = val;
              });
            },
          ),
        ),
      ),
      body: Container(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('messages').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                    // valueColor: AlwaysStoppedAnimation<Color>(themeColor),
                    ),
              );
            } else {
              return Container(
                child: Text("snajsna"),
              );
              // return ListView.builder(
              //   padding: EdgeInsets.all(10.0),
              //   itemBuilder: (context, index) =>
              //       buildItem(context, snapshot.data.documents[index]),
              //   itemCount: snapshot.data.documents.length,
              // );
            }
          },
        ),
      ),
    );
  }
}
// buildSearchContent() {
//   CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
//   return FutureBuilder(
//       future: searchResultsFuture,
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) {
//           return circularProgress();
//         }
//         List<Text> searchResults = [];
//         snapshot.data.documents.forEach((doc) {
//           Users user = Users.fromDocument(doc);
//           // UserResult searchResult = UserResult(user);
//           searchResults.add(Text(
//             user.username,
//             style: TextStyle(color: Colors.black),
//           ));
//         });
//         return ListView(
//           children: searchResults,
//         );
//       });
// }

// buildNoContent() {
//   final Orientation orientation = MediaQuery.of(context).orientation;
//   return Container(
//       child: Center(
//     child: ListView(
//       shrinkWrap: true,
//       children: [Text("no content")],
//     ),
//   ));
// }
//
// @override
// Widget build(BuildContext context) {
//   final Orientation orientation = MediaQuery.of(context).orientation;
//   // height:orientation == Orientation.portrait ? 300.0 : 200.0
//   return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         automaticallyImplyLeading: false,
//         title: TextFormField(
//           controller: searchController,
//           decoration: InputDecoration.collapsed(
//             hintText: 'Search',
//           ),
//           onFieldSubmitted: () => handleSearch(),
//           // onSubmitted: buildSearchContent(),
//           // onChanged: (value){
//           //
//           // },
//         ),
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(
//               Icons.filter_list,
//             ),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: searchResultsFuture == null ? buildNoContent() : Text("hello")
//       // body: ListView.separated(
//       //   padding: EdgeInsets.all(10),
//       //   separatorBuilder: (BuildContext context, int index) {
//       //     return Align(
//       //       alignment: Alignment.centerRight,
//       //       child: Container(
//       //         height: 0.5,
//       //         width: MediaQuery.of(context).size.width / 1.3,
//       //         child: Divider(),
//       //       ),
//       //     );
//       //   },
//       //   itemCount: friends.length,
//       //   itemBuilder: (BuildContext context, int index) {
//       //     Map friend = friends[index];
//       //     return Padding(
//       //       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//       //       child: ListTile(
//       //         leading: CircleAvatar(
//       //           backgroundImage: AssetImage(
//       //             friend['dp'],
//       //           ),
//       //           radius: 25,
//       //         ),
//       //         contentPadding: EdgeInsets.all(0),
//       //         title: Text(friend['name']),
//       //         subtitle: Text(friend['status']),
//       //         trailing: friend['isAccept']
//       //             ? FlatButton(
//       //                 child: Text(
//       //                   "Unfollow",
//       //                   style: TextStyle(
//       //                     color: Colors.white,
//       //                   ),
//       //                 ),
//       //                 color: Colors.grey,
//       //                 onPressed: () {},
//       //               )
//       //             : FlatButton(
//       //                 child: Text(
//       //                   "Follow",
//       //                   style: TextStyle(
//       //                     color: Colors.white,
//       //                   ),
//       //                 ),
//       //                 color: Theme.of(context).accentColor,
//       //                 onPressed: () {},
//       //               ),
//       //         onTap: () {},
//       //       ),
//       //     );
//       //   },
//       // ),
//       );
// }
