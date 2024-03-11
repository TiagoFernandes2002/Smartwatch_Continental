import 'package:flutter/material.dart';
import 'package:flutter_continental/Controllers/AvariaClasse.dart';

class AvariaDetailPage extends StatelessWidget {
  final AvariaNotification avaria;

  AvariaDetailPage({required this.avaria, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.5, vertical: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header card with back button and title
              Card(
                color: Colors.grey[800],
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          icon: Icon(Icons.arrow_back, color: Colors.orangeAccent),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),
                      Spacer(),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Linha ${avaria.linhaId}",
                          style: TextStyle(color: Colors.orangeAccent, fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              infoCard("Id de Avaria", avaria.id),
              SizedBox(height: 10.0),
              infoCard("Id de funcionario", avaria.funcionarioId),
              SizedBox(height: 10.0),
              infoCard("Prioridade", avaria.prioridade),
              SizedBox(height: 10.0),
              infoCard("Data", avaria.criacao),
            ],
          ),
        ),
      ),
    );
  }

  Widget infoCard(String title, dynamic info) {
    return Card(
      color: Colors.grey[800],
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0.5),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            SizedBox(height: 10.0),
            Text(
              info.toString(),
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
