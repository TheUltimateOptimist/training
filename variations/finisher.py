from models.performance import Performance
from models.exercise import Exercise
from data.sdk import insert_finisher
from util.ansii import reset, timer
from util.output import print_title, print_green, print_red
from util.input import get_positive_int

class Finisher(Performance):
    def __init__(self, exercise: Exercise) -> None:
        super().__init__(exercise, 2)   
        self.weight: int = None
        self.max_reps: int = None
        self.twice_weight = None
        self.twice_reps: int = None

    def perform(self):
        reset()
        print_title(self.exercise.name + " Finisher")
        print("Führe so viele Wiederholungen wie möglich durch!")
        self.weight = get_positive_int("Gewicht: ")
        self.max_reps = get_positive_int("Wiederholungen: ")
        print("")
        print("Führe mindestens doppelt so viele Wiederholungen wie zuvor durch, während der folgende Timer runterläuft!")
        timer(270)
        self.twice_weight = get_positive_int("Gewicht: ")
        self.twice_reps = get_positive_int("Wiederholungen: ")
        if self.twice_reps >= 2*self.max_reps:
            print_green(f"Du hast den {self.exercise.name} Finisher erfolgreich absolviert!")
        else:
            print_red(f"Du bis an dem {self.exercise.name} Finisher gescheitert!")


    def save(self):
        p_id =  super().save()
        insert_finisher(self.weight, self.max_reps, self.twice_weight, self.twice_reps, p_id)