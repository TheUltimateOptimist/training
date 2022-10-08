import 'package:flutter/material.dart';
import 'package:tracker/exercise_selection_screen.dart';
import 'package:tracker/models/training_state.dart';
import 'package:tracker/my_timer.dart';
import 'package:tracker/widgets/app_bar.dart';

import 'package:tracker/widgets/continue_button.dart';

import 'models/training.dart';

class WarmUpScreen extends StatefulWidget {
  const WarmUpScreen(this.training, {Key? key}) : super(key: key);

  final Training training;

  @override
  State<WarmUpScreen> createState() => _WarmUpScreenState();
}

class _WarmUpScreenState extends State<WarmUpScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(floatingActionButton: ContinueButton(() {
              widget.training.changeState(TrainingState.selectingExercise);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExerciseSelectionScreen(widget.training),
                  ));
            }),floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: MyAppBar("WarmUp"),
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
              child: MyTimer(widget.training.start)
            ),
            
          ],
        ),
      ),
    );
  }
}
