import 'dart:wasm';

import 'package:flutter/material.dart';

class MyAccountPage extends StatefulWidget {
  @override
  _MyAccountPageState createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  bool _isPasswordShow = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[200],
        elevation: 0,
      ),
      body: Center(
          child: Container(
              height: double.infinity,
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.08,
                  left: 30,
                  right: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Huge title
                  Text(
                    'Vital Days',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 24),
                  // Account & password section
                  TextField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.people,
                          color: Colors.white,
                        ),
                        hintText: 'Account',
                        hintStyle: TextStyle(
                          color: Colors.grey[200],
                          fontSize: 16,
                        )),
                  ),
                  SizedBox(height: 24),
                  TextField(
                    obscureText: !_isPasswordShow ? true : false,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.white,
                        ),
                        suffixIcon: IconButton(
                            icon: !_isPasswordShow
                                ? Image.asset('assets/images/hide.png')
                                : Image.asset('assets/images/show.png'),
                            onPressed: () {
                              setState(() {
                                _isPasswordShow = !_isPasswordShow;
                              });
                            }),
                        hintText: 'Password',
                        hintStyle: TextStyle(
                          color: Colors.grey[200],
                          fontSize: 16,
                        )),
                  ),
                  SizedBox(height: 24),

                  // Login, register & forgot password section
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      FlatButton(
                          onPressed: () {},
                          child: Text('Forgot the password?',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12))),
                      FlatButton(
                          onPressed: () {},
                          child: Text('Register here',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12))),
                      Center(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.circular(8)),
                          child: FlatButton(
                            child: Text(
                              'Sign in',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                            onPressed: () {
                              print('sign in btn pressed!');
                            },
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 36),
                  // Login with google or wechat
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Column(children: <Widget>[
                      // Title and saperator
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          SizedBox(
                            width: 80,
                            height: 1.5,
                            child: Container(color: Colors.white),
                          ),
                          Text(
                            'Or Login with',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          SizedBox(
                            width: 80,
                            height: 1.5,
                            child: Container(color: Colors.white),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          FlatButton(
                              onPressed: () {
                                print('google btn pressed!');
                              },
                              child: Row(
                                children: <Widget>[
                                  Image.asset('assets/images/google.png'),
                                  SizedBox(width: 8),
                                  Text(
                                    'Google',
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              )),
                          FlatButton(
                              onPressed: () {
                                print('wechat btn pressed!');
                              },
                              child: Row(
                                children: <Widget>[
                                  Image.asset('assets/images/wechat.png'),
                                  SizedBox(width: 8),
                                  Text(
                                    'Wechat',
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ))
                        ],
                      )
                    ]),
                  )
                ],
              ))),
    );
  }
}
