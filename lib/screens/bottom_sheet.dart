import 'package:flutter/material.dart';
import 'trade.dart';
class BuildBottomSheet extends StatefulWidget {
  @override
  _BuildBottomSheetState createState() => _BuildBottomSheetState();
}

class _BuildBottomSheetState extends State<BuildBottomSheet> {
  final bool isClicked = false;
  Color _color = Colors.red;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: CustomScrollView(
          primary: false,
          slivers: <Widget>[
            SliverPadding(
              padding: const EdgeInsets.all(10),
              sliver: SliverGrid.count(
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      setState(() {
                        if (!isClicked) {
                          // _color = Colors.green;
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Trade()));
                        }
                      });
                      print("tapped card");
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: Image.asset("assets/cm0.jpeg"),
                      // decoration:
                      // BoxDecoration(border: Border.all(color: _color)),
                      // color: Colors.green[100],
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: Image.asset('assets/cm1.jpeg'),
                      // color: Colors.green[200],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: Image.asset('assets/cm4.jpeg'),
                    // color: Colors.green[300],
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: Image.asset('assets/cm9.jpeg'),
                    // color: Colors.green[400],
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: Image.asset('assets/cm5.jpeg'),
                    // color: Colors.green[500],
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: Image.asset('assets/cm4.jpeg'),
                    // color: Colors.green[600],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
