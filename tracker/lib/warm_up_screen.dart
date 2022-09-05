import 'package:flutter/material.dart';
import 'package:tracker/exercise_selection_screen.dart';
import 'package:tracker/widgets/app_bar.dart';
import 'package:tracker/widgets/bottom_navigation_bar.dart';
import 'dart:async';

import 'package:tracker/widgets/continue_button.dart';

class WarmUpScreen extends StatefulWidget {
  const WarmUpScreen({Key? key}) : super(key: key);

  @override
  State<WarmUpScreen> createState() => _WarmUpScreenState();
}

class _WarmUpScreenState extends State<WarmUpScreen> {
  
  int _seconds = 0;
  late Timer _t;

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
    return Scaffold(
      appBar: MyAppBar("WarmUp"),
      bottomNavigationBar: MyBottomNavigationBar(1),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Wärm dich auf!",
              style: Theme.of(context).textTheme.headline3,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 30),
              child: Text(
                secondsToText(
                  _seconds,
                ),
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            ContinueButton(() {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExerciseSelectionScreen(),
                  ));
            })
          ],
        ),
      ),
    );
  }
}
