import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class PostItem extends StatefulWidget {
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

  PostItem(
      {Key key,
      @required this.type,
      @required this.created,
      @required this.location,
      @required this.img,
      this.requirements,
      this.reason,
      this.description,
      this.id,
      this.item,
      this.views})
      : super(key: key);
  @override
  _PostItemState createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
      child: InkWell(
        child: Column(
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(
                  "",
                ),
              ),
              contentPadding: EdgeInsets.all(0),
              title: Text(
                "",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Text(
                "",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 11,
                ),
              ),
            ),

            // CarouselSlider.builder(
            //     options: CarouselOptions(
            //         autoPlay: false,
            //         enlargeCenterPage: true,
            //         viewportFraction: 10,
            //         aspectRatio: 1.5,
            //         initialPage: 2,
            //         scrollDirection: Axis.horizontal,
            //         onPageChanged: (index, reason) {
            //           setState(() {
            //             _current = index;
            //           });
            //         }),
            //     itemCount: 3,
            //     itemBuilder: (BuildContext context, int itemIndex) => Container(
            //           child: Image.asset(images[itemIndex], fit: BoxFit.cover),
            //         )),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   // crossAxisAlignment: CrossAxisAlignment.stretch,
            //   children: images.map((url) {
            //     int index = images.indexOf(url);
            //     return Container(
            //       width: 5.0,
            //       height: 5.0,
            //       margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
            //       decoration: BoxDecoration(
            //         shape: BoxShape.circle,
            //         color: _current == index
            //             ? Color.fromRGBO(0, 0, 0, 0.9)
            //             : Color.fromRGBO(0, 0, 0, 0.4),
            //       ),
            //     );
            //   }).toList(),
            // ),
            // Image.asset(
            //   "${widget.img}",
            //   height: 210,
            //   width: MediaQuery.of(context).size.width,
            //   fit: BoxFit.cover,
            // ),
            SizedBox(
              height: 7.0,
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10, left: 12),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Hair Extensions", //item
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w800),
                        ),
                        Text(
                          "Service",
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10, left: 10),
                  child: Container(
                    child: Row(
                      children: [
                        Text(
                          "Trade for Interior Designers.",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ) // summary
                      ],
                    ),
                  ),
                )
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10, left: 10),
                  child: Container(
                    child: Row(
                      children: [
                        Text(
                          "A fast and easy way to clip hair extensions.",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ) // summary
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10, left: 10),
                  child: Container(
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove_red_eye),
                          onPressed: () {},
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 6.0),
                        ),
                        Padding(padding: EdgeInsets.only(right: 30.0)),
                        IconButton(
                          icon: Icon(
                            Icons.favorite_border,
                          ),
                          onPressed: () {
                            print('pressed');
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 6.0),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 8,
            )
          ],
        ),
        onLongPress: () {
          Scaffold.of(context).openEndDrawer();
        },
        onDoubleTap: () {
          print('pressed');
        },
      ),
    );
  }
}
