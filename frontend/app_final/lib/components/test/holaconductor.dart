import 'dart:ffi';
import 'package:app_final/components/test/camara.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'dart:convert';
//import 'package:lottie/lottie.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

class Ruta {
  final Int rutaID;
  const Ruta({
    Key? key,
    required this.rutaID,
  });
}

class Pedido {
  final int id;
  final double montoTotal;
  final String tipo;
  final String fecha;
  String estado;

  ///REVISAR EN QUÈ FORMATO SE RECIVE LA FECHA
  final String nombre;
  final String apellidos;
  final String telefono;
  final String ubicacion;
  final String direccion;

  Pedido({
    Key? key,
    required this.id,
    required this.montoTotal,
    required this.tipo,
    required this.fecha,
    required this.nombre,
    required this.apellidos,
    required this.telefono,
    required this.ubicacion,
    required this.direccion,
    this.estado = 'en proceso',
  });
}

class DetallePedido {
  final int pedidoID;
  final int productoID;
  final String productoNombre;
  final int cantidadProd;
  final int? promocionID;

  const DetallePedido({
    Key? key,
    required this.pedidoID,
    required this.productoID,
    required this.productoNombre,
    required this.cantidadProd,
    required this.promocionID,
  });
}

class HolaConductor extends StatefulWidget {
  final Pedido pedidoActual;
  HolaConductor({
    Key? key,
    required this.pedidoActual,
  }) : super(key: key);

  @override
  State<HolaConductor> createState() => _HolaConductorState();
}

class _HolaConductorState extends State<HolaConductor> {
  late io.Socket socket;
  String apiPedidos = 'http://10.0.2.2:8004/api/pedidoConductor/';
  String apiRutas = 'http://10.0.2.2:8004/api/promocion';
  String apiDetallePedido = 'http://10.0.2.2:8004/api/detallepedido/';
  List<Pedido> listPedidosbyRuta = [];
  List<DetallePedido> listDetallePedido = [];
  String productosYCantidades = "";
  int pedidoActual = 1;
  int numerodePedidosExpress = 0;

  Future<dynamic> getDetalleXUnPedido(pedidoID) async {
    var res = await http.get(
      Uri.parse(apiDetallePedido + pedidoID.toString()),
      headers: {"Content-type": "application/json"},
    );
    try {
      if (res.statusCode == 200) {
        var data = json.decode(res.body);
        List<DetallePedido> listTemporal = data.map<DetallePedido>((mapa) {
          return DetallePedido(
            pedidoID: mapa['pedido_id'],
            productoID: mapa['producto_id'],
            productoNombre: mapa['nombre'],
            cantidadProd: mapa['cantidad'],
            promocionID: mapa['promocion_id'],
          );
        }).toList();

        setState(() {
          listDetallePedido = listTemporal;
        });
      }
    } catch (e) {
      print('Error en la solicitud: $e');
      throw Exception('Error en la solicitud: $e');
    }
  }

  /*Future<dynamic> actualizarPedidoBackend(pedidoID, nuevoEstado, foto) async {
    await http.put(Uri.parse(apiPedidos + pedidoID.toString()),
    headers:  {"Content-type": "application/json"},
    body: jsonEncode({
          "cliente_id": clienteId,
          "producto_id": productoId,
          "cantidad": cantidad,
          "promocion_id": promoID
          })
    );
  }*/

  void actualizarPedidoFrontend() {
    if (widget.pedidoActual.estado == 'entregado') {
      for (var i = 0; i < listPedidosbyRuta.length; i++) {
        if (listPedidosbyRuta[i].estado == 'en proceso') {
          setState(() {
            pedidoActual = listPedidosbyRuta[i].id;
          });
        }
      }
    }
  }

  //DE ESTA FUNCION ESCUCHARE LOS PEDIDOS QUE ME MANDA EL EMPLEADO
  //es decir aqui se actualiza listPedidosbyRuta
  void connectToServer() {
    print("Dentro de connectToServer");
    // Reemplaza la URL con la URL de tu servidor Socket.io
    socket = io.io('http://10.0.2.2:8004', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'reconnect': true,
      'reconnectionAttempts': 5,
      'reconnectionDelay': 1000,
    });
    socket.connect();
    socket.onConnect((_) {
      print('Conexión establecida: CONDUCTOR');
      // Inicia la transmisión de ubicación cuando se conecta
      //iniciarTransmisionUbicacion();
    });
    socket.onDisconnect((_) {
      print('Conexión desconectada: CONDUCTOR');
    });
    socket.onConnectError((error) {
      print("Error de conexión $error");
    });
    socket.onError((error) {
      print("Error de socket, $error");
    });

