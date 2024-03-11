import 'package:flutter/material.dart';
import 'package:flutter_continental/widgets/app_large_text.dart';
import 'package:flutter_continental/widgets/app_text.dart';
import 'package:flutter_continental/widgets/lists_button.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../widgets/alert_button.dart';

class WelcomePage extends StatefulWidget {
  final String role;

  const WelcomePage({Key? key, required this.role}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEEE, d MMMM y').format(now);

    User? user = FirebaseAuth.instance.currentUser;

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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DigitalClock(
                        hourMinuteDigitTextStyle: const TextStyle(
                          fontSize: 35,
                          color: Colors.white,
                        ),
                        showSecondsDigit: false,
                        colon: const Text(
                          ':',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      AppText(
                          text: formattedDate, size: 7, color: Colors.white),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Container(
                    width: 200,
                    height: 30,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/continental.png'),
                        fit: BoxFit.scaleDown,
                        alignment: Alignment(0, 0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AlertButton(),
                      const SizedBox(width: 2),
                      if (widget.role == "funcionario") ListsButton(heroTag: 'button1'),
                    ],
                  ),
                  const SizedBox(height: 5),
                  AppLargeText(text: 'Bem-Vindo', size: 17),
                  AppText(
                    text: '${user!.displayName}',
                    size: 12,
                    color: Colors.orangeAccent.shade400,
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
