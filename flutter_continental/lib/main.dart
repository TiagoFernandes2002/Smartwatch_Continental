import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_continental/pages/page_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_continental/pages/login_page.dart';
import 'package:dart_amqp/dart_amqp.dart';
import 'Controllers/HomeController.dart';
import 'package:get/get.dart';
import 'dart:convert';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyAppStatefulWidget());
}
class MyAppStatefulWidget extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyAppStatefulWidget> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    _setupRabbitMQ();

    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder<User?>(
        stream: _auth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const PageViewWidget();
          } else {
            return LoginPage();
          }
        },
      ),
    );
  }


  void _setupRabbitMQ() async {
    ConnectionSettings settings = ConnectionSettings(
      host: "192.168.28.86",
    );

    Client client = Client(settings: settings);
    client.channel().then((Channel channel) async {
      Queue queue = await channel.queue("notification");
      Exchange exchange = await channel.exchange("alertas", ExchangeType.TOPIC);
      Consumer consumer = await exchange
          .bindQueueConsumer("notification", ["alerts.maintenance.new"]);

      consumer.listen((AmqpMessage message) {
        print(" [x] Received alert: ${message.payloadAsJson}");

        var payload = message.payloadAsString != null
            ? jsonDecode(message.payloadAsString)
            : null;
        String? linhaId = payload != null ? payload['linhaId'] : null;

        // Now, you can show the AlertDialog with the data received.
        navigatorKey.currentState!.push(MaterialPageRoute<void>(
          builder: (BuildContext context) => Dialog(
            backgroundColor: Colors.grey[900],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            child: Container(
              width: 150.0, // You can adjust these values as per your need
              height: 90.0,
              padding: EdgeInsets.all(5.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Nova Avaria",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      linhaId != null
                          ? "Avaria na Linha $linhaId"
                          : "Recebida Nova Notificação de Avaria",
                      style: TextStyle(
                        fontSize: 8,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    TextButton(
                      child: Text(
                        'Ok',
                        style: TextStyle(
                          fontSize: 8,
                          color: Colors.lightBlue[300],
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
      });
    });
  }
}

Future<String?> getUserRole(User user) async {
  final IdTokenResult tokenResult = await user.getIdTokenResult();
  final claims = tokenResult.claims;

  if (claims != null) {
    if (claims.containsKey('role')) {
      return claims['role'] as String?;
    }
  }

  return null;
}
