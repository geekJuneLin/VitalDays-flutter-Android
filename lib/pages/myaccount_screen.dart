import 'dart:wasm';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vital_days/pages/main_screen.dart';
import 'package:vital_days/pages/register_page.dart';
import 'package:vital_days/utils/auth.dart';

class MyAccountPage extends StatefulWidget {
  @override
  _MyAccountPageState createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  Auth _auth;
  bool _isPasswordShow = false;
  final _accountController = TextEditingController();
  final _passwordController = TextEditingController();

  // sign in method
  Future<FirebaseUser> _signIn(String email, String pass) async {
    if (email != null && pass != null) {
      dynamic user = await _auth.signIn(email, pass);
      return user != null ? user : null;
    } else {
      return null;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _auth = Auth();
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
                    controller: _accountController,
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
                    controller: _passwordController,
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
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterPage()));
                          },
                          child: Text('Register here',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12))),
                      Center(
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'Sign in',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                            onPressed: () async {
                              print(
                                  'sign in btn pressed! $_accountController.text, $_passwordController.text');
                              dynamic user = await _signIn(
                                  _accountController.text,
                                  _passwordController.text);
                              if (user != null) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MainScreen()));
                              } else {
                                _showError(context,
                                    "Sign in with errors! Please double check your email or password!");
                              }
                            },
                            color: Colors.white24,
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
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          FlatButton(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                              ),
                              onPressed: () {
                                print('google btn pressed!');
                              },
                              color: Colors.white24,
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
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              onPressed: () {
                                print('wechat btn pressed!');
                              },
                              color: Colors.white24,
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

  // show error dialog
  _showError(BuildContext context, String error) {
    Widget okBtn = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog dialog = AlertDialog(
      title: Text("Error!"),
      content: Text("$error"),
      actions: <Widget>[okBtn],
    );

    showDialog(context: context, child: dialog);
  }
}
