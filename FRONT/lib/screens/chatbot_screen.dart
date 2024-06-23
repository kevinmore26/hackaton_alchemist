import 'package:flutter/material.dart';
import 'package:ikchatbot/ikchatbot.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final List<String> keywords = [
  'quién eres',
  'qué es RIMAC',
  'gracias',
  'adiós',
  'qué seguros ofrecen',
  'seguro de salud',
  'seguro de auto',
  'seguro de hogar',
  'seguro de vida',
  'cómo reclamar un seguro',
  'contactar soporte',
  'ubicación',
  'me siento triste',
  'ansiedad',
  'estrés',
  'bienestar mental',
  'quiero hablar con alguien',
  'recomendaciones de salud'
];

final List<String> responses = [
  'Soy un chatbot creado por DATA ALCHEMIST para asistirte con los servicios de RIMAC Seguros.',
  'RIMAC es una de las compañías de seguros más grandes de Perú, ofreciendo una amplia gama de productos y servicios de seguros.',
  '¡De nada!',
  '¡Adiós! ¡Que tengas un buen día!',
  'Ofrecemos una variedad de seguros, incluyendo seguros de salud, seguros de auto, seguros de hogar y seguros de vida. ¿En qué puedo ayudarte?',
  'Nuestros planes de seguro de salud cubren una amplia gama de servicios médicos y tratamientos. ¿Te gustaría más detalles?',
  'Nuestras pólizas de seguro de auto proporcionan una cobertura integral para tu vehículo. ¿Te gustaría saber más?',
  'Ofrecemos seguros de hogar para proteger tu casa y tus pertenencias. ¿Te gustaría más información?',
  'Nuestras pólizas de seguro de vida están diseñadas para brindar seguridad financiera a tus seres queridos. ¿Te gustaría más detalles?',
  'Para reclamar un seguro, por favor visita nuestro sitio web y llena el formulario de reclamación. Para más ayuda, puedes contactar a nuestro equipo de soporte.',
  'Puedes contactar a nuestro equipo de soporte en soporte@rimac.com o llamarnos al (01) 411-1111.',
  'Nuestra oficina principal está ubicada en Av. Paseo de la República 3505, Lima, Perú.',
  'Lamento que te sientas triste. Es importante hablar con alguien de confianza. ¿Te gustaría recomendaciones para sentirte mejor?',
  'La ansiedad puede ser muy difícil de manejar. Considera técnicas de relajación como la meditación o el ejercicio. Si necesitas hablar con alguien, estamos aquí para ayudarte.',
  'El estrés es común, pero hay muchas maneras de manejarlo. Intenta realizar actividades que disfrutes o habla con un profesional de salud mental.',
  'El bienestar mental es muy importante. Te recomendamos cuidar tu salud física, mantener conexiones sociales y buscar ayuda profesional si es necesario.',
  'Entiendo que quieras hablar con alguien. Puedes contactar a nuestro equipo de soporte para recibir la ayuda que necesitas.',
  'Para mejorar tu salud, te recomendamos mantener una dieta equilibrada, hacer ejercicio regularmente y realizar chequeos médicos periódicos.'
];

class ChatbotScreen extends StatelessWidget {
  final chatBotConfig = IkChatBotConfig(
    // Configuración del rating por correo SMTP
    ratingIconYes: const Icon(Icons.star),
    ratingIconNo: const Icon(Icons.star_border),
    ratingIconColor: Colors.black,
    ratingBackgroundColor: Colors.white,
    ratingButtonText: 'Enviar calificación',
    thankyouText: '¡Gracias por tu calificación!',
    ratingText: 'Califica tu experiencia:',
    ratingTitle: '¡Gracias por usar el chatbot!',
    body: 'Este es un correo de prueba enviado desde Flutter y Dart.',
    subject: 'Prueba de calificación',
    recipient: 'recipient@example.com',
    isSecure: false,
    senderName: 'Tu Nombre',
    smtpUsername: 'Tu Email',
    smtpPassword: 'Tu contraseña',
    smtpServer: 'smtp.gmail.com',
    smtpPort: 587,
    // Configuración del sistema
    sendIcon: const Icon(Icons.send, color: Colors.black),
    userIcon: const Icon(Icons.animation, color: Colors.white),
    botIcon: const Icon(Icons.android, color: Colors.white),
    botChatColor: Color.fromARGB(114, 187, 11, 227),
    delayBot: 100,
    closingTime: 1,
    delayResponse: 1,
    userChatColor: Color(0xFFf7052d),
    waitingTime: 1,
    keywords: keywords,
    responses: responses,
    backgroundColor: Colors.white,
    backgroundImage:
        'https://i.pinimg.com/736x/d2/bf/d3/d2bfd3ea45910c01255ae022181148c4.jpg',
    backgroundAssetimage: 'lib/assets/bg.jpeg',
    initialGreeting: "👋 ¡Hola! \nBienvenido a RIMAC ChatBot.\n¿Cómo puedo ayudarte hoy?",
    defaultResponse: "Lo siento, no entendí tu respuesta.",
    inactivityMessage: "¿Hay algo más en lo que pueda ayudarte?",
    closingMessage: "Esta conversación se cerrará ahora.",
    inputHint: 'Envía un mensaje',
    waitingText: 'Por favor espera...',
    useAsset: false,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('RIMAC Chatbot'),
      ),
      body: ikchatbot(config: chatBotConfig),
    );
  }
}

// Función para interactuar con la API de Ollama
Future<String> fetchOllamaResponse(String prompt) async {
  const url = 'http://localhost:11434/api/chat';
  const headers = {'Content-Type': 'application/json'};
  final body = jsonEncode({
    "model": "crewai-llama2",
    "messages": [
      {
        "role": "user",
        "content": prompt
      }
    ],
    "stream": false
  });

  final response = await http.post(Uri.parse(url), headers: headers, body: body);

  if (response.statusCode == 200) {
    final responseData = jsonDecode(response.body);
    return responseData['message']; // Ajusta esto según la estructura de tu respuesta
  } else {
    throw Exception('Failed to fetch response from Ollama API');
  }
}
