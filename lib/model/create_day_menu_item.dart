import 'package:flutter/material.dart';

abstract class ListItem {}

class MenuItem implements ListItem {
  final String title;
  final Icon icon;
  final String content;

  MenuItem({this.title, this.icon, this.content});
}

class PreviewItem implements ListItem {
  final String title;

  PreviewItem({this.title});
}
