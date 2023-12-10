import 'package:app_final/components/cliente/promocion.dart';
import 'package:app_final/components/empleado/home.dart';
import 'package:flutter/material.dart';
import 'package:app_final/login.dart';
import 'package:app_final/components/cliente/productos.dart';
import 'package:app_final/components/cliente/bienvenido.dart';
import 'package:geolocator/geolocator.dart';
import 'package:app_final/provider/usuario_provider.dart';
import 'package:provider/provider.dart';


void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  //await Geolocator.requestPermission();
  runApp(
    ChangeNotifierProvider(
      create: (context) => UsuarioProvider(),
      child: const MyApp(),
    )
    
    );
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
        '/promociones':(context) => Promocion(),
        '/empleado_ruta':(context) => ArmadoRuta(),
        '/loginsol':(context)=> const Login3(),
        '/bienvenido':(context)=> const Bienvenido(),
        '/productos':(context) => const Productos()
      },
      //home: const Login3(),
    );
  }
}
