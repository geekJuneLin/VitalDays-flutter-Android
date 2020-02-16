import 'package:flutter/material.dart';
import 'package:vital_days/pages/myaccount_screen.dart';
import 'package:vital_days/utils/auth.dart';

class MyAccount extends StatelessWidget {
  final _auth = Auth();

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
                _inforRow("Name", "June"),
                SizedBox(height: 2),
                _inforRow("Email", "qch@123.com"),
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

  _signOut(context) {
    _auth.signOut();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyAccountPage()));
  }
}
