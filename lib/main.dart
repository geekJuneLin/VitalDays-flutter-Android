import 'package:flutter/material.dart';
import 'package:vital_days/pages/create_screen.dart';
import 'package:vital_days/pages/main_screen.dart';

void main() => runApp(MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => MainScreen(),
        '/createDay': (context) => CreateDayScreen(),
      },
    ));
