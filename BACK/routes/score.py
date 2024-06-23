from flask import Blueprint, jsonify, request
from models import Score
from app import db
from datetime import datetime

score_blueprint = Blueprint('scores', __name__, url_prefix='/api/scores')

# Ruta para obtener todos los usuarios
@score_blueprint.route('', methods=['GET'])
def get_scores():
    scores = Score.query.all()
    if not scores:
        return jsonify({'error': 'No hay información'})

    
    user_list = [{'idscore' : score.idscore,'idPersona' : score.idPersona,'idUserDacadoo' : score.idUserDacadoo,'date' : str(score.date),'dateTime' : str(score.dateTime),'score' : score.score,'feelings' : score.feelings,'lifestyle' : score.lifestyle,'body' : score.body,'movement' : score.movement,'nutrition' : score.nutrition,'smoking' : score.smoking,'obesity' : score.obesity,'sleep' : score.sleep,'wellness' : score.wellness,'stress' : score.stress,'depression' : score.depression,'indulgences' : score.indulgences,'mindfulness' : score.mindfulness,'platform' : score.platform} for score in scores]
    return jsonify(user_list)

# Ruta para crear un nuevo usuario
@score_blueprint.route('', methods=['POST'])
def create_score():
    data = request.get_json()
    idPersona=data.get('idPersona')
    idUserDacadoo=data.get('idUserDacadoo')
    date=data.get('date')
    dateTime=data.get('dateTime')
    score=data.get('score')
    feelings=data.get('feelings')
    lifestyle=data.get('lifestyle')
    body=data.get('body')
    movement=data.get('movement')
    nutrition=data.get('nutrition')
    smoking=data.get('smoking')
    obesity=data.get('obesity')
    sleep=data.get('sleep')
    wellness=data.get('wellness')
    stress=data.get('stress')
    depression=data.get('depression')
    indulgences=data.get('indulgences')
    mindfulness=data.get('mindfulness')
    platform=data.get('platform')


    # if not username or not email:
        # return jsonify({'error': 'Debe proporcionar nombre de usuario y correo electrónico'}), 400   
     
    new_score = Score(idPersona=idPersona,idUserDacadoo=idUserDacadoo,date=date,dateTime=dateTime,score=score,feelings=feelings,lifestyle=lifestyle,body=body,movement=movement,nutrition=nutrition,smoking=smoking,obesity=obesity,sleep=sleep,wellness=wellness,stress=stress,depression=depression,indulgences=indulgences,mindfulness=mindfulness,platform=platform)
    db.session.add(new_score)
    db.session.commit()

    return jsonify({'message': 'Usuario creado correctamente', 'id': new_score.idscore}), 201

# Ruta para obtener detalles de un usuario por su ID
@score_blueprint.route('/<int:user_id>', methods=['GET'])
def get_score(user_id):
    scores = Score.query.filter_by(idPersona=user_id)
    if not scores:
        return jsonify({'error': 'Usuario no encontrado'}), 404

    user_score = [{'idPersona' : score.idPersona,'idUserDacadoo' : score.idUserDacadoo,'date' :  str(score.date)  ,'dateTime' : str(score.dateTime), 'score' : score.score,'feelings' : score.feelings,'lifestyle' : score.lifestyle,'body' : score.body,'movement' : score.movement,'nutrition' : score.nutrition,'smoking' : score.smoking,'obesity' : score.obesity,'sleep' : score.sleep,'wellness' : score.wellness,'stress' : score.stress,'depression' : score.depression,'indulgences' : score.indulgences,'mindfulness' : score.mindfulness,'platform' : score.platform} for score in scores]
    return jsonify(user_score)    
