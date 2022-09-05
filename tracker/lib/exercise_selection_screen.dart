import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tracker/execution_screen.dart';
import 'package:tracker/widgets/app_bar.dart';
import 'package:tracker/widgets/bottom_navigation_bar.dart';

class ExerciseSelectionScreen extends StatefulWidget {
  const ExerciseSelectionScreen({Key? key}) : super(key: key);

  @override
  State<ExerciseSelectionScreen> createState() =>
      _ExerciseSelectionScreenState();
}

class _ExerciseSelectionScreenState extends State<ExerciseSelectionScreen> {
  final List<String> _exercises = [
    "Pushups",
    "Bench Press",
    "Pull Ups",
    "Beinpresse",
    "Dumbell Bench Press",
    "Langhantel Rudern",
    "Kurzhantel Rudern",
    "Enges Bankdrücken",
    "Biceps Curls",
    "Triceps Extensions"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
          "Übung wählen:",
          actions: [
            TextButton(
              child: Text("Beenden", style: TextStyle(color: Colors.white)),
              onPressed: () {},
            )
          ],
        ),
        bottomNavigationBar: MyBottomNavigationBar(1),
        body: ListView.builder(
          itemCount: _exercises.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(_exercises[index]),
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ExecutionScreen(),
                    ));
              },
            );
          },
        ));
  }
}
