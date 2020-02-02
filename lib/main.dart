import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:vital_days/pages/calendar_pick_screen.dart';
import 'package:vital_days/pages/create_screen.dart';
import 'package:vital_days/pages/main_screen.dart';
import 'package:vital_days/pages/register_page.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(MaterialApp(
        initialRoute: '/',
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => MainScreen(),
          '/createDay': (context) => CreateDayScreen(),
          '/calendar': (context) => CalendarPage(),
          // '/register': (context) => RegisterPage()
        },
      )));
}
