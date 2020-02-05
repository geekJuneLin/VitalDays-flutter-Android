import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vital_days/pages/myaccount_screen.dart';
import 'package:vital_days/utils/auth.dart';
import 'package:vital_days/widgets/cardview.dart';
import 'package:image_picker/image_picker.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
// states
  File _image;
  List _cardViews;

  @override
  void initState() {
    super.initState();
    _cardViews = [];

    checkUsers() == false
        ? {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MyAccountPage())),
            Auth().signOut()
          }
        : print('signed in already');
  }

  // check whether there is a user signed in already
  Future<bool> checkUsers() async {
    FirebaseUser user = await Auth().getCurrent();
    return user != null ? true : false;
  }

  // sign in
  void signIn() async {
    FirebaseUser user = await Auth().signIn("test@123.com", "test1234");
    if (user != null) {
      print(user.uid);
    }
  }

// get images
  Future getImages() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
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
                GestureDetector(
                  onTap: () {
                    print('avator pressed!');
                    getImages();
                  },
                  child: CircleAvatar(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(36),
                        child: _image == null
                            ? Image.asset('assets/images/dinosaur.jpg')
                            : Image.file(_image)),
                    radius: 36,
                  ),
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
            leading: Icon(
              Icons.people,
              color: Colors.blue[200],
            ),
            title: Text(
              '我的账号',
              style: TextStyle(color: Colors.blue[200]),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyAccountPage()));
            },
          ),
          // More info
          ListTile(
            leading: Icon(
              Icons.more,
              color: Colors.blue[200],
            ),
            title: Text(
              '更多',
              style: TextStyle(color: Colors.blue[200]),
            ),
          ),
          // Settings
          ListTile(
            leading: Icon(
              Icons.settings,
              color: Colors.blue[200],
            ),
            title: Text(
              '设置',
              style: TextStyle(color: Colors.blue[200]),
            ),
          )
        ]),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Top navigation bar
      appBar: navigationBar(context),

      // Slide menu
      drawer: slideMenu(context),

      // Body
      body: ListView(
        children: _cardViews.length <= 0
            ? [
                Center(
                    heightFactor: 5,
                    child: Column(
                      children: <Widget>[
                        Image.asset(
                          'assets/images/write_note.png',
                          color: Colors.blue[200],
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Create your vital days',
                          style:
                              TextStyle(color: Colors.blue[200], fontSize: 30),
                        ),
                      ],
                    ))
              ]
            : _cardViews.map((card) => CardView()).toList(),
      ),

      // BottomNavigationTabBar
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
