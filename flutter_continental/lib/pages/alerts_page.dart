import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Controllers/HomeController.dart';
import 'package:get/get.dart' hide Response;
import 'package:dio/dio.dart';

class AlertsPage extends StatelessWidget {
  const AlertsPage({super.key});

  void postAlert() async {
    User? user = FirebaseAuth.instance.currentUser;
    String? token = await user?.getIdToken();
    String funcionarioId = user?.displayName ?? '';
    HomeController homeController = Get.find<HomeController>();
    int linhaId = homeController.selectedLine.value;

    final dio = Dio();

    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers["authorization"] = "Bearer ${token ?? ''}";

    final data = {
      'id': 0,
      'funcionarioId': funcionarioId,
      'linhaId': linhaId,
      'tipo': 'Avaria',
      'prioridade': '2',
      'estado': true,
      'criacao': DateTime.now().toIso8601String(),
    };

    try {
      Response response = await dio
          .post('http://192.168.28.86:7071/Alert/SendAlert', data: data);
      print(response);
    } on DioError catch (e) {
      print('Error: ${e.error}');
      print('Error info: ${e.response?.data}');
    }
  }

  @override
  Widget build(BuildContext context) {
    Color myColor = const Color.fromRGBO(64, 64, 64, 0.4);
    return Scaffold(
      body: Container(
        color: Colors.black87,
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.security_update_warning_outlined,
                    size: 40.0,
                    color: Colors.orangeAccent.shade400,
                  ),
                  Container(
                    width: 170,
                    height: 42,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: myColor,
                    ),
                    child: textSection,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          postAlert();
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green),
                        ),
                        child: const Text('Sim'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red.shade600),
                        ),
                        child: const Text('Não'),
                      ),
                    ],
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

Widget textSection = const Padding(
  padding: EdgeInsets.all(3),
  child: Text(
    'Queres enviar um Alerta?',
    softWrap: true,
    style: TextStyle(fontSize: 15, color: Colors.white),
    textAlign: TextAlign.center,
  ),
);
