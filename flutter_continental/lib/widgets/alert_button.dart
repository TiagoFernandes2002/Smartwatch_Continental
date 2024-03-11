import 'package:flutter/material.dart';
import 'package:flutter_continental/pages/Log_out.dart';

class AlertButton extends StatefulWidget {
  bool? isResponsive;
  double? size;

  AlertButton({Key? key, this.size, this.isResponsive = false})
      : super(key: key);

  @override
  State<AlertButton> createState() => _AlertButtonState();
}

class _AlertButtonState extends State<AlertButton> {
  bool _pressed = false;

  void _onPressed(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LogoutPage())
    );
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 85,
      height: 40,
      child: FittedBox(
        child: FloatingActionButton.extended(
          backgroundColor: _pressed
              ? Colors.orangeAccent
              : Colors.white60, 
          onPressed: () {
            setState(() {
              _pressed = !_pressed;
            });
            _onPressed();
          },
          icon: const Icon(
            Icons.warning_amber_rounded,
            size: 24.0,
          ),
          label: const Text('Log out'),
        ),
      ),
    );
  }
}
