import 'package:flutter/material.dart';
import 'package:tracker/exercise_selection_screen.dart';
import 'package:tracker/exercise_stats_screen.dart';
import 'package:tracker/widgets/app_bar.dart';
import 'package:tracker/widgets/bottom_navigation_bar.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar("Choose an exercise:"),
      bottomNavigationBar: MyBottomNavigationBar(0),
      body: ExerciseSelectionListView(
          (exerciseName, exerciseId, tensionType) async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ExerciseStatsScreen(exerciseName, exerciseId, tensionType),
          ),
        );
      }),
    );
  }
}
