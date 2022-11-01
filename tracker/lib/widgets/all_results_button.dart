

import 'package:flutter/material.dart';
import 'package:tracker/models/exercise.dart';

import '../exercise_stats_screen.dart';

class AllResultsButton extends StatelessWidget {
  const AllResultsButton(this.exercise, {Key? key}) : super(key: key);

  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
    return Container(
            margin: EdgeInsets.only(left: 5, top: 15),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExerciseStatsScreen(
                      exercise.name,
                      exercise.id,
                      exercise.tensionType,
                      showBottomNavBar: false,
                    ),
                  ),
                );
              },
              child: Text(
                "All Results",
              ),
            ),
          );
  }
}