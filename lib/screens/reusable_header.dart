import 'package:flutter/material.dart';

AppBar reusableHeader(context, {bool isTab}) {
  return AppBar(
    // flexibleSpace: Column(
    //   mainAxisAlignment: MainAxisAlignment.end,
    //   children: [
    //     TabBar(
    //       tabs: [Text("Social"), Text("Commerce")],
    //     )
    //   ],
    // ),
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(35.0),
      child: Container(
        color: Colors.white,
        child: TabBar(
          labelColor: Colors.black,
          indicatorColor: Color(0xff6886c5),
          indicatorSize: TabBarIndicatorSize.label,
          tabs: [
            Tab(child: Text(isTab ? 'Social' : '')),
            Tab(
              child: Text(isTab ? 'Commerce' : ''),
            )
          ],
        ),
      ),
    ),

    backgroundColor: Colors.black,
    title: Text(
      "mema",
      style: TextStyle(color: Colors.white),
    ),
  );
}
