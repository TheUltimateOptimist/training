from abc import ABC, abstractmethod
from models.exercise import Exercise
from data.sdk import insert_performance
from models.set import Set
import time
from util.ansii import reset
from util.output import print_title
from util.input import get_positive_int, get_boolean

class Performance(ABC):
    def __init__(self, exercise_ids: int, variation_id: int) -> None:
            self.exercises: list[Exercise] = []
            for id in exercise_ids:
                self.exercises.append(Exercise(id))
            self.variation_id = variation_id
            self.start = time.time()
            self.sets: list[Set] = []

    @abstractmethod
    def perform(self):
        pass 

    def start_exercise(self, title: str, subtitle: str): 
        reset()
        print_title(title)
        print(subtitle)

    def add_set(self, set: Set, ask_for_failure = True):
        set.weight = self.get_weight()
        set.reps = self.get_reps()
        if ask_for_failure:
            set.reached_failure = self.get_reached_failure()
        self.sets.append(set)

    def get_weight(self):
        return get_positive_int("Gewicht in kg: ")

    def get_reps(self):
        return get_positive_int("Wiederholungen: ")

    def get_reached_failure(self):
        return get_boolean("Muskelversagen? (j: Ja/n: Nein): ")

    def save(self):
        performance_id = insert_performance(self.start, time.time(), self.variation_id) 
        for set in self.sets:
            set.save(performance_id)  