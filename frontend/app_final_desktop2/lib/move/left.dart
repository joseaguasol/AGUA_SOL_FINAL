import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

class LeftSide extends StatelessWidget {
  const LeftSide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Container(
        //color: Colors.grey, // Puedes cambiar el color según tus preferencias
        child: Column(
          children: [
            WindowTitleBarBox(child: MoveWindow()),
            Expanded(child: Container())
          ],
        ),
      ),
    );
  }
}
