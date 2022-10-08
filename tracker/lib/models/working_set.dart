class WorkingSet {
  WorkingSet({this.completionDate, this.tension,  this.reps, this.note});
  DateTime? completionDate;
  double? tension;
  double? reps;
  String? note;

  static WorkingSet fromMap(dynamic map) {
    return WorkingSet(
        completionDate: map["completionDate"],
        tension: map["tension"],
        reps: map["reps"],
        note: map["note"]);
  }

  Map<String, dynamic> toMap(){
    return {
      "completionDate": completionDate,
      "tension": tension,
      "reps": reps,
      "note": note
    };
  }
}
