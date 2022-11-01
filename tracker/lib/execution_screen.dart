import 'package:flutter/material.dart';
import 'package:tracker/api.dart';
import 'package:tracker/exercise_selection_screen.dart';
import 'package:tracker/exercise_stats_screen.dart';
import 'package:tracker/rest_screen.dart';
import 'package:tracker/widgets/all_results_button.dart';
import 'package:tracker/widgets/app_bar.dart';
import 'package:tracker/widgets/continue_button.dart';

import 'models/exercise.dart';
import 'models/training.dart';
import 'models/training_state.dart';

class ExecutionScreen extends StatefulWidget {
  const ExecutionScreen(
    this.training, {
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
    if (widget.training.exercises.last.sets.isEmpty ||
        widget.training.exercises.last.sets.last.completionDate != null) {
      widget.training.startSet();
    }
    return Scaffold(
      appBar: MyAppBar(
        exercise.name,
        showQuit: true,
        onPressed: () async {
          final Exercise exercise = widget.training.exercises.last;
          if (exercise.sets.length == 1 &&
              exercise.sets.last.completionDate == null) {
            await API().removePerformance(exercise.performanceId);
            widget.training.exercises.remove(exercise);
          }
          widget.training.changeState(TrainingState.selectingExercise);
          // ignore: use_build_context_synchronously
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
            builder: (context) => RestScreen(widget.training),
          ),
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ConstrainedBox(constraints: BoxConstraints(maxHeight: 400,),child: LastStats(exercise.id, exercise.tensionType, widget.training.id)),
          AllResultsButton(exercise),
          Expanded(
            child: Center(
              child: Text(
                "Führe Satz ${exercise.sets.length} aus!",
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ),
         SizedBox(height: 65)
        ],
      ),
    );
  }
}

class LastStats extends StatelessWidget {
  const LastStats(this.exerciseId, this.tensionType, this.sessionId, {Key? key})
      : super(key: key);

  final int exerciseId;
  final String tensionType;
  final int sessionId;

  static const TextStyle columnStyle =
      TextStyle(color: Colors.black, fontSize: 20);
  static const borderSide = BorderSide(color: Colors.grey);
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 15, left: 5, right: 5),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 5),
                child: Text("Results to beat:", style: TextStyle(fontSize: 20)),
              ),
              FutureBuilder<List<dynamic>>(
                  future: API().getLastStats(exerciseId, tensionType, sessionId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return Center(
                          child: Container(
                        margin: EdgeInsets.only(top: 30),
                        child: CircularProgressIndicator(),
                      ));
                    } else {
                      return StatsTable(snapshot.data!);
                    }
                  }),
            ],
          ),
        ),
    );
  }
}

class StatsTable extends StatelessWidget {
  const StatsTable(this.data, {Key? key}) : super(key: key);

  static const TextStyle columnStyle =
      TextStyle(color: Colors.black, fontSize: 20);
  static const borderSide = BorderSide(color: Colors.grey);
  final List<dynamic> data;

  List<TableRow> getTableRows(List<dynamic> data) {
    List<TableRow> result = List.empty(growable: true);
    for (int i = 0; i < data.length; i++) {
      if (i != 0 && data[i][0] == 1) {
        result.add(
          TableRow(
            children: [for (int i = 0; i < 4; i++) TableText("")],
            decoration: BoxDecoration(
              color: Colors.black,
            ),
          ),
        );
      }
      result.add(
        TableRow(
          children: [
            for (dynamic value in data[i])
              TableText(
                value.toString(),
              ),
          ],
        ),
      );
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Table(
        border: TableBorder(
          top: borderSide,
          bottom: borderSide,
          left: borderSide,
          right: borderSide,
          horizontalInside: borderSide,
          verticalInside: borderSide,
        ),
        children: [
          if (data.isNotEmpty)
            TableRow(
              children: const [
                TableText(
                  "Index:",
                  isDescription: true,
                ),
                TableText("Weight:", isDescription: true),
                TableText("Reps", isDescription: true),
                TableText("Note:", isDescription: true)
              ],
            ),
          ...getTableRows(data)
        ],
      ),
    );
  }
}

class TableText extends StatelessWidget {
  const TableText(this.text, {Key? key, this.isDescription = false})
      : super(key: key);

  final bool isDescription;
  final String? text;

  static const descriptionStyle = TextStyle(color: Colors.black, fontSize: 20);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(
          left: 5,
          top: 5,
        ),
        child:
            Text(text ?? "", style: isDescription ? descriptionStyle : null));
  }
}
