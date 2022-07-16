from models.performance import Performance
from variations.finisher import Finisher
from data.sdk import enter_training, finish_training
from variations.traditional import Traditional
from variations.torcher_one import TorcherOne

def enter(is_alone: bool, is_with_bike: bool, temperature: int):
    enter_training(is_alone, is_with_bike, temperature)

def traditional(exercise_id: int, sets: int, rest: int):
    perform(Traditional(exercise_id, sets, rest))

def finisher(exercise_id: int):
    perform(Finisher(exercise_id))
    

def torcher_one(exercise_ids: list[int]):
    perform(TorcherOne(exercise_ids))

def perform(performance: Performance):
    performance.perform()
    performance.save()


def quit():
    finish_training()