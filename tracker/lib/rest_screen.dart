import 'package:flutter/material.dart';
import 'package:tracker/api.dart';
import 'package:tracker/execution_screen.dart';
import 'package:tracker/exercise_selection_screen.dart';
import 'package:tracker/my_timer.dart';
import 'package:tracker/widgets/app_bar.dart';
import 'package:tracker/widgets/continue_button.dart';

class RestScreen extends StatefulWidget {
  const RestScreen(
    this.index, {
    Key? key,
    required this.exerciseName,
    required this.exerciseId,
    required this.performanceId,
    required this.tensionType,
    this.previousRest,
    required this.sessionId,
  }) : super(key: key);

  final String exerciseName;
  final int exerciseId;
  final int performanceId;
  final String tensionType;
  final int index;
  final int? previousRest;
  final int sessionId;

  @override
  State<RestScreen> createState() => _RestScreenState();
}

class _RestScreenState extends State<RestScreen> {
  final TextEditingController weightEditingController = TextEditingController();
  final TextEditingController repsEditingController = TextEditingController();
  final TextEditingController noteEditingController = TextEditingController();
  bool _isLoading = false;
  final DateTime _start = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: StatefulBuilder(builder: (context, setState) {
        if (!_isLoading) {
          return ContinueButton(() async {
            if (weightEditingController.text != "" &&
                repsEditingController.text != "") {
              final weight = double.parse(weightEditingController.text);
              final rest = DateTime.now().difference(_start).inSeconds;
              setState(
                () {
                  _isLoading = true;
                },
              );
              await API().addSet(widget.performanceId, widget.index, weight,
                  widget.previousRest ?? 0, noteEditingController.text);
              // ignore: use_build_context_synchronously
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ExecutionScreen(
                    widget.index + 1,
                    previousRest: rest,
                    exerciseName: widget.exerciseName,
                    performanceId: widget.performanceId,
                    tensionType: widget.tensionType,
                    exerciseId: widget.exerciseId,
                    sessionId: widget.sessionId,
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
        widget.exerciseName,
        showQuit: true,
        onPressed: () async {
          if (weightEditingController.text != "" &&
              repsEditingController.text != "") {
            final weight = double.parse(weightEditingController.text);
            await API().addSet(widget.performanceId, widget.index, weight,
                widget.previousRest ?? 0, noteEditingController.text);
            // ignore: use_build_context_synchronously
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ExerciseSelectionScreen(widget.sessionId),
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
            Text("Satz ${widget.index} Ergebnisse:",
                style: Theme.of(context).textTheme.headline4),
            Spacer(
              height: 10,
            ),
            MyTextField(
              weightEditingController,
              textInputType: TextInputType.number,
              title: "Gewicht in kg:",
              hint: "e.g. 14",
            ),
            Spacer(),
            MyTextField(
              repsEditingController,
              textInputType: TextInputType.number,
              title: "Wiederholungen:",
              hint: "e.g. 10",
            ),
            Spacer(),
            MyTextField(
              noteEditingController,
              textInputType: TextInputType.text,
              title: "Notiz:",
            ),
            Expanded(
              child: Center(
                child: MyTimer(),
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
      {Key? key, required this.textInputType, required this.title, this.hint})
      : super(key: key);

  final TextInputType textInputType;
  final TextEditingController textEditingController;
  final String title;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: textInputType,
      controller: textEditingController,
      decoration: InputDecoration(
          hintText: hint,
          label: Text(
            title,
          )),
    );
  }
}
