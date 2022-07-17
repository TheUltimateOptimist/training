from typing import Any


class Table:
    def __init__(self, table: list[tuple[Any]], column_names: list[str]) -> None:
        self.table = table
        self.column_names = column_names
        self.max_lengths: list[int] = None
        self.bar: str = None
    
    def print(self, show_indices: bool = False):
        if show_indices:
            self.__add_indices()
        self.__calculate_lengths()
        self.__create_bar()
        print(self.bar)
        self.__print_column_names()
        print(self.bar)
        self.__print_entrys()
        print(self.bar)

    def __add_indices(self):
        for i,row in enumerate(self.table):
            row = list(row)
            row.insert(0, str(i + 1))
            row = tuple(row)
            self.table[i] = row
        self.column_names.insert(0, "")

    def __calculate_lengths(self) -> list[int]:
        self.max_lengths = []
        for element in self.column_names:
            self.max_lengths.append(len(str(element)))
        for row in self.table:
            for i, value in enumerate(row):
                item_length = len(str(value))
                if item_length > self.max_lengths[i]:
                    self.max_lengths[i] = item_length

    def __create_bar(self) -> str:
        self.bar = "+"
        for length in self.max_lengths:
            self.bar += length*"-" + "-+"

    def __print_column_names(self):
        line = "| "
        for i,element in enumerate(self.column_names):
            line = line + f"{element}{(self.max_lengths[i] - len(str(element)))*' '}| "
        print(line)

    def __print_entrys(self):
        for row in self.table:
            line = "| "
            for i, element in enumerate(row):
                empty_space = (self.max_lengths[i] - len(str(element)))*' '
                line+=f"{element}{empty_space}| "
            print(line)

Table([("hallo", "welt"), ("das Wetter ist", "schön")], ["eins", "zwei"]).print(True)