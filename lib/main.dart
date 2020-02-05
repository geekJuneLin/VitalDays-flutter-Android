import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:vital_days/pages/calendar_pick_screen.dart';
import 'package:vital_days/pages/create_screen.dart';
import 'package:vital_days/pages/main_screen.dart';
import 'package:vital_days/pages/myaccount_screen.dart';
import 'package:vital_days/pages/register_page.dart';
import 'package:vital_days/utils/auth.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(MaterialApp(
        initialRoute: '/',
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => MainScreen(),
          '/createDay': (context) => CreateDayScreen(),
          '/calendar': (context) => CalendarPage(),
          '/account': (context) => MyAccountPage(),
        },
      )));
}
