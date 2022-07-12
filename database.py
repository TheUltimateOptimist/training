import mysql.connector
from mysql.connector import MySQLConnection
from mysql.connector.cursor import MySQLCursor

class Database:
    __instance = None
    host = "localhost"
    user = "root"
    password = "#A1a1B2b2"
    database = "training"

    @staticmethod
    def get_instance():
        if Database.__instance == None:
            Database()
        return Database.__instance

    def __init__(self) -> None:
        if Database.__instance != None:
            raise Exception("This class is a Singleton!")
        self.connection: MySQLConnection = mysql.connector.connect(
            host="localhost",
            user="root",
            password="#A1a1B2b2",
            database="training"
        )
        Database.__instance = self

    def get(self, sql: str):
        cursor: MySQLCursor = self.connection.cursor()
        cursor.execute(sql)
        return cursor.fetchall()

    def post(self, sql: str):
        cursor: MySQLCursor = self.connection.cursor()
        cursor.execute(sql)
        self.connection.commit()
        return cursor.fetchall()

