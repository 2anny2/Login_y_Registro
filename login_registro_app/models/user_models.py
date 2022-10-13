from login_registro_app.config.mysqlconnection import connectToMySQL
from flask import flash
import re
EMAIL_REGEX = re.compile(r'^[a-zA-Z0-9.+_-]+@[a-zA-Z0-9._-]+\.[a-zA-Z]+$') 

class Users:
	
    db="login_registro"

    def __init__ (self,data):
        self.id = data['id']
        self.first_name = data['first_name']
        self.last_name = data['last_name']
        self.email = data['email']
        self.password = data['password']


    @classmethod
    def all_users(cls):
        query = "SELECT * FROM users;"
        resultado =  connectToMySQL(cls.db).query_db(query)
        registro_usuarios =[]
        for i in resultado:
            registro_usuarios.append(cls(i))
        return registro_usuarios
    

    @classmethod
    def get_user(cls, data):
        query = "SELECT * FROM users WHERE id=%(id)s;"
        resultado = connectToMySQL(cls.db).query_db(query, data )
        return cls(resultado[0])


    @classmethod
    def obtener_email(cls,data):
        query = "SELECT * FROM users WHERE email = %(email)s;"
        result = connectToMySQL(cls.db).query_db(query,data)
        
        if len(result) < 1:
            return False
        return cls(result[0])


    @classmethod
    def save(cls,data):
        query = "INSERT INTO users (first_name,last_name,email,password) VALUES (%(first_name)s,%(last_name)s,%(email)s,%(password)s);"
        return connectToMySQL(cls.db).query_db(query, data)

    @staticmethod
    def validate(registro): 
        
        correo = {
            'email':registro['email']
        }

        is_valid = True
        if len(registro['first_name']) < 4:
            flash("First name : at least 2 characters")
            is_valid = False
        if len(registro['last_name']) < 4:
            flash("Last name: at least 2 characters")
            is_valid = False
        if not EMAIL_REGEX.match(correo['email']):
            flash("You must enter a valid email")
            is_valid = False
        elif Users.obtener_email(correo):
            flash("Email already registered!!!")
            is_valid = False
        if len(registro['password']) < 6:
            flash("password : at least 6 characters")
            is_valid = False
        if registro['password'] != registro['confirm_password']:
            flash("Password do not match!!!")
            is_valid = False
        return is_valid
