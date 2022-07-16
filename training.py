from models.exercise import Exercise
from variations.finisher import Finisher
from data.sdk import enter_training, finish_training
from variations.traditional import Traditional

def enter(is_alone: bool, is_with_bike: bool, temperature: int):
    enter_training(is_alone, is_with_bike, temperature)

def traditional(exercise_id: int, sets: int, rest: int):
    exercise = Exercise(exercise_id)
    performance = Traditional(exercise, sets, rest)
    performance.perform()
    performance.save()

def finisher(exercise_id: int):
    exercise = Exercise(exercise_id)
    finisher = Finisher(exercise)
    finisher.perform()
    finisher.save()

def quit():
    finish_training()