import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Presenta extends StatefulWidget {
  const Presenta({super.key});

  @override
  State<Presenta> createState() => _PresentaState();
}

class _PresentaState extends State<Presenta> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            //color: Colors.grey,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey
                            ),
                          ),
                          Container(
                            height: 100,
                            width: 100,
                            child: Lottie.asset('lib/imagenes/redondito.json'),
                          )
                        ],
                      ),
                    ]))));
  }
}
