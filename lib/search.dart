import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_mema/screens/root/root.dart';
import 'package:my_mema/models/user.dart';
import 'package:my_mema/services/database.dart';
import 'components/progress.dart';
import 'package:my_mema/states/current_user.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  Future<QuerySnapshot> searchResultsFuture;
  TextEditingController _searchController = TextEditingController();
  String searchKey;
  Stream streamQuery;

  handleSearch(String query) {
    Future<QuerySnapshot> users = FirebaseFirestore.instance
        .collection("users")
        .where("displayName", isGreaterThanOrEqualTo: query)
        // .where('userName', isLessThan: query + 'z')
        .get();
    setState(() {
      searchResultsFuture = users;
    });
  }

  clearSearch() {
    _searchController.clear();
  }

  AppBar buildSearchField() {
    return AppBar(
      backgroundColor: Colors.black87,
      title: TextFormField(
        controller: _searchController,
        decoration: InputDecoration(
            fillColor: Colors.white,
            hintText: "Search",
            filled: true,
            prefixIcon: Icon(
              Icons.search,
              size: 20.0,
            ),
            suffixIcon: IconButton(
              icon: Icon(Icons.clear),
              onPressed: () => clearSearch(),
            )),
        onFieldSubmitted: handleSearch,
      ),
    );
  }

  Container buildNoContent() {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Container(
      child: Center(
        child: ListView(children: [
          Text(
            "no content",
            textAlign: TextAlign.center,
          )
        ]),
      ),
    );
  }

  Widget _buildList(BuildContext context, DocumentSnapshot document) {
    return GestureDetector(
      onTap: () => print('tapped'),
      child: ListTile(
        leading: CircleAvatar(),
        title: Text(document['displayName']),
        subtitle: Text(document['userName']),
      ),
    );
  }

  buildSearchResults() {
    return FutureBuilder(
      future: searchResultsFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return circularProgress();
        }
        List<UserResult> searchResuts = [];
        snapshot.data.documents.forEach((doc) {
          Users user = Users.fromDocument(doc);
          UserResult userResult = UserResult(
            user: user,
          );
          searchResuts.add(userResult);
        });
        return ListView(
          children: searchResuts,
        );
      },
    );
  }
  //
  // buildSearchResults() {
  //   return StreamBuilder(
  //       stream: FirebaseFirestore.instance
  //           .collection("users")
  //           .where("userName")
  //           .snapshots(),
  //       builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
  //         if (!snapshot.hasData) {
  //           return circularProgress();
  //         }
  //         return ListView.builder(
  //           itemBuilder: (context, index) =>
  //               _buildList(context, snapshot.data.docs[index]),
  //           itemCount: snapshot.data.docs.length,
  //         );
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildSearchField(),
      body:
          searchResultsFuture == null ? buildNoContent() : buildSearchResults(),
    );
  }
}

class UserResult extends StatelessWidget {
  final Users user;
  final Widget buildTile;
  UserResult({this.user, this.buildTile});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white54,
      child: Column(
        children: [
          GestureDetector(
            onTap: () => print("ontap"),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.grey,
                backgroundImage: CachedNetworkImageProvider(user.photoUrl),
              ),
              title: Text(
                user.displayName,
                style: TextStyle(
                    color: Colors.black87, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                user.username,
                style: TextStyle(
                    color: Colors.black87, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Divider(
            height: 2.0,
            color: Colors.white54,
          )
        ],
      ),
    );
  }
}
