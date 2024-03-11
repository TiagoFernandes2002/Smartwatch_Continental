import 'package:flutter/material.dart';
import 'package:flutter_continental/widgets/auth_service.dart';

class LogoutPage extends StatelessWidget {
  const LogoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Center(
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.orangeAccent.shade400),
          ),
          onPressed: () => AuthService.logOut(context),
          child: const Text(
            'Sair',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }
}
