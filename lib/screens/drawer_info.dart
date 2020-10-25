import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'bottom_sheet.dart';
import 'package:my_mema/models/cards.dart';

class DrawerInfo extends StatelessWidget {
  List<Cards> drawerItems = [
    Cards(
        item: "Hair Extensions",
        description:
            "Bacon ipsum dolor amet chislic swine strip steak, doner porchetta ground round jerky burgdoggen. Flank chislic chicken cupim. Chicken ball tip ribeye frankfurter doner. Andouille shank kevin drumstick tenderloin.",
        id: 1,
        type: "Product for Service",
        location: "Manila, Philippines",
        reason:
            "Bacon ipsum dolor amet chislic swine strip steak, doner porchetta ground round jerky burgdoggen. Flank chislic chicken cupim. Chicken ball tip ribeye frankfurter doner. Andouille shank kevin drumstick tenderloin.",
        requirements:
            "Chuck picanha jowl t-bone chislic venison rump ribeye chicken beef hamburger. Salami burgdoggen landjaeger, ham hock capicola andouille pork belly doner cow biltong pork loin. Fatback corned beef swine drumstick. Turducken short ribs turkey swine, sirloin pancetta pork shankle cow burgdoggen. Chislic ham hock tri-tip jowl meatball capicola pork loin kielbasa tail ball tip tenderloin strip steak.",
        views: 3,
        img: "assets/cm9.jpeg"),
    Cards(
        item: "Hair Extensions",
        description:
            "Bacon ipsum dolor amet chislic swine strip steak, doner porchetta ground round jerky burgdoggen. Flank chislic chicken cupim. Chicken ball tip ribeye frankfurter doner. Andouille shank kevin drumstick tenderloin.",
        id: 2,
        type: "Product for Product",
        location: "Manila, Philippines",
        reason:
            "Bacon ipsum dolor amet chislic swine strip steak, doner porchetta ground round jerky burgdoggen. Flank chislic chicken cupim. Chicken ball tip ribeye frankfurter doner. Andouille shank kevin drumstick tenderloin.",
        requirements:
            "Chuck picanha jowl t-bone chislic venison rump ribeye chicken beef hamburger. Salami burgdoggen landjaeger, ham hock capicola andouille pork belly doner cow biltong pork loin. Fatback corned beef swine drumstick. Turducken short ribs turkey swine, sirloin pancetta pork shankle cow burgdoggen. Chislic ham hock tri-tip jowl meatball capicola pork loin kielbasa tail ball tip tenderloin strip steak.",
        views: 3,
        img: "assets/cm9.jpeg"),
    Cards(
        item: "Hair Extensions",
        description:
            "Bacon ipsum dolor amet chislic swine strip steak, doner porchetta ground round jerky burgdoggen. Flank chislic chicken cupim. Chicken ball tip ribeye frankfurter doner. Andouille shank kevin drumstick tenderloin.",
        id: 3,
        type: "Product for Investment",
        location: "Manila, Philippines",
        reason:
            "Bacon ipsum dolor amet chislic swine strip steak, doner porchetta ground round jerky burgdoggen. Flank chislic chicken cupim. Chicken ball tip ribeye frankfurter doner. Andouille shank kevin drumstick tenderloin.",
        requirements:
            "Chuck picanha jowl t-bone chislic venison rump ribeye chicken beef hamburger. Salami burgdoggen landjaeger, ham hock capicola andouille pork belly doner cow biltong pork loin. Fatback corned beef swine drumstick. Turducken short ribs turkey swine, sirloin pancetta pork shankle cow burgdoggen. Chislic ham hock tri-tip jowl meatball capicola pork loin kielbasa tail ball tip tenderloin strip steak.",
        views: 3,
        img: "assets/cm9.jpeg")
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      left: true,
      right: true,
      bottom: true,
      top: true,
      child: Container(
        color: Color(0xff757575),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(9.0)),
          child: Drawer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              // mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(
                  height: 80,
                  child: DrawerHeader(
                    padding: EdgeInsets.only(top: 10.0, left: 10.0),
                    // decoration: BoxDecoration(color: Colors.red),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(3.0),
                          child: Row(
                            children: [
                              Text(
                                drawerItems[0].item,
                                style: TextStyle(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.w800),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(top: 1.0, bottom: 2.0, left: 2.0),
                          child: Row(
                            children: [Text(drawerItems[0].location)],
                          ),
                        ),
                        Divider(
                          color: Colors.black,
                          thickness: 2,
                          height: 7,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      padding: EdgeInsets.only(top: 0.0),
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ListTile(
                              title: Text(
                                "Card Details :",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18.0),
                              ),
                            ),
                            ListTile(
                              title: Text(
                                drawerItems[0].type,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15.0),
                              ),
                              leading: Icon(Icons.autorenew),
                            ),
                            ListTile(
                              title: Text(
                                drawerItems[0].description,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15.0),
                              ),
                              leading: Icon(Icons.description),
                            ),
                            ListTile(
                              title: Text(
                                "Preferred trade :",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18.0),
                              ),
                            ),
                            ListTile(
                              title: Text(
                                drawerItems[0].requirements,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15.0),
                              ),
                              leading: Icon(Icons.compare_arrows),
                            ),
                            // ListTile(
                            //   title: Text(
                            //     drawerItems[0].reason,
                            //     style: TextStyle(
                            //         fontWeight: FontWeight.w500, fontSize: 15.0),
                            //   ),
                            // ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        );
                      }),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: RaisedButton(
                    padding: EdgeInsets.only(
                        top: 15, bottom: 15, left: 100, right: 100),
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) => BuildBottomSheet());
                    },
                    elevation: 5,
                    textColor: Colors.white,
                    color: Color(0xfff1935c),
                    child: Text(
                      "Trade",
                      style: TextStyle(
                          fontSize: 17.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 7.0,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
