import time
from output import print_green

def reset():
    delete = "\x1B[2J"
    home = "\x1B[H"
    print(delete+home, end="")

def timer(seconds: int):
    print("\x1B[s", end="")
    for second in range(seconds):
        time.sleep(1)
        print("\x1B[2K", end="")
        print("\x1B[u", end="")
        print_green(str(seconds - second - 1), end="")
    print("")