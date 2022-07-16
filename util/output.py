def print_red(text: str, end="\n"):
    print(f"\x1B[38;5;196m{text}\x1B[0m", end=end)

def print_green(text: str, end="\n"):
    print(f"\x1B[38;5;46m{text}\x1B[0m", end=end)

def print_title(title: str):
    print(f"\x1B[38;5;195m{title}\x1B[0m", end="\n\n")