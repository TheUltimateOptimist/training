import 'package:flutter/material.dart';
import 'package:tracker/api.dart';
import 'package:tracker/execution_screen.dart';
import 'package:tracker/models/training_state.dart';
import 'package:tracker/tracker_screen.dart';
import 'package:tracker/widgets/app_bar.dart';

import 'models/training.dart';

class ExerciseSelectionScreen extends StatefulWidget {
  const ExerciseSelectionScreen(this.training, {Key? key}) : super(key: key);

  final Training training;

  @override
  State<ExerciseSelectionScreen> createState() =>
      _ExerciseSelectionScreenState();
}

class _ExerciseSelectionScreenState extends State<ExerciseSelectionScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
          "Übung wählen:",
          showQuit: true,
          onPressed: () {
            widget.training.changeState(TrainingState.finished);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => TrackerScreen(),
              ),
            );
          },
        ),
        body: FutureBuilder<List<dynamic>>(
          future: API().getExercises(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                String exerciseName = snapshot.data![index][1];
                int exerciseId = snapshot.data![index][0];
                return ListTile(
                  title: Text(exerciseName),
                  onTap: () async {
                    List<dynamic> tensionTypes = await API().getTensionTypes(exerciseId);
                    final String tensionType;
                    if(tensionTypes.length == 1){
                      tensionType = tensionTypes[0];
                    }
                    else{
                      tensionType = await showDialog(
                        context: context,
                        builder: (context) {
                          return TensionTypeDialog(tensionTypes);
                        });
                    }
                    
                    await widget.training.addExercise(exerciseName, exerciseId, tensionType);
                    widget.training.changeState(TrainingState.doingExercise);
                    // ignore: use_build_context_synchronously
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExecutionScreen(
                         widget.training
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ));
  }
}

class TensionTypeDialog extends StatefulWidget {
  const TensionTypeDialog(this.tensionTypes, {Key? key}) : super(key: key);

  final List<dynamic> tensionTypes;

  @override
  State<TensionTypeDialog> createState() => _TensionTypeDialogState();
}

class _TensionTypeDialogState extends State<TensionTypeDialog> {
  String? _tensionType;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Widerstandsart:"),
      content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.tensionTypes.contains("dumbbell"))
                  RadioListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text("Hantel"),
                    value: "dumbbell",
                    groupValue: _tensionType,
                    onChanged: (value) {
                      setState(
                        () {
                          _tensionType = value.toString();
                        },
                      );
                    },
                  ),
                if (widget.tensionTypes.contains("barbell"))
                  RadioListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text("Langhantel"),
                    value: "barbell",
                    groupValue: _tensionType,
                    onChanged: (value) {
                      setState(
                        () {
                          _tensionType = value.toString();
                        },
                      );
                    },
                  ),
                if (widget.tensionTypes.contains("machine"))
                  RadioListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text("Maschine"),
                    value: "machine",
                    groupValue: _tensionType,
                    onChanged: (value) {
                      setState(
                        () {
                          _tensionType = value.toString();
                        },
                      );
                    },
                  ),
                if (widget.tensionTypes.contains("cable"))
                  RadioListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text("Kabel"),
                    value: "cable",
                    groupValue: _tensionType,
                    onChanged: (value) {
                      setState(
                        () {
                          _tensionType = value.toString();
                        },
                      );
                    },
                  ),
                if (widget.tensionTypes.contains("time"))
                  RadioListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text("Zeit"),
                    value: "time",
                    groupValue: _tensionType,
                    onChanged: (value) {
                      setState(
                        () {
                          _tensionType = value.toString();
                        },
                      );
                    },
                  ),
              ],
            ),
        
       
      actions: [
        TextButton(
          onPressed: () {
            if (_tensionType != null) {
              Navigator.pop(context, _tensionType);
            }
          },
          child: Text(
            "Ok",
          ),
        )
      ],
    );
  }
}
