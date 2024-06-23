from flask import Blueprint, jsonify, request
from models import User
from app import db

users_blueprint = Blueprint('users', __name__, url_prefix='/api/users')

# Ruta para obtener todos los usuarios
@users_blueprint.route('', methods=['GET'])
def get_users():
    users = User.query.all()
    user_list = [{'id': user.id, 'username': user.username, 'email': user.email} for user in users]
    return jsonify(user_list)

# Ruta para crear un nuevo usuario
@users_blueprint.route('', methods=['POST'])
def create_user():
    data = request.get_json()
    username = data.get('username')
    email = data.get('email')

    if not username or not email:
        return jsonify({'error': 'Debe proporcionar nombre de usuario y correo electrónico'}), 400

    new_user = User(username=username, email=email)
    db.session.add(new_user)
    db.session.commit()

    return jsonify({'message': 'Usuario creado correctamente', 'id': new_user.id}), 201

# Ruta para obtener detalles de un usuario por su ID
@users_blueprint.route('/<int:user_id>', methods=['GET'])
def get_user(user_id):
    user = User.query.get(user_id)
    if not user:
        return jsonify({'error': 'Usuario no encontrado'}), 404

    return jsonify({'id': user.id, 'username': user.username, 'email': user.email})

# Ruta para actualizar los detalles de un usuario por su ID
@users_blueprint.route('/<int:user_id>', methods=['PUT'])
def update_user(user_id):
    user = User.query.get(user_id)
    if not user:
        return jsonify({'error': 'Usuario no encontrado'}), 404

    data = request.get_json()
    username = data.get('username')
    email = data.get('email')

    if username:
        user.username = username
    if email:
        user.email = email

    db.session.commit()

    return jsonify({'message': 'Usuario actualizado correctamente'})

# Ruta para eliminar un usuario por su ID
@users_blueprint.route('/<int:user_id>', methods=['DELETE'])
def delete_user(user_id):
    user = User.query.get(user_id)
    if not user:
        return jsonify({'error': 'Usuario no encontrado'}), 404

    db.session.delete(user)
    db.session.commit()

    return jsonify({'message': 'Usuario eliminado correctamente'})


