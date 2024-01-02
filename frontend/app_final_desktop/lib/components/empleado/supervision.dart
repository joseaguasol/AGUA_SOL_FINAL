

import 'package:flutter/material.dart';

class Supervision extends StatefulWidget {
  const Supervision({Key? key}) : super(key: key);

  @override
  State<Supervision> createState() => _SupervisionState();
}

class _SupervisionState extends State<Supervision> {

  @override
  Widget build (BuildContext context){
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              Container(
                color: Colors.amber,
                
                child:Column(
                  children: [
                    Icon(Icons.abc),
                  ],
                )                
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      width: 500,
                      color:Colors.blue,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: 20,
                        itemBuilder:(context, index) {
                        return Text("lista");
                        },
                      ),
                    )
                  ]
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}