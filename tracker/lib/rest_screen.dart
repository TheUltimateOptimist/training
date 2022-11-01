import 'package:flutter/material.dart';
import 'package:tracker/execution_screen.dart';
import 'package:tracker/exercise_selection_screen.dart';
import 'package:tracker/models/training_state.dart';
import 'package:tracker/models/working_set.dart';
import 'package:tracker/my_timer.dart';
import 'package:tracker/widgets/all_results_button.dart';
import 'package:tracker/widgets/app_bar.dart';
import 'package:tracker/widgets/continue_button.dart';

import 'models/exercise.dart';
import 'models/training.dart';

class RestScreen extends StatefulWidget {
  const RestScreen(
    this.training, {
    Key? key,
    
  }) : super(key: key);

  final Training training;

  @override
  State<RestScreen> createState() => _RestScreenState();
}

class _RestScreenState extends State<RestScreen> {
  final TextEditingController weightEditingController = TextEditingController();
  final TextEditingController repsEditingController = TextEditingController();
  final TextEditingController noteEditingController = TextEditingController();
  bool _isLoading = false;
  late final Exercise exercise;
  late final WorkingSet set;

  @override
  void initState() {
    exercise = widget.training.exercises.last;
    set = exercise.sets.last;
    if(set.completionDate == null){
      set.completionDate = DateTime.now();
    widget.training.save();
    }
    if(set.tension != null){
      if(set.tension! % 1 == 0){
        weightEditingController.text = set.tension!.round().toString();
      }
      else {
        weightEditingController.text = set.tension!.toString();
      } 
    }
    if(set.reps != null){
      if(set.reps! % 1 == 0){
        repsEditingController.text = set.reps!.round().toString();
      }
      else{
        repsEditingController.text = set.reps.toString();
      }
    }
    noteEditingController.text = set.note ?? "";
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: StatefulBuilder(builder: (context, setState) {
        if (!_isLoading) {
          return ContinueButton(() async {
            if (weightEditingController.text != "" &&
                repsEditingController.text != "") {
              set.tension = double.parse(weightEditingController.text);
              set.reps = double.parse(repsEditingController.text);
              set.note = noteEditingController.text;
              setState(
                () {
                  _isLoading = true;
                },
              );
              await widget.training.finishSet();       
              // ignore: use_build_context_synchronously
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ExecutionScreen(
                   widget.training
                  ),
                ),
              );
            }
          });
        } else {
          return CircularProgressIndicator();
        }
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: MyAppBar(
       exercise.name,
        showQuit: true,
        onPressed: () async {
          if (weightEditingController.text != "" &&
              repsEditingController.text != "") {
            set.tension = double.parse(weightEditingController.text);
            set.reps = double.parse(repsEditingController.text);
            set.note = noteEditingController.text;
            await widget.training.finishSet();
            widget.training.changeState(TrainingState.selectingExercise);
            // ignore: use_build_context_synchronously
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ExerciseSelectionScreen(widget.training),
              ),
            );
          }
        },
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(
              height: 25,
            ),
            Text("Satz ${exercise.sets.length} Ergebnisse:",
                style: Theme.of(context).textTheme.headline4),
            Spacer(
              height: 10,
            ),
            MyTextField(
              weightEditingController,
              textInputType: TextInputType.number,
              title: "Gewicht in kg:",
              hint: "e.g. 14",
              onChanged: (newValue){
                set.tension = double.parse(newValue);
                widget.training.save();
              },
            ),
            Spacer(),
            MyTextField(
              repsEditingController,
              textInputType: TextInputType.number,
              title: "Wiederholungen:",
              hint: "e.g. 10",
              onChanged: (newValue){
                set.reps = double.parse(newValue);
                widget.training.save();
              },
            ),
            Spacer(),
            MyTextField(
              noteEditingController,
              textInputType: TextInputType.text,
              title: "Notiz:",
              onChanged: (newValue){
                set.note = newValue;
                widget.training.save();
              },
            ),
            AllResultsButton(exercise),
            Expanded(
              child: Center(
                child: MyTimer(set.completionDate),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Spacer extends StatelessWidget {
  const Spacer({Key? key, this.height}) : super(key: key);

  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 20,
    );
  }
}

class MyTextField extends StatelessWidget {
  const MyTextField(this.textEditingController,
      {Key? key, required this.textInputType, required this.title, this.hint, this.onChanged})
      : super(key: key);

  final TextInputType textInputType;
  final TextEditingController textEditingController;
  final String title;
  final String? hint;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: textInputType,
      controller: textEditingController,
      onChanged: onChanged,
      decoration: InputDecoration(
          hintText: hint,
          label: Text(
            title,
          )),
    );
  }
}
