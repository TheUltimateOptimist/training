import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:async';

class ServerException extends Error {}

class API {
  static const urlPrefix = "http://theultimateoptimist.pythonanywhere.com";
  static const user_name = "Jonathan";

  Future<String> index() async{
    var response = await http.get(Uri.parse("$urlPrefix/"),);
    return response.body;
  }

  Future<int> startTraining(double bodyweight) async{
    var response = await http.post(Uri.parse("$urlPrefix/sessions/$user_name"), body: {"bodyweight": bodyweight.toString()});
    if(response.statusCode != 200){
      throw ServerException();
    }
    return int.parse(response.body);
  }

  Future<int> startExercise(int sessionId, int exerciseId, String tensionType) async{
    var response = await http.post(Uri.parse("$urlPrefix/performances/$sessionId/$exerciseId/$tensionType"));
    if(response.statusCode != 200){
      throw ServerException();
    }
    return int.parse(response.body);
  }

  Future<void> addSet(int performanceId, int index, double tension, int rest, double reps, String? note)async{
    var response = await http.post(Uri.parse("$urlPrefix/sets/$performanceId"), body: {"index": index.toString(), "tension": tension.toString(), "rest": rest.toString(), "note": note ?? "", "reps": reps.toString()});
    if(response.statusCode != 200){
      throw ServerException();
    }
  }

  Future<List<dynamic>> getExercises()async{
    var response = await http.get(Uri.parse("$urlPrefix/exercises/$user_name"));
    if(response.statusCode != 200){
      throw ServerException();
    }
    var body = response.body;
    return jsonDecode(body);
  }

  Future<List<dynamic>> getTensionTypes(int exerciseId)async{
    var response = await http.get(Uri.parse("$urlPrefix/tension_types/$exerciseId"));
    if(response.statusCode != 200){
      throw ServerException();
    }
    return jsonDecode(response.body);
  }

  Future<List<List<dynamic>>> getLastStats(int exerciseId, String tensionType, int sessionId)async{
    var response = await http.get(Uri.parse("$urlPrefix/last_stats/$exerciseId/$tensionType/$sessionId"));
    if(response.statusCode != 200){
      throw ServerException();
    }
    List<List<dynamic>> finalList = List.empty(growable: true);
    dynamic result = jsonDecode(response.body);
    for(List<dynamic> row in result){
      finalList.add(row);
    }
    return finalList;
  }

  Future<void> removePerformance(int performanceId) async{
    var response = await http.post(Uri.parse("$urlPrefix/performances/remove/$performanceId"));
     if(response.statusCode != 200){
      throw ServerException();
    }
  }

  Future<List<List<dynamic>>> getExerciseHistory(int exerciseId, String tensionType)async{
    var response = await http.get(Uri.parse("$urlPrefix/sets/history/$exerciseId/$tensionType"));
    if(response.statusCode != 200){
      throw ServerException();
    }
    List<List<dynamic>> finalList = List.empty(growable: true);
    dynamic result = jsonDecode(response.body);
    for(List<dynamic> row in result){
      finalList.add(row);
    }
    return finalList;
  }
}