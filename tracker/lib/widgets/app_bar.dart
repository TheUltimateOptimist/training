import 'package:flutter/material.dart';

class MyAppBar extends AppBar {
   MyAppBar(String title, {Key? key, List<Widget>? actions}) : super(key: key, title: Text(title), actions: actions);
}