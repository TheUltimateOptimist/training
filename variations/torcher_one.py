from models.performance import Performance
from models.set import Set
from util.ansii import timer
from util.output import print_green

class TorcherOne(Performance):
    def __init__(self, exercise_ids: list[int]) -> None:
        super().__init__(exercise_ids, 3)
    
    def perform(self):
        for i,exercise in enumerate(self.exercises):
            self.start_exercise(
                f"{exercise.name} Torcher",
                "Führe so viele Wiederholungen in 60 sec wie möglich durch!"
            )
            timer(60)
            set = Set(i + 1, exercise.id, 30)
            self.add_set(set, ask_for_failure=False)
            if i < len(self.exercises) - 1:
                timer(30)
            else:
                self.save()
                print_green("Du hast das Torcher Workout erfolgreich absolviert!")
