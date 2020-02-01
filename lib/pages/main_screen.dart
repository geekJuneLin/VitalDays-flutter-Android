import 'package:flutter/material.dart';
import 'package:vital_days/pages/create_screen.dart';
import 'package:vital_days/pages/myaccount_screen.dart';
import 'package:vital_days/widgets/cardview.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

Widget navigationBar(context) => AppBar(
      centerTitle: false,
      title:
          // Title
          Text('Vital Days'),
      actions: <Widget>[
        // Create button
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            print('create btn pressed!');
            Navigator.pushNamed(context, '/createDay');
          },
        )
      ],
    );

Widget get bottomNavigationBar => BottomNavigationBar(
      items: [
        // Home
        BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),

        // Share
        BottomNavigationBarItem(icon: Icon(Icons.share), title: Text('Share'))
      ],
    );

Widget slideMenu(context) => Drawer(
      child: ListView(padding: EdgeInsets.zero, children: <Widget>[
        // Top header section
        DrawerHeader(
          decoration: BoxDecoration(color: Colors.blue),
          child: Column(
            children: <Widget>[
              CircleAvatar(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(36),
                    child: Image.asset('assets/images/dinosaur.jpg')),
                radius: 36,
              ),
              SizedBox(
                height: 16,
              ),
              Divider(
                color: Colors.white,
                height: 1,
              )
            ],
          ),
        ),

        // My account
        ListTile(
          leading: Icon(Icons.people),
          title: Text('我的账号'),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MyAccountPage()));
          },
        ),
        // More info
        ListTile(
          leading: Icon(Icons.more),
          title: Text('更多'),
        ),
        // Settings
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('设置'),
        )
      ]),
    );

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Top navigation bar
      appBar: navigationBar(context),

      // Slide menu
      drawer: slideMenu(context),

      // Body
      body: ListView(
        children: <Widget>[CardView(), CardView(), CardView()],
      ),

      // BottomNavigationTabBar
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
