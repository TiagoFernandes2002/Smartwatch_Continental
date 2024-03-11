import 'package:flutter/material.dart';
import 'package:flutter_continental/pages/Select_Line.dart';


class ListsButton extends StatefulWidget {
  bool? isResponsive;
  double? size;
  Object? heroTag;

  ListsButton({Key? key, this.size, this.isResponsive = false, this.heroTag})
      : super(key: key);


  @override
  State<ListsButton> createState() => _ListsButtonState();
}

class _ListsButtonState extends State<ListsButton> {
  bool _pressed = false;

  void _onPressed(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NumberSelectorPage())
    );
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 85,
      height: 33,
      child: FittedBox(
        child: FloatingActionButton.extended(
          heroTag: widget.heroTag,
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
            Icons.list,
            size: 24.0,
          ),
          label: const Text('Linhas'),
        ),
      ),
    );
  }
}
