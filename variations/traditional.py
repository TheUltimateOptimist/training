from models.performance import Performance
from models.set import Set
from util.ansii import timer
from util.output import print_green

class Traditional(Performance):
    def __init__(self, exercise_id: int, sets: int, rest: int) -> None:
        super().__init__([exercise_id], 1)
        self.set_count = sets
        self.rest = rest

    def perform(self):
        for i in range(self.set_count):
            self.start_exercise(
                self.exercises[0].name,
                f"Führe den {i + 1}. von {self.set_count} Sätzen aus!"
            )
            set = Set(i + 1, self.exercises[0].id, self.rest)
            self.add_set(set)
            if i < self.set_count - 1:
                timer(self.rest)
            else:
                print_green(f"Du hast {self.set_count} Sätze {self.exercises[0].name} erfolgreich absolviert")