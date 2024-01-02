import 'package:app_final_desktop/components/empleado/armado.dart';
import 'package:app_final_desktop/components/empleado/login.dart';
import 'package:app_final_desktop/components/empleado/supervision.dart';
import 'package:flutter/material.dart';

import 'package:bitsdojo_window/bitsdojo_window.dart';


void main(){

  runApp(const MyApp());
}


class MyApp extends StatelessWidget{
  const MyApp({super.key});

  
  Widget build (BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      theme: ThemeData(
        useMaterial3: true,
        
      ),
      home: const Armado(),
    );
  }
}