import 'package:flutter/material.dart';
import 'package:tracker/api.dart';
import 'package:tracker/execution_screen.dart';
import 'package:tracker/tracker_screen.dart';
import 'package:tracker/widgets/app_bar.dart';

class ExerciseSelectionScreen extends StatefulWidget {
  const ExerciseSelectionScreen(this.sessionId, {Key? key}) : super(key: key);

  final int sessionId;

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
                    String tensionType = await showDialog(
                        context: context,
                        builder: (context) {
                          return TensionTypeDialog(exerciseId);
                        });
                    int performanceId = await API().startExercise(
                        widget.sessionId, exerciseId, tensionType);
                    // ignore: use_build_context_synchronously
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExecutionScreen(
                          1,
                          exerciseName: exerciseName,
                          performanceId: performanceId,
                          tensionType: tensionType,
                          exerciseId: exerciseId,sessionId: widget.sessionId,
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
  const TensionTypeDialog(this.exerciseId, {Key? key}) : super(key: key);

  final int exerciseId;

  @override
  State<TensionTypeDialog> createState() => _TensionTypeDialogState();
}

class _TensionTypeDialogState extends State<TensionTypeDialog> {
  String? _tensionType;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Widerstandsart:"),
      content: FutureBuilder<List<dynamic>>(
        future: API().getTensionTypes(widget.exerciseId),
        builder: ((context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return SizedBox(
              height: 100,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return StatefulBuilder(builder: (context, setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (snapshot.data!.contains("dumbbell"))
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
                if (snapshot.data!.contains("barbell"))
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
                if (snapshot.data!.contains("machine"))
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
                if (snapshot.data!.contains("cable"))
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
                if (snapshot.data!.contains("time"))
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
            );
          });
        }),
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
