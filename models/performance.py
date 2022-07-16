from abc import ABC, abstractmethod
from exercise import Exercise
from sdk import insert_performance
import time

class Performance(ABC):
    def __init__(self, exercise: Exercise, variation_id: int) -> None:
            self.exercise = exercise
            self.variation_id = variation_id
            self.start = time.time()

    @abstractmethod
    def perform(self):
        pass

    def save(self):
        return insert_performance(self.start, time.time(), self.exercise.id, self.variation_id) 
    