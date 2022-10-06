import 'package:flutter/material.dart';
import 'package:tracker/exercise_selection_screen.dart';
import 'package:tracker/rest_screen.dart';
import 'package:tracker/widgets/app_bar.dart';
import 'package:tracker/widgets/continue_button.dart';

import 'models/exercise.dart';
import 'models/training.dart';

class ExecutionScreen extends StatelessWidget {
  const ExecutionScreen(
    this.training,{
    Key? key,
   
  }) : super(key: key);

  final Training training;

  @override
  Widget build(BuildContext context) {
    final Exercise exercise = training.exercises.last;
    training.startSet();
    return Scaffold(
      appBar: MyAppBar(
        exercise.name,
        showQuit: true,
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ExerciseSelectionScreen(training),
            ),
          );
        },
      ),
      floatingActionButton: ContinueButton(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => RestScreen(
             training
            ),
          ),
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Center(
        child: Text(
          "Führe Satz ${exercise.sets.length + 1} aus!",
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
    );
  }
}
