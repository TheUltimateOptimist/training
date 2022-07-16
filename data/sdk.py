from data.database import Database
from util.time import to_string, current

def get_training_id():
    sql_query = "SELECT MAX(t_id) FROM training"
    return Database.get_instance().get(sql_query)[0][0]

def get_exercise(id: int) -> tuple:
    sql_query = f"SELECT ex_name, ex_description FROM exercises WHERE ex_id = {id}"
    return Database.get_instance().get(sql_query)[0]

def insert_performance(start: float, end: float, exercise_id: int, variation_id: int) -> int:
    sql_query = f"INSERT INTO performances (p_start, p_end, p_ex_id, p_v_id, p_t_id) VALUES('{to_string(start)}', '{to_string(end)}', {exercise_id}, {variation_id}, {get_training_id()})"
    Database.get_instance().post(sql_query)
    return Database.get_instance().get("SELECT max(p_id) FROM performances")[0][0]

def insert_set(weight: int, number: int, reps: int, reached_failure: bool, p_id: int, rest: int):
    sql_query = f"INSERT INTO sets (set_weight, set_number, set_repetitions, set_reached_failure, set_p_id, rest) VALUES({weight}, {number}, {reps}, {str(reached_failure)}, {p_id}, {rest})"
    Database.get_instance().post(sql_query)

def enter_training(is_alone: bool, with_bike: bool, temperature: int):
    sql_query = f"INSERT INTO training(t_start, t_alone, t_with_bike, t_temperature) VALUES('{current()}', {str(is_alone)}, {str(with_bike)}, {temperature})"
    Database.get_instance().post(sql_query)

def insert_finisher(weight: int, max_reps: int, twice_weight: int, twice_reps: int, p_id: int):
    sql_query = f"INSERT INTO finishers(f_weight, f_max, f_twice_weight, f_twice, f_p_id) VALUES({weight}, {max_reps}, {twice_weight}, {twice_reps}, {p_id})"
    Database.get_instance().post(sql_query)

def finish_training():
    sql_query = f"UPDATE training set t_end = '{current()}' WHERE t_id = {get_training_id()}"
    Database.get_instance().post(sql_query)

def exercise_statistic(exercise_id: int):
    sql_query = f"select set_weight, set_repetitions, set_reached_failure, rest from sets left join performances on p_id = set_p_id left join exercises on ex_id = p_ex_id where ex_id = {exercise_id}"
    table: list[tuple] = Database.get_instance().get(sql_query)