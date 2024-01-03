import 'package:app_final_desktop2/components/inicio.dart';
import 'package:app_final_desktop2/components/vista.dart';
import 'package:flutter/material.dart';
import 'package:app_final_desktop2/move/controls.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

import 'package:app_final_desktop2/components/inicio.dart';


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
      home: Inicio(),
      
    );
  }
}










/*
void main() {
  appWindow.size = const Size(1280, 720.8);
  runApp(const MyApp());
  appWindow.show();
  doWhenWindowReady(() {
    final win = appWindow;
    const initialSize = Size(1280, 720.8);
    win.minSize = initialSize;
    win.size = initialSize;
    win.alignment = Alignment.center;
    win.title = "Custom window with Flutter";
    win.show();
  });
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 232, 213, 205),
        body: Column(
          children: [
            WindowBorder(
              color: Colors.white,
              width: 2,
              child: WindowTitleBarBox(
                child: MoveWindow(
                  child:const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Barra de controles en la parte superior derecha

                       WindowButtons(),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  // Este es tu widget de navegación personalizado
                  Drawer(
                    backgroundColor: const Color.fromARGB(255, 1, 68, 122),
                    width: 200,
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView(
                            children: [
                              ListTile(
                                title: const Text(
                                  "Inicio",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          Inicio(), // Reemplaza 'OtraVista' con el nombre de tu vista
                                    ),
                                  );
                                },
                              ),
                              ListTile(
                                title:const Text(
                                  "Gestión",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onTap: () {},
                              ),
                              ListTile(
                                title: const Text(
                                  "Supervisión",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onTap: () {},
                              ),

                              // Agrega más elementos de navegación según sea necesario
                            ],
                          ),
                        ),
                        ListTile(
                          title: const Text(
                            "Salir",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onTap: () {},
                        )
                      ],
                    ),
                  ),
                  
                ],
              ),
            ),
          ],
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
*/