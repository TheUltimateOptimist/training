from util.output import print_red

def get_boolean(message: str):
    while True:
        user_input = input(message)
        if user_input == "j":
            return True
        if user_input == "n":
            return False
        print_red("Gib j für Ja oder n für Nein ein!")

def get_positive_int(message: str) -> int:
    while True:
        try:
            user_input = input(message)
            result = int(user_input)
            if result < 0:
                raise ValueError()
            return user_input
        except:
            print_red("Deine Eingabe ist ungültig!")