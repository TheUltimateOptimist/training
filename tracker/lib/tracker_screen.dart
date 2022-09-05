import 'package:flutter/material.dart';
import 'package:tracker/warm_up_screen.dart';
import 'package:tracker/widgets/app_bar.dart';
import 'package:tracker/widgets/bottom_navigation_bar.dart';

class TrackerScreen extends StatefulWidget {
  const TrackerScreen({Key? key}) : super(key: key);

  @override
  State<TrackerScreen> createState() => _TrackerScreenState();
}

class _TrackerScreenState extends State<TrackerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar("Tracker"),
      bottomNavigationBar: MyBottomNavigationBar(1),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.green,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(
                100,
              ),
            ),
          ),
          child: IconButton(iconSize: 100, color: Colors.green,
            icon: Icon(
              Icons.play_arrow_rounded,
              size: 100,
            ),
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WarmUpScreen(),));
            },
          ),
        ),
      ),
    );
  }
}
