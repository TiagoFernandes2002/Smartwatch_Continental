import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_continental/pages/page_view.dart';

class LoginConfirm extends StatefulWidget {
  bool? isResponsive;
  double? size;
  Object? heroTag;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  LoginConfirm({
    Key? key,
    this.size,
    this.isResponsive = false,
    this.heroTag,
    required this.emailController,
    required this.passwordController,
  }) : super(key: key);

  @override
  State<LoginConfirm> createState() => _LoginConfirmState();
}

class _LoginConfirmState extends State<LoginConfirm> {
  bool _pressed = false;

  Future<void> _onPressed() async {
    String email = widget.emailController.text.trim();
    String password = widget.passwordController.text.trim();

    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      
      if (userCredential.user != null) {
        String token = await userCredential.user!.getIdToken();
        print('Login successful! Email: $email, Token: $token'); 
        PageViewWidget();
        // Log the successful login
        //SharedPreferences prefs = await SharedPreferences.getInstance();
        //await prefs.setInt('login_time', DateTime.now().millisecondsSinceEpoch);
      } else {
        print('Login failed! UserCredential.user is null'); // Log the failed login
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for this email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided for this user.';
      } else {
        errorMessage = e.message ?? 'An unknown error occurred.';
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage)));
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90,
      height: 40,
      child: FittedBox(
        child: FloatingActionButton.extended(
          heroTag: widget.heroTag,
          backgroundColor: _pressed ? Colors.orangeAccent : Colors.white60,
          onPressed: () {
            setState(() {
              _pressed = !_pressed;
            });
            _onPressed();
          },
          icon: const Icon(
            Icons.login,
            size: 24.0,
          ),
          label: const Text('Login'),
        ),
      ),
    );
  }
}
