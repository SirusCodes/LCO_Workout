class ExerciseName {
  ExerciseName();
  Exercise _exercise;

  Exercise get getExercise => _exercise;

  ExerciseName.fromJson(Map<String, dynamic> data, String exercise) {
    _exercise = Exercise.fromJson(data[exercise]);
  }
}

class Exercise {
  String _target, _how, exercise;

  String get getTarget => _target;
  String get getHow => _how;

  Exercise.fromJson(Map<String, dynamic> data) {
    _target = data["target"];
    _how = data["how"];
  }
}
