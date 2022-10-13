from login_registro_app import app
from login_registro_app.models.user_models import Users
from flask import render_template, redirect, request, session, flash
from flask_bcrypt import Bcrypt

bcrypt = Bcrypt(app)

@app.route('/')
def raiz():
    return render_template("users.html")

@app.route("/crear", methods=['POST'])
def crear_usuario():
	
    if not Users.validate(request.form):
        return redirect ('/')
    pw_hash = bcrypt.generate_password_hash(request.form['password'])
    print(pw_hash)

    data = {
        "first_name": request.form['first_name'],
        "last_name": request.form['last_name'],
        "email": request.form['email'],
        "password" : pw_hash
    }

    user_id = Users.save(data)
    session['user_id'] = user_id
    return redirect(f'/datos/{session["user_id"]}')


@app.route('/datos/<int:id>')
def dato(id):
    data = {
        "id":id
    }
    if not session:
        return redirect('/')
    usuario = Users.get_user(data)
    print(usuario)
    all_users = Users.all_users()
    return render_template("datos.html", all_ussers=all_users, usuario=usuario)

@app.route('/login',  methods=['POST'])
def login():

	
    data = { "email" : request.form["email"] }
    user_db = Users.obtener_email(data)
	
    if not user_db:
        flash("Email o contraseña invalida")
        return redirect("/")
    if not bcrypt.check_password_hash(user_db.password, request.form['password']):
        flash("Email o contraseña invalida")
        return redirect('/')

    session['user_id'] = user_db.id
    return redirect(f'/datos/{session["user_id"]}')
	

@app.route('/clearsession')
def clear():
    session.clear()
    return redirect('/')
