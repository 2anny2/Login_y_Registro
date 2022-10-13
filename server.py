from login_registro_app import app
from login_registro_app.controllers import users_controllers
app.secret_key = "supersecreto"

if __name__=="__main__": 
    app.run(debug=True)   