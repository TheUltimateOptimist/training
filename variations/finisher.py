from models.performance import Performance
from models.set import Set
from util.ansii import timer
from util.output import print_green, print_red

class Finisher(Performance):
    def __init__(self, exercise_id: int) -> None:
        super().__init__([exercise_id], 2)   

    def perform(self):
        self.start_exercise(
            self.exercises[0].name + " Finisher",
            "Führe so viele Wiederholungen wie möglich durch!"
        )
        set_one = Set(1, self.exercises[0].id, 0)
        set_two = Set(2, self.exercises[0].id, 0)
        self.add_set(set_one, ask_for_failure=False)
        print("")
        print("Führe mindestens doppelt so viele Wiederholungen wie zuvor durch, während der folgende Timer runterläuft!")
        timer(270)
        self.add_set(set_two, ask_for_failure=False)
        if set_two.reps >= 2*set_one.reps:
            print_green(f"Du hast den {self.exercises[0].name} Finisher erfolgreich absolviert!")
        else:
            print_red(f"Du bis an dem {self.exercises[0].name} Finisher gescheitert!")