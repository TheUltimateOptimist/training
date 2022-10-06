import 'package:hive/hive.dart';

import '../models/training.dart';

class Database{
  static final Database _instance = Database._internal();
  late final Box box;

  factory Database() => _instance;

  Database._internal();

  void initialize(){
    box = Hive.box("data");
  }

  Training? getTraining(){
    Map<String, dynamic>? training = box.get("training");
    if(training == null){
      return null;
    }
    return Training.fromMap(training);
  }

  void saveTraining(Training training){
    box.put("training", training.toMap());
  }
}