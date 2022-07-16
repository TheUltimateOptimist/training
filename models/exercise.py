from data.sdk import get_exercise

class Exercise:
    def __init__(self, id: int) -> None:
        self.id = id
        tuple = get_exercise(self.id)
        self.name = tuple[0]
        self.description = tuple[1]