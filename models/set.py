from data.sdk import insert_set

class Set:
    def __init__(self, number: int, exercise_id: int, rest: int) -> None:
        self.number = number
        self.exercise_id = exercise_id
        self.rest = rest
        self.weight: int = None
        self.reps: int = None
        self.reached_failure: bool = True

    def save(self, performance_id: int):
        insert_set(self.weight, self.number, self.reps, self.reached_failure, performance_id, self.exercise_id, self.rest)
