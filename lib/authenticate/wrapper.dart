import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vital_days/pages/main_screen.dart';
import 'package:vital_days/pages/myaccount_screen.dart';
import 'package:vital_days/pages/register_page.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<FirebaseUser>(context);
    print(user);

    if (user == null){
      return MyAccountPage();
    }else{
      return MainScreen();
    }
  }
}