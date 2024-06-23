import 'package:flutter/material.dart';
import 'principal_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String selectedDocumentType = 'DNI';
  TextEditingController documentController = TextEditingController();
  bool isButtonEnabled = false;

  void _checkInput() {
    setState(() {
      isButtonEnabled = documentController.text.isNotEmpty;
    });
  }

  void _navigateToHome() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MyHomePage()), // Ajusta esto según tu HomePage
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: [
                Image.network(
                  'https://images.unsplash.com/photo-1513593771513-7b58b6c4af38?q=80&w=1932&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 10,
                  left: 70,
                  child: Text(
                    '¡Qué gusto verte en la\nApp RIMAC!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Ingresa tu documento',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: DropdownButtonHideUnderline(
                            child: ButtonTheme(
                              alignedDropdown: true,
                              child: DropdownButton<String>(
                                value: selectedDocumentType,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedDocumentType = newValue!;
                                  });
                                },
                                items: <String>[
                                  'DNI',
                                  'CE',
                                  'PAS'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: TextField(
                            controller: documentController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Nro. de documento',
                              contentPadding: EdgeInsets.all(8.0),
                            ),
                            onChanged: (text) => _checkInput(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isButtonEnabled ? _navigateToHome : null,
                      child: Text('Continuar'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor:
                            isButtonEnabled ? Colors.red : Colors.grey,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        textStyle: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                   
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(
      home: LoginScreen(),
    ));
