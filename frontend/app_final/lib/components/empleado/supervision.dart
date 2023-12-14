//import 'package:app_final/components/empleado/supervision.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class Supervision extends StatefulWidget {
  const Supervision({Key? key}) : super(key: key);

  @override
  State<Supervision> createState() => _SupervisionState();
}

class _SupervisionState extends State<Supervision> {
  List<Widget> widgetList = [];
  List<Widget> secondColumnWidgets = [];
  
    List<dynamic>respuesta =[];
     String apiPedidos =  'http://10.0.2.2:8004/api/pedido';
  Future<dynamic>getPedidos() async{
    var res = await http.get(Uri.parse(apiPedidos),
    headers:{"Content-Type":"application/json"});
    if (res.statusCode == 200){
      var data = json.decode(res.body);
      setState(() {
        respuesta=data;
      });
    }


   
  }

  void crearWidget() {
  //List <String> datos = [];
  List <dynamic> acceptedData = [];
  setState(() {
    widgetList.add(
      DragTarget<String>(
        builder: (BuildContext context, List<dynamic> accepted, List<dynamic> rejectedData) {
          return Container(
            height: 150,
            width: 150,
            color: Colors.amber,
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    Text(
                      'Ruta se añadio el pedido:${acceptedData}',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        onWillAccept: (data) {
          // Lógica cuando se acerca al DragTarget
          return true; // Puedes personalizar la lógica según tus necesidades
        },
        onAccept: (data) {
          // Lógica cuando el Draggable se suelta en el DragTarget
          setState(() {
            acceptedData.add(data);
          });
          print('Widget aceptado. Datos: $data');
        },
      ),
    );
    print('Widget creado. Total de widgets en la lista: ${widgetList.length}');
  });
}


  @override
  void initState(){
    super.initState();
    getPedidos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.center,
          child: Text('Supervisión', style: TextStyle(fontFamily: 'Pacifico')),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [],
        ),
       )
      ),
    );
  }
}