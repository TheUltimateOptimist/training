from performance import Performance
from exercise import Exercise
from sdk import insert_finisher
from ansii import reset, timer
from output import print_title, print_green, print_red
from input import get_positive_int

class Finisher(Performance):
    def __init__(self, exercise: Exercise, variation_id: int) -> None:
        super().__init__(exercise, variation_id)     
        self.max_reps: int = None
        self.twice_reps: int = None

    def perform(self):
        reset()
        print_title(self.exercise.name + " Finisher")
        print("Führe so viele Wiederholungen wie möglich durch!")
        self.max_reps = get_positive_int("Wiederholungen: ")
        print("")
        print("Führe mindestens doppelt so viele Wiederholungen wie zuvor durch, während der folgende Timer runterläuft!")
        timer(270)
        self.twice_reps = get_positive_int("Wiederholungen: ")
        if self.twice_reps >= 2*self.max_reps:
            print_green(f"Du hast den {self.exercise.name} Finisher erfolgreich absolviert!")
        else:
            print_red(f"Du bis an dem {self.exercise.name} Finisher gescheitert!")


    def save(self):
        p_id =  super().save()
        insert_finisher(self.max_reps, self.twice_reps, p_id)