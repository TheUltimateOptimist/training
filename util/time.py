from datetime import datetime
import time

def current() -> str:
    return to_string(time.time())

def to_string(timestamp: float) -> str:
    the_time = datetime.fromtimestamp(timestamp)
    return the_time.strftime('%Y-%m-%d %H:%M:%S')