import 'package:app_final/components/empleado/supervision.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class ArmadoRuta extends StatefulWidget {
  const ArmadoRuta({Key? key}) : super(key: key);

  @override
  State<ArmadoRuta> createState() => _ArmadoRutaState();
}

class _ArmadoRutaState extends State<ArmadoRuta> {
  //String dropdownValue = list.first;
  int detallepedido = 0;
  List<Widget> widgetList = [];




// Coordenadas de los puntos de inicio y destino
  final List<LatLng> routeCoordinates = [
    LatLng(-16.3988900, -71.5350000), // Punto de inicio
    LatLng(-16.4152, -71.5375), // Punto de destino
  ];

  List<dynamic>respuesta =[];

  String apiPedidos =  'http://10.0.2.2:8004/api/pedido';
  
  void navigateToSupervision(){
  Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Supervision(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOutQuart;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 800),
    ),
  );
  }

  Future<dynamic>getPedidos() async{
    var res = await http.get(Uri.parse(apiPedidos),
    headers:{"Content-Type":"application/json"});
    if (res.statusCode == 200){
      var data = json.decode(res.body);
      respuesta = data;
    }


    print( json.decode(res.body));
    respuesta = json.decode(res.body);
    detallepedido = respuesta[0]['conductor_id'];
    print("----DETALLE");
    print(detallepedido);
    print("LENG-------------${respuesta.length}");
  }

  @override
  void initState(){
    super.initState();
    getPedidos();
  }

void crearWidget() {
  //List <String> datos = [];
  List <dynamic> acceptedData = [];
  setState(() {
    widgetList.add(
      DragTarget<String>(
        builder: (BuildContext context, List<dynamic> accepted, List<dynamic> rejectedData) {
          return Container(
            margin: EdgeInsets.all(4),
            padding:EdgeInsets.all(3),
            height: 100,
            width: 200,
            //color: Colors.purple,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color:Colors.cyan,width: 3)
            ),
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    Text("RUTA"),
                    Text('${acceptedData.join(" : ")}\n',
                      style: TextStyle(color: Colors.cyan, fontSize: 20),
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.center,
          child: Text('Armado de Rutas',style: TextStyle(fontFamily:'Pacifico'),)),
        //backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            children: [
              Align(
              alignment: Alignment.center,
              child: Text('Mapa de Pedidos',style: TextStyle(fontFamily:'Pacifico',fontSize: 20),)),
              //SizedBox(height: 16), // Espacio entre el final de la lista y el mapa
              Container(
                padding: EdgeInsets.all(10), // Espacio horizontal entre el mapa y los bordes
                width: double.infinity,
                height: 400,
                decoration: BoxDecoration(
                  color: Colors.cyan,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: FlutterMap(
                  options: MapOptions(
                    initialCenter: LatLng(-16.3988900, -71.5350000),
                    initialZoom: 15.2,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.app',
                    ),
                    RichAttributionWidget(
                      attributions: [
                        TextSourceAttribution(
                          'OpenStreetMap contributors',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              
              // TITULOS
              Row(
                children: [
                  Column(
                    children: [
                      Text("Rutas",style:TextStyle(fontFamily: 'Pacifico'),),
                      Row(
                        children:
                        [
                        ElevatedButton(onPressed:(){setState(() {
                          crearWidget();
                        });}, child: Text("Crear",style: TextStyle(color:Colors.white),),
                          style:ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.purpleAccent),
                          
                        ),),
                        const SizedBox(width: 20,),
                        ElevatedButton(onPressed:(){setState(() {
                          if(widgetList.isNotEmpty){widgetList.removeLast();}
                        });}, child: Text("Destruir"),
                          style:ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.amberAccent),
                          
                        ),)
                       ],
                      ),                      
                    ]
                  ),

                  const SizedBox(width: 120,),
                  Column(
                    children: [
                      Text("Pedidos",style:TextStyle(fontFamily: 'Pacifico'),),
                      
                      ],
                  ),
                ],
              ),
              const SizedBox(height: 20,),

              // CONTENIDO
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [


                      // Primera Columna
                      SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children:[
                            // ESTE CONTAINER ES EL ANCHO PREDERTERMINADO
                            Container(
                              height: 10,
                              width: 200,
                              color: Colors.white,
                            ),
                            ...widgetList,

                          ]
                         
                        ),
                      ),

                      // Segunda Columna
                      const SizedBox(width: 20,),
               
                      SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      
                        child: Column(
                          children: respuesta.map((e) =>
                      
                            LongPressDraggable<String>(
                              data: "${e['id']},${e['monto_total']}", // Datos que se enviarán cuando se inicie el arrastre
         
                              feedback: Container(
                                width: 150,
                                height: 150,
                                padding: EdgeInsets.all(10),
                                color: const Color.fromARGB(255, 251, 152, 152),
                                child: Column(
                                  children: [
                                    Text("Pedido N°: ${e['id']}",maxLines:1 , style: TextStyle(fontSize: 15, color: Colors.white)),
                                    Text("${e['monto_total']}",maxLines: 1,style: TextStyle(fontSize: 15, color: Colors.white)),
                                    Text("${e['fecha']}",maxLines: 1,style: TextStyle(fontSize: 15, color: Colors.white)),
                                    Text("${e['direccion']}",maxLines: 1,style: TextStyle(fontSize: 15, color: Colors.white)),
                                    
                                  ],
                                  
                                ),
                              ),
                              
                              child: Container(
                              width: 200,
                             margin: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                border:Border.all(color: Colors.blue,width: 2),
                                borderRadius: BorderRadius.circular(20)
                                
                              ),
                                //color: const Color.fromARGB(255, 64, 232, 251),
                                child: Column(
                                  children: [
                                    Text("Pedido N°: ${e['id']}", style: TextStyle(fontSize: 18,color:Colors.blue)),
                                    Text("${e['monto_total']}"),
                                    Text("${e['fecha']}"),
                                    Text("${e['direccion']}"),
                                    
                                    //Container(height: 10, color: Colors.white)
                                  ],
                                ),
                              ),
                            ),
                          ).toList(),
                          
                        ),
                      ),

                    ],
                  ),
                ),
              ),
              SizedBox(height: 60,),
              ElevatedButton(onPressed:(){
                navigateToSupervision();
              }, 
              child: Text("Confirmar",style: TextStyle(fontSize:19,color:Colors.white),),
              style:ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
                fixedSize: MaterialStateProperty.all(Size(350,55)),
               ),
              ),
              SizedBox(height: 60,),
            ],
          ),
        ),
      ),
    );
  }
}