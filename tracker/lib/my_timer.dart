import 'dart:async';

import 'package:flutter/material.dart';

class MyTimer extends StatefulWidget {
  const MyTimer({Key? key}) : super(key: key);
  
  @override
  State<MyTimer> createState() => _MyTimerState();
}

class _MyTimerState extends State<MyTimer> {
  late Timer _t;
  int _seconds = 0;

  @override
  void initState() {
    _t = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _t.cancel();
    super.dispose();
  }

  String secondsToText(int seconds) {
    String minutes = (seconds / 60).floor().toString();
    if (minutes.length == 1) {
      minutes = "0$minutes";
    }
    String secondsText = (seconds - (seconds / 60).floor() * 60).toString();
    if (secondsText.length == 1) {
      secondsText = "0$secondsText";
    }
    return "$minutes:$secondsText";
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      secondsToText(
        _seconds,
      ),
      style: Theme.of(context).textTheme.headline4,
    );
  }
}
