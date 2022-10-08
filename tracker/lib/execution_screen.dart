import 'package:flutter/material.dart';
import 'package:tracker/exercise_selection_screen.dart';
import 'package:tracker/rest_screen.dart';
import 'package:tracker/widgets/app_bar.dart';
import 'package:tracker/widgets/continue_button.dart';

import 'models/exercise.dart';
import 'models/training.dart';
import 'models/training_state.dart';

class ExecutionScreen extends StatefulWidget {
  const ExecutionScreen(
    this.training,{
    Key? key,
   
  }) : super(key: key);

  final Training training;

  @override
  State<ExecutionScreen> createState() => _ExecutionScreenState();
}

class _ExecutionScreenState extends State<ExecutionScreen> {
  @override
  Widget build(BuildContext context) {
    final Exercise exercise = widget.training.exercises.last;
    if(widget.training.exercises.last.sets.isEmpty || widget.training.exercises.last.sets.last.completionDate != null){
      widget.training.startSet();
    }
    return Scaffold(
      appBar: MyAppBar(
        exercise.name,
        showQuit: true,
        onPressed: () {
          widget.training.changeState(TrainingState.selectingExercise);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ExerciseSelectionScreen(widget.training),
            ),
          );
        },
      ),
      floatingActionButton: ContinueButton(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => RestScreen(
             widget.training
            ),
          ),
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Center(
        child: Text(
          "Führe Satz ${exercise.sets.length} aus!",
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
    );
  }
}
