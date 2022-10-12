import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tracker/api.dart';
import 'package:tracker/execution_screen.dart';
import 'package:tracker/widgets/app_bar.dart';
import 'package:tracker/widgets/bottom_navigation_bar.dart';

class ExerciseStatsScreen extends StatelessWidget {
  const ExerciseStatsScreen(
      this.exerciseName, this.exerciseId, this.tensionType,
      {Key? key})
      : super(key: key);

  final String exerciseName;
  final int exerciseId;
  final String tensionType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar("$exerciseName Results:"),
      bottomNavigationBar: MyBottomNavigationBar(0),
      body: FutureBuilder<List<dynamic>>(
        future: API().getExerciseHistory(exerciseId, tensionType),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          } else {
            return StatsTable(snapshot.data!);
          }
        },
      ),
    );
  }
}
