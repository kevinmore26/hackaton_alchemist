from flask import Flask
from flask_sqlalchemy import SQLAlchemy

# import models


# Configuración de la aplicación Flask
app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql://root:1234@localhost:3306/reto_bienestar_db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False  # Desactivamos el seguimiento de modificaciones para evitar advertencias

# Inicialización de la base de datos

# Inicialización de SQLAlchemy
db = SQLAlchemy(app)

# Importar rutas
from routes.routes import users_blueprint
from routes.score import score_blueprint

# Registrar blueprints
# app.register_blueprint(users_blueprint)

app.register_blueprint(users_blueprint)

app.register_blueprint(score_blueprint)


if __name__ == '__main__':
    with app.app_context():
        db.create_all()

    app.run(debug=True)
