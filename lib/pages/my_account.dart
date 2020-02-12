import 'package:flutter/material.dart';
import 'package:vital_days/pages/myaccount_screen.dart';
import 'package:vital_days/utils/auth.dart';

class MyAccount extends StatelessWidget {
  final _auth = Auth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Account"),
      ),
      body: Container(
        child: FlatButton(
          onPressed: () {
            _auth.signOut();
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MyAccountPage()));
          },
          child: Text(
            "Sign out",
            style: TextStyle(color: Colors.blue[200]),
          ),
        ),
      ),
    );
  }
}
