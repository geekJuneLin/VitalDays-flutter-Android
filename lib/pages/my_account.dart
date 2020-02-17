import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:vital_days/pages/myaccount_screen.dart';
import 'package:vital_days/utils/auth.dart';

class MyAccount extends StatefulWidget {
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  final _auth = Auth();
  final _ref = FirebaseDatabase().reference();

  String _uid;
  String _name;
  String _email;

  @override
  void initState() {
    super.initState();

    _retriveInfo();
  }

  Widget _inforRow(title, value) {
    return Container(
        decoration: BoxDecoration(color: Colors.white12),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "$title: ",
              style: TextStyle(color: Colors.white),
            ),
            Text(
              "$value",
              style: TextStyle(color: Colors.white),
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      appBar: AppBar(
        title: Text("My Account"),
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              heightFactor: 2.5,
              child: CircleAvatar(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.asset('assets/images/dinosaur.jpg')),
                radius: 40,
              ),
            ),
            Expanded(
              child: Column(children: <Widget>[
                _inforRow("Name", "$_name"),
                SizedBox(height: 6),
                _inforRow("Email", "$_email"),
              ]),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white12,
              child: FlatButton(
                  onPressed: () {
                    _signOut(context);
                  },
                  child:
                      Text("Sign out", style: TextStyle(color: Colors.white))),
            )
          ]),
    );
  }

  // sign out the current user
  _signOut(context) {
    _auth.signOut();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyAccountPage()));
  }

  // retrive the user info
  _retriveInfo() async {
    await _auth.getCurrentUser().then((user) {
      _uid = user.uid;
    });

    if (_uid != null) {
      _ref.child("Users").child(_uid).once().then((DataSnapshot snapshot) {
        print(snapshot.value);
        setState(() {
          _name = snapshot.value["name"];
          _email = snapshot.value["email"];
        });
      });
    } else {
      print("no uid found");
    }
  }
}
