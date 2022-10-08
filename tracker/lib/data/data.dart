import 'package:hive_flutter/hive_flutter.dart';

import '../models/training.dart';

class Database{
  static final Database _instance = Database._internal();
  late final Box box;

  factory Database() => _instance;

  Database._internal();

  Future<void> initialize() async{
    await Hive.initFlutter();
    box = await Hive.openBox("data_12");
  }

  Training? getTraining(){
    final training = box.get("training");
    if(training == null){
      return null;
    }
    return Training.fromMap(training);
  }

  void saveTraining(Training training){
    box.put("training", training.toMap());
  }
}