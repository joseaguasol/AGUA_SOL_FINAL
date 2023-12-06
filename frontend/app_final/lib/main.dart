import 'package:flutter/material.dart';
import 'package:app_final/login.dart';
import 'package:app_final/components/cliente/productos.dart';
import 'package:app_final/components/cliente/bienvenido.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
    
      ),
      initialRoute: '/loginsol',
      routes: {
        '/loginsol':(context)=> const Login3(),
        '/bienvenido':(context)=> const Bienvenido(),
        '/productos':(context) => const Productos()
      },
      //home: const Login3(),
    );
  }
}
