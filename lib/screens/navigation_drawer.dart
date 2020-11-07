import 'package:flutter/material.dart';
import 'package:my_mema/screens/profile.dart';
import 'package:my_mema/screens/upload.dart';

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(children: _buildDrawerContent(context)),
      ),
    );
  }

  List<Widget> _buildDrawerContent(BuildContext context) {
    final drawerContent = <Widget>[];
    drawerContent.add(_buildDrawerHeader());
    drawerContent.addAll(_buildDrawerBody(context));
    return drawerContent;
  }

  Widget _buildDrawerHeader() {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(color: Colors.black87),
      accountName: Text('Kd Ang'),
      accountEmail: Text('e@email.com'),
      currentAccountPicture: CircleAvatar(
        backgroundImage: AssetImage('assets/cm1.jpeg'),
      ),
      onDetailsPressed: () {},
    );
  }

  List<Widget> _buildDrawerBody(BuildContext context) {
    return <Widget>[
      DrawerListTile(
        iconData: Icons.person,
        title: 'Profile',
        onTilePressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Profile()));
        },
      ),
      DrawerListTile(
        iconData: Icons.message,
        title: 'Messages',
        onTilePressed: () {},
      ),
      DrawerListTile(
        iconData: Icons.label,
        title: 'Deal Request',
        onTilePressed: () {},
      ),
      Divider(),
      DrawerListTile(
        iconData: Icons.group,
        title: 'Friends',
        onTilePressed: () {},
      ),
      DrawerListTile(
        iconData: Icons.attribution_rounded,
        title: 'Notifications',
        onTilePressed: () {},
      ),
      // DrawerListTile(
      //   iconData: Icons.arrow_circle_up,
      //   title: 'Upload',
      //   onTilePressed: () {
      //     Navigator.push(
      //         context, MaterialPageRoute(builder: (context) => Upload()));
      //   },
      // ),
      // DrawerListTile(
      //   // iconData: OMIcons.personAdd,
      //   title: 'Invite Friends',
      //   onTilePressed: () {},
      // ),
      // DrawerListTile(
      //   // iconData: OMIcons.settings,
      //   title: 'Settings',
      //   onTilePressed: () {},
      // ),
      // DrawerListTile(
      //   // iconData: OMIcons.helpOutline,
      //   title: 'Telegram FAQ',
      //   onTilePressed: () {},
      // ),
    ];
  }
}

class DrawerListTile extends StatelessWidget {
  final IconData iconData;
  final String title;
  final VoidCallback onTilePressed;

  const DrawerListTile(
      {Key key,
      @required this.iconData,
      @required this.title,
      @required this.onTilePressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      leading: Icon(iconData),
      title: Text(title, style: TextStyle(fontSize: 16)),
      onTap: onTilePressed,
    );
  }
}
