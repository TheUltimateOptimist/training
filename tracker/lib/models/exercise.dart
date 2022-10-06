import 'package:tracker/models/working_set.dart';

class Exercise {
  Exercise(this.id, this.name, this.performanceId, this.tensionType,{this.sets = const [], this.lastRest = 0,});
  final String name;
  final int id;
  final int performanceId;
  final String tensionType;
  int lastRest;
  List<WorkingSet> sets;

  static Exercise fromMap(Map<String, dynamic> map) {
    List<WorkingSet> sets = List.empty(growable: true);
    for(Map<String, dynamic> workingSet in map["sets"]){
      sets.add(WorkingSet.fromMap(workingSet ));
    }
    return Exercise(
      map["id"],
      map["name"],
      map["performanceId"],
      map["tensionType"],
      lastRest: map["lastRest"],
      sets: sets,
    );
  }

  Map<String, dynamic> toMap(){
    List<Map<String, dynamic>> setMaps = List.empty(growable: true);
    for(WorkingSet workingSet in sets){
      setMaps.add(workingSet.toMap());
    }
    return {
      "id": id,
      "name": name,
      "performanceId": performanceId,
      "tensionType": tensionType,
      "lastRest": lastRest,
      "sets": setMaps
    };
  }
}
