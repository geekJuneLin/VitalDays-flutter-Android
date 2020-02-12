import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:vital_days/pages/calendar_pick_screen.dart';
import 'package:vital_days/pages/create_screen.dart';
import 'package:vital_days/pages/main_screen.dart';
import 'package:vital_days/pages/myaccount_screen.dart';
import 'package:vital_days/pages/register_page.dart';
import 'package:vital_days/utils/auth.dart';
import 'authenticate/wrapper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: Auth().user,
      child: MaterialApp(
        home: Wrapper(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