    ///getpedidos
    ///
  }

  void calcularCantidadPedidosNormales() async {
    for (var i = 0; i < listPedidosbyRuta.length; i++) {
      if (listPedidosbyRuta[i].tipo == 'express') {
        setState(() {
          numerodePedidosExpress + 1;
        });
      }
    }
  }

  void obtenerProductosparaVistadelConductor() async {
    for (var i = 0; i < listDetallePedido.length; i++) {
      var salto = '';
      if (i == 0) {
        salto = '';
      } else {
        salto = ' \n';
      }
      setState(() {
        productosYCantidades =
            "$productosYCantidades $salto ${listDetallePedido[i].productoNombre} x ${listDetallePedido[i].cantidadProd.toString()} uds.";
      });
    }
  }

  //DE ESTA ACTUALIZO el PEDIDO ACTUAL CON EL QUE ESTOY TRABAJANDO
  //es decir si cambio el estado de el pedido anterior a "truncado" o "entregado"
  //puedo pasar al siguiente actualizando pedidoActual

  @override
  void initState() {
    super.initState();
    connectToServer();
    getDetalleXUnPedido(pedidoActual);
  }

  @override
  Widget build(BuildContext context) {
    //se calcula el numero total de pedidos de la lista lisPedidosbyRuta
    int numeroTotalPedidos = listPedidosbyRuta.length;
    double anchoPantalla = MediaQuery.of(context).size.width;
    //double altoPantalla = MediaQuery.of(context).size.height;

    obtenerProductosparaVistadelConductor();

    //final TabController _tabController = TabController(length: 2, vsync: this);
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  //mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      // color: Colors.grey,
                      margin:
                          const EdgeInsets.only(left: 20, top: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            //margin: const EdgeInsets.only(left: ),
                            child: IconButton(
                                onPressed: () {
                                  _scaffoldKey.currentState?.openDrawer();
                                },
                                icon: Icon(
                                  Icons.menu,
                                  size: 30,
                                )),
                          ),
                          Container(
                            height: 60,
                            width: 60,
                            child: ClipRRect(
                              child: Image.asset('lib/imagenes/repartidor.jpg'),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    //este container tiene los pedidos programas y express
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      height: 75,
                      // color: Colors.grey,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 100,
                            width: 210,
                            //color: Colors.green,
                            child: Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 0),
                                  decoration: BoxDecoration(
                                      // color:Colors.pink,
                                      border: Border.all(
                                          width: 3,
                                          color:
                                              Color.fromARGB(255, 1, 116, 89))),
                                  child: Text(
                                    " ${numeroTotalPedidos - numerodePedidosExpress} ",
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 0, 53, 95),
                                        fontSize: 20),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  //color:Colors.blue,
                                  child: Text(
                                    "Pedidos \nProgramados",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 20),
                            // width: 100,
                            //height: 80,
                            //color: Colors.cyan,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Badge(
                                  largeSize: 25,
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        //color:Colors.black,
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'lib/imagenes/express.png'))),
                                  ),
                                  label: Text(" ${numerodePedidosExpress} ",
                                      style: TextStyle(fontSize: 20)),
                                ),
                                Text("Express", style: TextStyle(fontSize: 15))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),

                    //ESTE CONTEINER TIENE LA INFO DEL PEDIDO
                    Container(
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 10),
                      //color: Colors.amber,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          //,
                          children: [
                            Text(
                              "Pedido $pedidoActual/$numeroTotalPedidos ",
                              style: const TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w500),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  "Productos:",
                                  style: TextStyle(fontSize: 14),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      productosYCantidades,
                                      style: const TextStyle(fontSize: 14),
                                    )
                                  ],
                                )
                              ],
                            ),
                            Text(
                              "Cliente: ..... de la API",
                              style: TextStyle(fontSize: 14),
                            ),
                            Text(
                              "Monto: ..... de la API",
                              style: TextStyle(fontSize: 14),
                            )
                          ]),
                    ),
                    SizedBox(height: 10),

                    Container(
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      color: Colors.green,
                      height: 200,
                      width: 500,
                      child: Text("Aqui se corre el mapa"),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    Container(
                        margin: const EdgeInsets.only(left: 20),
                        child: const Text(
                          "Tipo de pago",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500),
                        )),

                    const SizedBox(
                      height: 10,
                    ),

                    Container(
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 160,
                            height: 40,
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Camara(
                                              pedido: listPedidosbyRuta[
                                                  pedidoActual],
                                              listaPedidosbyRuta:
                                                  listPedidosbyRuta,
                                              problemasOpago: 'pago',
                                            )),
                                  );
                                },
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Color.fromARGB(255, 2, 86, 155))),
                                child: const Row(
                                  children: [
                                    Icon(
                                      Icons
                                          .camera_alt, // Reemplaza con el icono que desees
                                      size: 24,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      "Yape/Pin",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white),
                                    )
                                  ],
                                )),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Container(
                            width: 160,
                            height: 40,
                            child: ElevatedButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text(
                                        'TERMINE MI PEDIDO',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 4, 80, 143)),
                                      ),
                                      content: const Text(
                                        '¿Entregaste el pedido?',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pop(); // Cierra el AlertDialog
                                          },
                                          child: const Text(
                                            '¡SI!',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                color: Color.fromARGB(
                                                    255, 13, 58, 94)),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pop(); // Cierra el AlertDialog
                                          },
                                          child: const Text(
                                            'Cancelar',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                color: Color.fromARGB(
                                                    255, 13, 58, 94)),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    const Color.fromARGB(255, 2, 86, 155)),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons
                                        .money, // Reemplaza con el icono que desees
                                    size: 24,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                      width:
                                          8), // Ajusta el espacio entre el icono y el texto según tus preferencias
                                  Text(
                                    "Efectivo",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    Container(
                        margin: const EdgeInsets.only(left: 20),
                        child: const Text(
                          "¿Problemas al entregar el pedido?",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500),
                        )),

                    const SizedBox(
                      height: 15,
                    ),

                    Container(
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      width: anchoPantalla,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Camara(
                                      pedido: listPedidosbyRuta[pedidoActual],
                                      listaPedidosbyRuta: listPedidosbyRuta,
                                      problemasOpago: 'problemas',
                                    )),
                          );
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.grey)),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons
                                  .camera_alt, // Reemplaza con el icono que desees
                              size: 24,
                              color: Colors.white,
                            ),
                            SizedBox(
                                width:
                                    8), // Ajusta el espacio entre el icono y el texto según tus preferencias
                            Text(
                              "Reportar",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]))),
    );
  }
}
