import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vital_days/pages/create_screen.dart';
import 'package:vital_days/pages/my_account.dart';
import 'package:vital_days/pages/myaccount_screen.dart';
import 'package:vital_days/utils/auth.dart';
import 'package:vital_days/widgets/cardview.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vital_days/model/event.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
// states
  File _image;
  List<VitalEvent> _cardViews;
  String _uid;

  final _auth = Auth();
  var _ref = FirebaseDatabase().reference();

  @override
  void initState() {
    super.initState();
    _cardViews = [];

    // data fetching test
    _fetchData();
  }

  // fetch data from firestore
  _fetchData() async {
    await _auth.getCurrentUser().then((user) {
      _uid = user.uid;
    });
    if (_uid != null) {
      print('retreiving data...');
      List<VitalEvent> events = [];
      int diff = 0;
      _ref.child("Events").child(_uid).once().then((DataSnapshot snapshot) {
        snapshot.value.forEach((key, value) => {
              print(value["note"]),

              // calculate the difference between targetDate and today
              diff = _calculateDiff(
                  DateFormat("yyyy-MM-dd").parse(value["targetDate"])),
              print("the diff: $diff"),

              // check the current days left if is equal to the calculated diff
              // if not, then update the diff onto database and display it on the screen
              diff = _updateDaysLeft(value["leftDays"], diff, key)
                  ? diff
                  : value["leftDays"],

              events.add(VitalEvent(
                  note: value["note"],
                  noteType: value["noteType"],
                  targetDate: value["targetDate"],
                  daysLeft: diff))
            });

        // set the state
        setState(() {
          _cardViews = events;
        });
      });
    } else {
      print('no uid found!');
    }
  }

  // check if the diff needed to be updated onto DB
  bool _updateDaysLeft(int curr, int diff, String key) {
    if (curr != diff) {
      _updateOntoDB(diff, key);
      return true;
    } else {
      return false;
    }
  }

  // update the diff onto DB
  _updateOntoDB(int days, String key) {
    print("updating the child path of: $key");
    _ref.child("Events").child(_uid).child(key).update({
      "leftDays": days,
    });
  }

  // calculate the difference between today and target date
  int _calculateDiff(DateTime target) {
    return (-DateTime.now().difference(target).inDays) + 1;
  }

  // check if there is a current user
  FirebaseUser _checkingUser() {
    FirebaseUser user = Provider.of<FirebaseUser>(context, listen: false);
    return user != null ? user : null;
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => CreateDayScreen()));
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
              dynamic user = _checkingUser();

              if (user == null) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyAccountPage()));
              } else {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyAccount()));
              }
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
            : _cardViews
                .map((card) => CardView(
                      note: card.note,
                      noteType: card.noteType,
                      targetDate: card.targetDate,
                      daysLeft: card.daysLeft,
                    ))
                .toList(),
      ),

      // BottomNavigationTabBar
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
