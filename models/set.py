from data.sdk import insert_set

class Set:
    def __init__(self, number: int) -> None:
        self.number = number
        self.weight: int = None
        self.reps: int = None
        self.reached_failure: bool = None

    def save(self, performance_id: int, rest: int):
        insert_set(self.weight, self.number, self.reps, self.reached_failure, performance_id, rest)
