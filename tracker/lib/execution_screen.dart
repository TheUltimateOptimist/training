import 'package:flutter/material.dart';
import 'package:tracker/exercise_selection_screen.dart';
import 'package:tracker/rest_screen.dart';
import 'package:tracker/tracker_screen.dart';
import 'package:tracker/widgets/app_bar.dart';
import 'package:tracker/widgets/continue_button.dart';

class ExecutionScreen extends StatelessWidget {
  const ExecutionScreen(
    this.index, {
    Key? key,
    required this.exerciseName,
    required this.exerciseId,
    required this.performanceId,
    this.previousRest,
    required this.tensionType,
    required this.sessionId,
  }) : super(key: key);

  final int index;
  final String exerciseName;
  final int exerciseId;
  final int performanceId;
  final String tensionType;
  final int? previousRest;
  final int sessionId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        exerciseName,
        showQuit: true,
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ExerciseSelectionScreen(sessionId),
            ),
          );
        },
      ),
      floatingActionButton: ContinueButton(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => RestScreen(
              index,
              previousRest: previousRest,
              exerciseId: exerciseId,
              exerciseName: exerciseName,
              performanceId: performanceId,
              tensionType: tensionType,
              sessionId: sessionId,
            ),
          ),
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Center(
        child: Text(
          "Führe Satz $index aus!",
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
    );
  }
}
