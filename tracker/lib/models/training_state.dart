enum TrainingState { warmingUp, selectingExercise, doingExercise, finished }

int toInt(TrainingState trainingState) {
  switch (trainingState) {
    case TrainingState.warmingUp:
      return 1;
    case TrainingState.selectingExercise:
      return 2;
    case TrainingState.doingExercise:
      return 3;
    case TrainingState.finished:
      return 4;
  }
}

TrainingState fromInt(int state){
  switch (state) {
    case 1: return TrainingState.warmingUp;
    case 2: return TrainingState.selectingExercise;
    case 3: return TrainingState.doingExercise;
    case 4: return TrainingState.finished;
  }
  throw UnimplementedError();
}
