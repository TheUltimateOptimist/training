from models.performance import Performance
from models.exercise import Exercise
from models.set import Set
from util.ansii import reset, timer
from util.output import print_title, print_green
from util.input import get_boolean, get_positive_int

class Traditional(Performance):
    def __init__(self, exercise: Exercise, sets: int, rest: int) -> None:
        super().__init__(exercise, 1)
        self.set_count = sets
        self.rest = rest
        self.sets: list[Set] = []

    def perform(self):
        for i in range(self.set_count):
            set = Set(i + 1)
            reset()
            print_title(self.exercise.name)
            print(f"Führe den {i + 1}. von {self.set_count} Sätzen aus!")
            set.weight = get_positive_int("Gewicht in kg: ")
            set.reps = get_positive_int("Wiederholungen: ")
            set.reached_failure = get_boolean("Muskelversagen? (j: Ja/n: Nein): ")
            self.sets.append(set)
            if i != self.set_count - 1:
                timer(self.rest)
            else:
                print_green(f"Du hast {self.set_count} Sätze {self.exercise.name} erfolgreich absolviert")

    def save(self):
        performance_id =  super().save()
        for set in self.sets:
            set.save(performance_id, self.rest)
    
        