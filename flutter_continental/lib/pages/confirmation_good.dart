import 'package:flutter/material.dart';

class ConfirmationGoodPage extends StatelessWidget {
  const ConfirmationGoodPage({super.key});

  //const ConfirmationGoodPage({super.key, Key? key});

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
                    Icons.home_rounded,
                    size: 40.0,
                    color: Colors.orangeAccent.shade400,
                  ),
                  Container(
                    width: 170,
                    height: 25,
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
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green),
                        ),
                        child: const Text('Home'),
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
    'Envio confirmado!',
    softWrap: true,
    style: TextStyle(fontSize: 15, color: Colors.white),
    textAlign: TextAlign.center,
  ),
);
