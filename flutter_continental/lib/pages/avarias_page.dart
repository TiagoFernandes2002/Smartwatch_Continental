import 'package:flutter/material.dart';
import '../Controllers/AvariaClasse.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';

class AvariasPage extends StatelessWidget {
  const AvariasPage({Key? key}) : super(key: key);

  Future<String?> getToken() async {
    User? user = FirebaseAuth.instance.currentUser;
    return user?.getIdToken();
  }

  Future<List<AvariaNotification>> getAvarias() async {
    final token = await getToken();
    final url = Uri.http('192.168.28.86:7071', 'Alert/GetMaintenanceMessages');

    final response =
        await http.get(url, headers: {'Authorization': 'Bearer $token'});

    final body = jsonDecode(response.body);

    return body.map<AvariaNotification>(AvariaNotification.fromJson).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 0,
              child: SizedBox(
                width: double.infinity,
                child: Card(
                  color: Colors.black12,
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text('Avarias',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.orangeAccent.shade400)),
                              const SizedBox(width: 10),
                              Icon(Icons.message,
                                  color: Colors.orangeAccent.shade400),
                            ],
                          ),
                        ],
                      )),
                ),
              ),
            ),
            Expanded(
              flex: 10,
              child: FutureBuilder<List<AvariaNotification>>(
                future: getAvarias(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Erro: ${snapshot.error}');
                  } else {
                    var avarias = snapshot.data;
                    if (avarias == null || avarias.isEmpty) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.build, size: 50, color: Colors.orangeAccent.shade400),
                          Text('Não existem',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.orangeAccent.shade400)),
                          Text('registos de Avarias',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.orangeAccent.shade400)),
                        ],
                      );
                    } else {
                      // Sort the list of avarias by prioridade in descending order
                      avarias.sort((a, b) => int.parse(b.prioridade).compareTo(int.parse(a.prioridade)));
                      
                      return ListView.separated(
                        shrinkWrap: true,
                        itemCount: avarias.length,
                        itemBuilder: ((context, index) {
                          var avaria = avarias[index];

                          int prioridadeInt;
                          try {
                            prioridadeInt = int.parse(avaria.prioridade);
                          } catch (_) {
                            // If the parse fails, we default it to 0
                            prioridadeInt = 0;
                          }

                          String prioridadeText = avaria.prioridade;
                          Color textColor = Colors.white;

                          switch (prioridadeInt) {
                            case 3:
                              prioridadeText = 'Elevada';
                              textColor = Color(0xffd00000);
                              break;
                            case 2:
                              prioridadeText = 'Moderada';
                              textColor = Color(0xffe85d04);
                              break;
                            case 1:
                              prioridadeText = 'Baixa';
                              textColor = Color(0xffffba08);
                              break;
                            default:
                              textColor = Colors.white;
                          }

                          return Card(
                            color: Colors.black12.withOpacity(
                                0.5),
                            child: ListTile(
                              title: Text('Linha: ${avaria.linhaId}',
                                  style: const TextStyle(
                                      fontSize: 13, color: Colors.white)),
                              trailing: Text(
                                prioridadeText,
                                style: TextStyle(
                                    fontSize: 13, color: textColor),
                              ),
                            ),
                          );
                        }),
                        separatorBuilder: (_, __) => const Divider(),
                      );
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
