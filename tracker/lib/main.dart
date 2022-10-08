import 'package:flutter/material.dart';
import 'package:tracker/data/data.dart';
import 'package:tracker/models/training.dart';
import 'package:tracker/widgets/app_bar.dart';
import 'package:tracker/widgets/bottom_navigation_bar.dart';

void main() async{
  await Database().initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
     home: Training.revive(),
     //home: ExecutionScreen(1, exerciseName: "Bench Press", exerciseId: 1, performanceId: 16, tensionType: "cable", sessionId: 30)
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
      
    widget.title,
      ),
      body: Container(),bottomNavigationBar: MyBottomNavigationBar(0),
    );
  }
}
