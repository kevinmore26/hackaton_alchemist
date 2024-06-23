from  flask_sqlalchemy import SQLAlchemy
from app import db

# db.create_all()

# Definición del modelo User
class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(80), unique=True, nullable=False)
    email = db.Column(db.String(120), unique=True, nullable=False)

    def __repr__(self):
        return '<User %r>' % self.usernameFl

class Score(db.Model):
    idscore = db.Column(db.Integer, primary_key=True)
    idPersona = db.Column(db.Integer, nullable=False)
    idUserDacadoo = db.Column(db.String(120),  nullable=False)
    date = db.Column(db.Date , unique=True, nullable=False)
    dateTime = db.Column(db.Date, unique=True, nullable=False)
    score = db.Column(db.Integer, nullable=False)
    feelings = db.Column(db.Integer, nullable=False)
    lifestyle = db.Column(db.Integer, nullable=False)
    body = db.Column(db.Integer, nullable=False)
    movement = db.Column(db.Integer, nullable=False)
    nutrition = db.Column(db.Integer, nullable=False)
    smoking = db.Column(db.Integer, nullable=False)
    obesity = db.Column(db.Integer, nullable=False)
    sleep = db.Column(db.Integer, nullable=False)
    wellness = db.Column(db.Integer, nullable=False)
    stress = db.Column(db.Integer, nullable=False)
    depression = db.Column(db.Integer, nullable=False)
    indulgences = db.Column(db.Integer, nullable=False)
    mindfulness = db.Column(db.Integer, nullable=False)
    platform = db.Column(db.String(50), nullable=False)  

    def __repr__(self):
        return '<Score %r>' % self.idPersona
