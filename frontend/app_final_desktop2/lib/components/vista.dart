import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'package:cached_network_image/cached_network_image.dart';
// ... rest of the MyApp widget ...
import 'package:socket_io_client/socket_io_client.dart' as io;
//import 'package:slidable_button/slidable_button.dart';

class Armado extends StatefulWidget {
  const Armado({Key? key}) : super(key: key);

  @override
  State<Armado> createState() => _ArmadoState();
}

class _ArmadoState extends State<Armado> {
  late io.Socket socket;
  List<String> pedidos = [];
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    connectToServer();
  }

  void connectToServer() {
    print("dentro de connecttoServer");
    // Reemplaza la URL con la URL de tu servidor Socket.io
    socket = io.io('http://127.0.0.1:8004', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'reconnect':true,
      'reconnectionAttempts':5,
      'reconnectionDelay':1000,
    });

    socket.connect();
    socket.onConnect((_) {
      print('Conexión establecida');
    });

    socket.onDisconnect((_) {
      print('Conexión desconectada');
    });

    socket.on('nuevoPedido', (data) {
      print('Nuevo Pedido: $data');
      setState(() {
        pedidos.add(data.toString());
      });

      // Desplaza automáticamente hacia el último elemento
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });

    socket.onConnectError((error){
      print("error de conexion $error");
    });

    socket.onError((error){
      print("error de socket, $error");
    });
  }

  @override
  void dispose() {
    socket.disconnect();
    super.dispose();
  }
/*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pedidos en Tiempo Real"),
      ),
      body: ListView.builder(
        controller: _scrollController,
        reverse: true,
        itemCount: pedidos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Pedido: ${pedidos[index]}'),
          );
        },
      ),
    );
  }
}*/

  @override
  Widget build(BuildContext context) {
    final ancho = MediaQuery.of(context).size.width;
    final alto = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         
          // AQUI EL CODIGO PRINCIPAL
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      height: MediaQuery.of(context).size.height <= 1009
                          ? 743.0
                          : 980.0,
                      color: Colors.blue,
                      child: Column(
                        children: [
                          Container(
                              margin: const EdgeInsets.only(top: 20),
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(20)),
                              child: IconButton(
                                  onPressed: () {}, icon: Icon(Icons.menu))),
                          Container(
                              margin: const EdgeInsets.only(top: 20),
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(20)),
                              child: IconButton(
                                  onPressed: () {}, icon: Icon(Icons.menu))),
                        ],
                      )),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: Colors.grey,
                        child: Text("${ancho} , ${alto}"),
                      ),
                      Container(
                        height: 500,
                        //color: Colors.grey,
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return Container(
                                margin:
                                    const EdgeInsets.only(left: 20, top: 20),
                                padding: const EdgeInsets.all(20),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 500,
                                      width: 350,
                                      color: Colors.cyan,
                                      child: FlutterMap(
                                        options: MapOptions(
                                            initialZoom: 16.0,
                                            initialCenter: LatLng(
                                                -16.4055418, -71.5709782)),
                                        children: [
                                          TileLayer(
                                            urlTemplate:
                                                'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                            userAgentPackageName:
                                                'com.example.app',
                                            //maxZoom: 12,
                                            tileProvider: NetworkTileProvider(),
                                          ),
                                             PolylineLayer(
                                            polylines: [
                                              Polyline(
                                                points: [
                                                  LatLng(-16.4065685,-71.5701476),
                                                  LatLng(-16.4055481,-71.5682663),
                                                  LatLng(-16.4059701,-71.5651834),
                                                  LatLng(-16.4070517,-71.5686647),
                                                  LatLng(-16.405529,-71.5715656)
                                                ],
                                                color: Colors.blue,
                                                strokeWidth: 10
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 400,
                                      width: 300,
                                      color: Color.fromARGB(255, 158, 141, 176),
                                      child: Column(
                                        children: [
                                          Container(
                                            width: 100,
                                            height: 50,
                                            child: ElevatedButton(
                                                onPressed: () {},
                                                child: Text("Añadir")),
                                          ),
                                          const SizedBox(
                                            height: 50,
                                          ),
                                          Container(
                                            width: 100,
                                            height: 50,
                                            child: TextField(
                                              decoration: InputDecoration(
                                                  labelText: 'Pedido +'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Stack(
                                      children: [
                                        Container(
                                          height: 500,
                                          width: 350,
                                          // color: Colors.cyan,
                                          child: FlutterMap(
                                            options: MapOptions(
                                              initialZoom: 16.0,
                                                initialCenter: LatLng(
                                                    -16.4055418, -71.5709782)),
                                            children: [
                                              TileLayer(
                                                urlTemplate:
                                                    'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                                userAgentPackageName:
                                                    'com.example.app',
                                                tileProvider:
                                                    NetworkTileProvider(),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 60.0,
                                          right: 16.0,
                                          child: FloatingActionButton(
                                            onPressed: () {
                                              // Lógica para mover el mapa a la coordenada de inicio
                                            },
                                            tooltip:
                                                'Ir a la coordenada de inicio',
                                            child: Icon(Icons.my_location),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: 400,
                                      width: 350,
                                      color: Color.fromARGB(255, 180, 0, 212),
                                      child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 150,
                                              width: 120,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                            ),
                                            Expanded(
                                              child: Container(
                                                height: 150,
                                                color: Colors.grey,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      child:
                                                          Text("Nombres: Paul"),
                                                    ),
                                                    Container(
                                                      child: Text(
                                                          "Apellidos: Tekin"),
                                                    ),
                                                    Container(
                                                      child: Text(
                                                          "DNI: 051854185"),
                                                    ),
                                                    Container(
                                                      child: Text(
                                                          "Vehículo: TEKIN"),
                                                    ),
                                                    Container(
                                                      height: 50,
                                                      width: 50,
                                                      decoration: BoxDecoration(
                                                          color: Colors.yellow,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20)),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          ]),
                                    ),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                    //color: Colors.amber,
                                    borderRadius: BorderRadius.circular(20)),
                              );
                            }),
                      ),
                    ],
                  ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}