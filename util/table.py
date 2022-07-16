from __future__ import annotations


class Table:
    @staticmethod
    def __print_table(table: list[list[str]], show_indices: bool = False):
        """
        prints table to the console using the given options
        :param table: the table to print to the console
        :param column_names: the names for the columns of table (for the header row)
        :param column_names_color: color for the column names
        :param entry_colors: color for entry values of the table
        :param surrounding_color: color of the table grid
        :param show_indices: adds indices to the table
        """
        if show_indices:
            for i,row in enumerate(table):
                row.reverse()
                if i == 0:
                    row.append("")
                else:
                    row.append(str(i))
                row.reverse()

        max_lengths = []
        for i, row in enumerate(table):
            for j, value in enumerate(row):
                if (i != 0 and len(str(value)) > max_lengths[j]) or i == 0:
                    max_lengths[j] = len(str(value))

        # print table
        # print top Bar
        top_bar = "+"
        for length in max_lengths:
            top_bar = top_bar + length * "-" + "-+"
        print(top_bar)

        # print column names
        s = "| "
        for i,element in enumerate(table[0]):
            s = s + f"{element}{(max_lengths[i] - len(element))*' '}| "
        print(s)

        # print bottomBar
        print(top_bar)






        
        # print entries
        for i in range(len(table)):
            entry = colored("| ", surrounding_color)
            for j in range(len(column_names)):
                entry = entry + colored(table[i][j], entry_colors[i]) + (
                        max_lengths[j] - len(table[i][j])) * " " + colored("| ", surrounding_color)
            print(entry)

        # print end bar
        print(colored(top_bar, surrounding_color))    