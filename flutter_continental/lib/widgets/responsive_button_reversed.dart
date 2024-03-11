import 'package:flutter/material.dart';

class ResponsiveButtonReversed extends StatelessWidget {
  bool? isResponsive;
  double? width;
  double? height; 
  ResponsiveButtonReversed({Key? key, this.width, this.height, this.isResponsive=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white54,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/arrow_reversed.png",)
        ]
      )
    );
  }
}