import 'package:flutter/material.dart' show  Widget;
import 'package:tracker/api.dart';
import 'package:tracker/data/data.dart';
import 'package:tracker/execution_screen.dart';
import 'package:tracker/exercise_selection_screen.dart';
import 'package:tracker/main.dart';
import 'package:tracker/models/exercise.dart';
import 'package:tracker/models/training_state.dart';
import 'package:tracker/models/working_set.dart';
import 'package:tracker/rest_screen.dart';
import 'package:tracker/warm_up_screen.dart';

class Training {
  Training(this.id, this.bodyweight,this.start,
      {this.trainingState = TrainingState.warmingUp, 
      this.exercises = const []});
  final int id;
  final double bodyweight;
  final DateTime start;
  TrainingState trainingState;
  List<Exercise> exercises;

  static Future<Training> create(double bodyweight) async {
    final id = await API().startTraining(bodyweight);
    return Training(id, bodyweight, DateTime.now());
  }

  static Training fromMap(Map<String, dynamic> map) {
    final List<Exercise> exercises = List.empty(growable: true);
    for (Map<String, dynamic> exercise in map["exercises"]) {
      exercises.add(Exercise.fromMap(exercise));
    }
    return Training(
      map["id"],
      map["bodyweight"],
      map["start"],
      trainingState: map["trainingState"],
      exercises: exercises,
    );
  }

  Map<String, dynamic> toMap(){
    List<Map<String, dynamic>> exerciseMaps = List.empty(growable: true);
    for(Exercise exercise in exercises){
      exerciseMaps.add(exercise.toMap());
    }
    return {
      "id": id,
      "bodyweight": bodyweight,
      "start": start,
      "trainingState": trainingState,
      "exercises": exerciseMaps
    };
  }

  Future<void> addExercise(String name, int exerciseId, String tensionType)async{
    final performanceId = await API().startExercise(id, exerciseId, tensionType);
    exercises.add(Exercise(exerciseId, name, performanceId, tensionType,),);
    save();
  }

  void startSet(){
    exercises.last.sets.add(WorkingSet());
    save();
  }

  Future<void> finishSet()async{
    final Exercise exercise = exercises.last;
    final WorkingSet set = exercise.sets.last;
    await API().addSet(exercise.performanceId, exercise.sets.length + 1, set.tension!,exercise.lastRest, set.reps!, set.note);
    save();
  }

  void save(){
    Database().saveTraining(this);
  }

  static Widget revive() {
    Training? training = Database().getTraining();
    if(training == null){
      return MyHomePage(title: "Statistik");
    }
    switch (training.trainingState) {
      case TrainingState.warmingUp:
        return WarmUpScreen(training);
      case TrainingState.selectingExercise:
        return ExerciseSelectionScreen(training);
      case TrainingState.doingExercise:
        {
          final Exercise exercise = training.exercises.last;
          if (exercise.sets.last.completionDate == null) {
            return ExecutionScreen(training);
          } else {
            return RestScreen(training);
          }
        }
      default:
        return MyHomePage(title: "Statistik");
    }
  }
}
