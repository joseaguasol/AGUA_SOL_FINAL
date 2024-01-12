import 'package:app_final_desktop/components/empleado/login.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_map/flutter_map.dart' as map;

class Pedido {
  final int id;
  final int cliente_id;
  final int? cliente_nr_id;
  final int monto_total;
  final String fecha;
  final String tipo;
  String estado;

  bool seleccionado; // Nuevo campo para rastrear la selección

  Pedido(
      {required this.id,
      required this.cliente_id,
      required this.cliente_nr_id,
      required this.monto_total,
      required this.fecha,
      required this.tipo,
      required this.estado,
      this.seleccionado = false});
}

// PREGUNTAR SI DEBO MODIFICAR EL MODEL CONDUCTOR AÑADIENDO UN ATRIBUTO
// ESTADO  O EN EL LOGIN PARA VER SI SE CONECTO EN TIEMPO REAL
class Conductor {
  final int id;
  final String nombres;
  final String apellidos;
  final String licencia;
  final String dni;
  final String fecha_nacimiento;

  bool seleccionado; // Nuevo campo para rastrear la selección

  Conductor(
      {required this.id,
      required this.nombres,
      required this.apellidos,
      required this.licencia,
      required this.dni,
      required this.fecha_nacimiento,
      this.seleccionado = false});
}

class Armado extends StatefulWidget {
  const Armado({super.key});

  @override
  State<Armado> createState() => _ArmadoState();
}

class _ArmadoState extends State<Armado> {
  LatLng currentLcocation = LatLng(0, 0);
  late ScrollController _scrollController; // = ScrollController();
  ScrollController _scrollControllerAgendados = ScrollController();
  ScrollController _scrollControllerExpress = ScrollController();
  ScrollController _scrollControllerSelection = ScrollController();
  late io.Socket socket;
  List<Pedido> hoypedidos = [];
  List<Pedido> hoyexpress = [];
  List<Pedido> agendados = [];
  List<Pedido> obtenerPedidoSeleccionado = [];

  List<Conductor> obtenerConductor = [];
  List<Conductor> conductores = [];

  DateTime now = DateTime.now();

  final List<LatLng> routePoints = [
    LatLng(-16.4055657, -71.5719081),
    LatLng(-16.4050152, -71.5705073),
    LatLng(-16.4022842, -71.5651442),
    LatLng(-16.4086712, -71.5579809),
  ];

  var direccion = '';
  String apiPedidos = 'http://127.0.0.1:8004/api/pedido';
  String apiConductores = 'http://127.0.0.1:8004/api/user_conductor';
  final TextEditingController _searchController = TextEditingController();
  //final TextEditingController _distrito = TextEditingController();
  //final TextEditingController _ubicacion = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    connectToServer();
    getPedidos();
    getConductores();
  }

  void actualizarObtenidos() {
    setState(() {
      obtenerPedidoSeleccionado = [...hoypedidos, ...hoyexpress, ...agendados]
          .where((element) => element.seleccionado)
          .toList();
    });
  }

  // GET CONDUCTORES
  Future<dynamic> getConductores() async {
    print(">>>>> CONDUCTORES");
    var res = await http.get(Uri.parse(apiConductores),
        headers: {"Content-type": "application/json"});
    try {
      if (res.statusCode == 200) {
        var data = json.decode(res.body);
        List<Conductor> tempConductor = data.map<Conductor>((mapa) {
          return Conductor(
              id: mapa['id'],
              nombres: mapa['nombres'],
              apellidos: mapa['apellidos'],
              licencia: mapa['licencia'],
              dni: mapa['dni'],
              fecha_nacimiento: mapa['fecha_nacimiento']);
        }).toList();

        setState(() {
          conductores = tempConductor;
        });
      }
    } catch (e) {
      print('Error en la solicitud: $e');
      throw Exception('Error en la solicitud: $e');
    }
  }

  // GET PEDIDOS
  Future<dynamic> getPedidos() async {
    print("<<<<<<<<<Getpedidos");
    var res = await http.get(Uri.parse(apiPedidos),
        headers: {"Content-type": "application/json"});
    //timeout: Duration(seconds: 10);
    try {
      if (res.statusCode == 200) {
        var data = json.decode(res.body);

        List<Pedido> pedidos = data.map<Pedido>((mapa) {
          return Pedido(
            id: mapa['id'],
            cliente_id: mapa['cliente_id'],
            cliente_nr_id: mapa['cliente_nr_id'],
            monto_total: mapa['monto_total'],
            fecha: mapa['fecha'],
            tipo: mapa['tipo'],
            estado: mapa['estado'],
            seleccionado: false, // Puedes establecerlo en true si es necesario
          );
        }).toList();

        setState(() {
          // SI LOS PEDIDOS CON FECHA DE AYER,
          agendados = pedidos;

          print("--------AGENDADOS-----");
          print("agendados");
        });
      }
    } catch (e) {
      print('Error en la solicitud: $e');
      throw Exception('Error en la solicitud: $e');
    }
  }
  /**/

  void connectToServer() {
    print("-----CONEXIÓN------");

    socket = io.io('http://127.0.0.1:8004', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
      'reconnect': true,
      'reconnectionAttempts': 5,
      'reconnectionDelay': 1000,
    });

    socket.connect();

    socket.onConnect((_) {
      print('Conexión establecida: EMPLEADO');
    });

    socket.onDisconnect((_) {
      print('Conexión desconectada: EMPLEADO');
    });

    // CREATE PEDIDO
    socket.on('nuevoPedido', (data) {
      print('Nuevo Pedido: $data');
      setState(() {
        DateTime fechaparseada = DateTime.parse(data['fecha'].toString());

        // SI EL PEDIDO TIENE FECHA DE HOY Y ES NORMAL
        if (data['tipo'].toString() == 'normal' &&
            fechaparseada.year == now.year &&
            fechaparseada.month == now.month &&
            fechaparseada.day == now.day) {
          Pedido nuevoHoy = Pedido(
              id: data['id'],
              cliente_id: data['cliente_id'],
              cliente_nr_id: data['cliente_nr_id'],
              monto_total: data['monto_total'],
              fecha: data['fecha'],
              tipo: data['tipo'],
              estado: data['estado']);
          // añadimos el objeto
          hoypedidos.add(nuevoHoy);
        }
        // SI EL PEDIDO TIENE FECHA DE HOY Y ES EXPRESS
        if (data['tipo'].toString() == 'express' &&
            fechaparseada.year == now.year &&
            fechaparseada.month == now.month &&
            fechaparseada.day == now.day) {
          Pedido nuevoExpress = Pedido(
              id: data['id'],
              cliente_id: data['cliente_id'],
              cliente_nr_id: data['cliente_nr_id'],
              monto_total: data['monto_total'],
              fecha: data['fecha'],
              tipo: data['tipo'],
              estado: data['estado']);
          //añadimos el objeto
          hoyexpress.add(nuevoExpress);
        }
      });

      // Desplaza automáticamente hacia el último elemento
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 800),
        curve: Curves.easeInOutQuart,
      );

      _scrollControllerExpress.animateTo(
        _scrollControllerExpress.position.maxScrollExtent,
        duration: Duration(milliseconds: 800),
        curve: Curves.easeInOutQuart,
      );
    });

    socket.onConnectError((error) {
      print("error de conexion $error");
    });

    socket.onError((error) {
      print("error de socket, $error");
    });

    socket.on('testy', (data) {
      print("CARRRR");
    });

    socket.on('enviandoCoordenadas', (data) {
      print("Conductor transmite:");
      print(data);
      setState(() {
        currentLcocation = LatLng(data['x'], data['y']);
      });
    });
  }

  @override
  void dispose() {
    socket.disconnect();
    socket.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 191, 195, 199),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 20, left: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    Login(),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              const begin = Offset(1.0, 0.0);
                              const end = Offset.zero;
                              const curve = Curves.easeInOut;
                              var tween = Tween(begin: begin, end: end)
                                  .chain(CurveTween(curve: curve));
                              var offsetAnimation = animation.drive(tween);
                              return SlideTransition(
                                  position: offsetAnimation, child: child);
                            },
                          ),
                        );
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromARGB(255, 33, 76, 110))),
                      child: Text("<< Sistema de Pedido",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),

                  // TITULOS
                  Container(
                    //color: Colors.grey,
                    margin: const EdgeInsets.only(top: 20, left: 20),
                    child: Row(
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Sistema de Ruteo",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Pedidos",
                              style: TextStyle(fontSize: 20),
                            )
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 50),
                          height: 80,
                          width: 80,
                          child: Lottie.asset('lib/imagenes/hangloose.json'),
                        ),
                      ],
                    ),
                  ),

                  // PEDIDOS
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // AGENDADOS
                      Container(
                        //color: Colors.amber,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.amber),
                        margin: const EdgeInsets.only(left: 20),
                        padding: const EdgeInsets.all(15),
                        width: 500,
                        height: 300,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          //crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Agendados",
                              style: TextStyle(fontSize: 20),
                            ),
                            TextField(
                              controller: _searchController,
                              onChanged: (value) {
                                setState(
                                    () {}); // Actualiza el estado al cambiar el texto
                              },
                              decoration: InputDecoration(
                                labelText: 'Buscar',
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.search),
                                  onPressed: () {
                                    // Puedes realizar acciones de búsqueda aquí si es necesario
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                reverse: true,
                                scrollDirection: Axis.vertical,
                                //controller: _scrollControllerAgendados,
                                itemCount: agendados.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white),
                                    child: ListTile(
                                      trailing: Checkbox(
                                        value: agendados[index].seleccionado,
                                        onChanged: (value) {
                                          setState(() {
                                            agendados[index].seleccionado =
                                                value ?? false;
                                            obtenerPedidoSeleccionado =
                                                agendados
                                                    .where((element) =>
                                                        element.seleccionado)
                                                    .toList();
                                            if (value == true) {
                                              agendados[index].estado =
                                                  "en proceso";
                                              // AQUI DEBO TAMBIEN HACER "update pedido set estado = en proceso"
                                              // esto con la finalidad de que se maneje el estado en la database
                                              actualizarObtenidos();
                                            } else {
                                              agendados[index].estado =
                                                  'pendiente';
                                              // AQUI DEBO TAMBIEN HACER "update pedido set estado = pendiente"
                                              // esto con la finalidad de que se maneje el estado en la database
                                              actualizarObtenidos();
                                            }
                                          });
                                        },
                                      ),
                                      title: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              'Pedido ID: ${agendados[index].id}'),
                                          Text(
                                              'Cliente ID: ${agendados[index].cliente_id}'),
                                          Text(
                                              'Monto Total: ${agendados[index].monto_total}'),
                                          Text(
                                            'Estado: ${agendados[index].estado}',
                                            style: TextStyle(
                                                color: agendados[index]
                                                            .estado ==
                                                        'pendiente'
                                                    ? Colors.red
                                                    : agendados[index].estado ==
                                                            'en proceso'
                                                        ? Colors.blue
                                                        : agendados[index]
                                                                    .estado ==
                                                                'entregado'
                                                            ? Colors.green
                                                            : Colors.black),
                                          ),
                                          Text(
                                              'Fecha: ${agendados[index].fecha}'),
                                        ],
                                      ),
                                      /*trailing: Row(*/
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      // HOY
                      Container(
                        //color: Colors.amber,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color.fromARGB(255, 209, 94, 132)),
                        margin: const EdgeInsets.only(left: 20),
                        padding: const EdgeInsets.all(15),
                        width: 350,
                        height: 300,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          //crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Hoy",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            TextField(
                              controller: _searchController,
                              onChanged: (value) {
                                setState(
                                    () {}); // Actualiza el estado al cambiar el texto
                              },
                              decoration: InputDecoration(
                                labelStyle:
                                    const TextStyle(color: Colors.white),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors
                                          .grey), // Cambia el color del cursor cuando el TextField no está enfocado
                                ),
                                labelText: 'Buscar cliente',
                                suffixIcon: IconButton(
                                  icon: const Icon(
                                    Icons.search,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    // Puedes realizar acciones de búsqueda aquí si es necesario
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                reverse: true,
                                controller: _scrollController,
                                itemCount: hoypedidos.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: ListTile(
                                      trailing: Checkbox(
                                        value: hoypedidos[index].seleccionado,
                                        onChanged: (value) {
                                          setState(() {
                                            hoypedidos[index].seleccionado =
                                                value ?? false;
                                            obtenerPedidoSeleccionado =
                                                hoypedidos
                                                    .where((element) =>
                                                        element.seleccionado)
                                                    .toList();
                                            if (value == true) {
                                              hoypedidos[index].estado =
                                                  "en proceso";
                                              // AQUI DEBO TAMBIEN HACER "update pedido set estado = en proceso"
                                              // esto con la finalidad de que se maneje el estado en la database
                                              actualizarObtenidos();
                                            } else {
                                              hoypedidos[index].estado =
                                                  'pendiente';
                                              // AQUI DEBO TAMBIEN HACER "update pedido set estado = pendiente"
                                              // esto con la finalidad de que se maneje el estado en la database
                                              actualizarObtenidos();
                                            }
                                          });
                                        },
                                      ),
                                      title: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              'Pedido ID: ${hoypedidos[index].id}'),
                                          Text(
                                              'Cliente ID: ${hoypedidos[index].cliente_id}'),
                                          Text(
                                              'Monto Total: ${hoypedidos[index].monto_total}'),
                                          Text(
                                            'Estado: ${hoypedidos[index].estado}',
                                            style: TextStyle(
                                                color: hoypedidos[index]
                                                            .estado ==
                                                        'pendiente'
                                                    ? Colors.red
                                                    : hoypedidos[index]
                                                                .estado ==
                                                            'en proceso'
                                                        ? Colors.blue
                                                        : hoypedidos[index]
                                                                    .estado ==
                                                                'entregado'
                                                            ? Colors.green
                                                            : Colors.black),
                                          ),
                                          Text(
                                              'Fecha: ${hoypedidos[index].fecha}'),
                                          Text(
                                              'Tipo: ${hoypedidos[index].tipo}'),
                                        ],
                                      ),
                                      /*trailing: Row(*/
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      // EXPRESS
                      Container(
                        //color: Colors.amber,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color.fromARGB(255, 209, 94, 132),
                        ),
                        margin: const EdgeInsets.only(left: 20),
                        padding: const EdgeInsets.all(15),
                        width: 300,
                        height: 300,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          //crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Express",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            TextField(
                              controller: _searchController,
                              onChanged: (value) {
                                setState(
                                    () {}); // Actualiza el estado al cambiar el texto
                              },
                              decoration: InputDecoration(
                                labelStyle:
                                    const TextStyle(color: Colors.white),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors
                                          .grey), // Cambia el color del cursor cuando el TextField no está enfocado
                                ),
                                labelText: 'Buscar',
                                suffixIcon: IconButton(
                                  icon: const Icon(
                                    Icons.search,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    // Puedes realizar acciones de búsqueda aquí si es necesario
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                controller: _scrollControllerExpress,
                                reverse: true,
                                itemCount: hoyexpress.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: ListTile(
                                      trailing: Checkbox(
                                        value: hoyexpress[index].seleccionado,
                                        onChanged: (value) {
                                          setState(() {
                                            hoyexpress[index].seleccionado =
                                                value ?? false;
                                            obtenerPedidoSeleccionado =
                                                hoyexpress
                                                    .where((element) =>
                                                        element.seleccionado)
                                                    .toList();
                                            if (value == true) {
                                              hoyexpress[index].estado =
                                                  "en proceso";
                                              // AQUI DEBO TAMBIEN HACER "update pedido set estado = en proceso"
                                              // esto con la finalidad de que se maneje el estado en la database
                                              actualizarObtenidos();
                                            } else {
                                              hoyexpress[index].estado =
                                                  'pendiente';
                                              // AQUI DEBO TAMBIEN HACER "update pedido set estado = pendiente"
                                              // esto con la finalidad de que se maneje el estado en la database
                                              actualizarObtenidos();
                                            }
                                          });
                                        },
                                      ),
                                      title: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              'Pedido ID: ${hoyexpress[index].id}'),
                                          Text(
                                              'Cliente ID: ${hoyexpress[index].cliente_id}'),
                                          Text(
                                              'Monto Total: ${hoyexpress[index].monto_total}'),
                                          Text(
                                            'Estado: ${hoyexpress[index].estado}',
                                            style: TextStyle(
                                                color: hoyexpress[index]
                                                            .estado ==
                                                        'pendiente'
                                                    ? Colors.red
                                                    : hoyexpress[index]
                                                                .estado ==
                                                            'en proceso'
                                                        ? Colors.blue
                                                        : hoyexpress[index]
                                                                    .estado ==
                                                                'entregado'
                                                            ? Colors.green
                                                            : Colors.black),
                                          ),
                                          Text(
                                              'Fecha: ${hoyexpress[index].fecha}'),
                                          Text(
                                              'Tipo: ${hoyexpress[index].tipo}'),
                                        ],
                                      ),
                                      /*trailing: Row(*/
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Container(
                        width: 250,
                        height: 250,
                        decoration: BoxDecoration(
                            //color: Colors.amber,
                            borderRadius: BorderRadius.circular(20)),
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            "Informe PDF",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.w400),
                          ),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.amber)),
                        ),
                      )
                    ],
                  ),

                  // CREAR RUTA
                  Container(
                    margin: const EdgeInsets.only(top: 20, left: 20),
                    child: Text(
                      "Creando rutas",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Container(
                    // color: Colors.grey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            // PEDIDOS
                            Container(
                              padding: const EdgeInsets.all(25),
                              margin: const EdgeInsets.only(top: 20, left: 20),
                              height: 300,
                              width: 300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color.fromARGB(255, 53, 102, 142),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "Pedidos Seleccionados",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                      reverse: true,
                                      itemCount:
                                          obtenerPedidoSeleccionado.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                            margin:
                                                const EdgeInsets.only(top: 10),
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Pedido ID: ${obtenerPedidoSeleccionado[index].id} ",
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                                Text(
                                                  "Cliente ID: ${obtenerPedidoSeleccionado[index].cliente_id}",
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                                Text(
                                                  "Monto Total: ${obtenerPedidoSeleccionado[index].monto_total}",
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                                Text(
                                                  "Fecha: ${obtenerPedidoSeleccionado[index].fecha}",
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                                Text(
                                                  "Tipo: ${obtenerPedidoSeleccionado[index].tipo}",
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                )
                                              ],
                                            ));
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),

                            // CONDUCTORES
                            Container(
                              width: 350,
                              height: 300,
                              margin: const EdgeInsets.only(top: 20, left: 20),
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color.fromARGB(255, 53, 102, 142),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "Conductores",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                  const SizedBox(
                                    height: 19,
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: conductores.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                            margin:
                                                const EdgeInsets.only(top: 10),
                                            padding: const EdgeInsets.all(20),
                                            decoration: BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: ListTile(
                                              title: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "C1:${conductores[index].id}",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    "Nombres:${conductores[index].nombres}",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    "Apellidos:${conductores[index].apellidos}",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    "Dni:${conductores[index].dni}",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )
                                                ],
                                              ),
                                              trailing: Checkbox(
                                                value: conductores[index]
                                                    .seleccionado,
                                                onChanged: (value) {
                                                  setState(() {
                                                    conductores[index]
                                                            .seleccionado =
                                                        value ?? false;
                                                    obtenerConductor = conductores
                                                        .where((element) =>
                                                            element
                                                                .seleccionado)
                                                        .toList();
                                                    if (value == true) {
                                                      /*conductores[index]
                                                                      .estado =
                                                                  "Go >>";*/
                                                      // AQUI DEBO TAMBIEN HACER "update pedido set estado = en proceso"
                                                      // esto con la finalidad de que se maneje el estado en la database
                                                      //actualizarObtenidos();
                                                    } else {
                                                      /* conductores[index]
                                                                      .estado =
                                                                  'Ready >>';*/
                                                      // AQUI DEBO TAMBIEN HACER "update pedido set estado = pendiente"
                                                      // esto con la finalidad de que se maneje el estado en la database
                                                      //actualizarObtenidos();
                                                    }
                                                  });
                                                },
                                              ),
                                            ));
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),

                            // MAPA
                            Container(
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.only(top: 20, left: 20),
                              width: 500,
                              height: 300,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 53, 102, 142),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Stack(
                                children: [
                                  FlutterMap(
                                      options: MapOptions(
                                        initialCenter:
                                            LatLng(-16.4055657, -71.5719081),
                                        initialZoom: 15.2,
                                      ),
                                      children: [
                                        TileLayer(
                                          urlTemplate:
                                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                          userAgentPackageName:
                                              'com.example.app',
                                        ),
                                      ]),
                                  Positioned(
                                    bottom:
                                        16.0, // Ajusta la posición vertical según tus necesidades
                                    right:
                                        16.0, // Ajusta la posición horizontal según tus necesidades
                                    child: FloatingActionButton(
                                      onPressed: () {
                                        // Acciones al hacer clic en el FloatingActionButton
                                      },
                                      backgroundColor: const Color.fromARGB(
                                          255, 53, 102, 142),
                                      child: const Icon(Icons.my_location,
                                          color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // BOTON CREAR
                            Container(
                              margin: const EdgeInsets.only(left: 20),
                              height: 250,
                              width: 250,
                              // color: Colors.black,
                              child: ElevatedButton(
                                onPressed: () {},
                                child: Text(
                                  "Crear \u{2795}",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 35),
                                ),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    Color.fromARGB(255, 53, 102, 142),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // SUPERVISION
                  Container(
                    margin: const EdgeInsets.only(top: 20, left: 20, bottom: 0),
                    child: Text(
                      "Supervisión de Rutas",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),

                  // RUTAS

                  Container(
                      margin: const EdgeInsets.only(left: 20, top: 20),
                      height: 500,
                      width: 1450,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 53, 102, 142),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          Text("Ruta del conductor",style:TextStyle(color:Colors.white,fontSize:25)),
                          Expanded(
                            child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                reverse: true,
                                itemCount: 4,
                                itemBuilder: (context, index) {
                                  return Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(
                                            top: 20, left: 20),
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color:
                                              Color.fromARGB(255, 53, 102, 142),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        width: 900,
                                        height: 400,
                                        child: Stack(
                                          children: [
                                            FlutterMap(
                                              options: MapOptions(
                                                initialCenter: LatLng(
                                                    -16.4055657, -71.5719081),
                                                initialZoom: 15.2,
                                              ),
                                              children: [
                                                TileLayer(
                                                  urlTemplate:
                                                      'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                                  userAgentPackageName:
                                                      'com.example.app',
                                                ),
                                                PolylineLayer(polylines: [
                                                  Polyline(
                                                      points: routePoints,
                                                      color: Colors.pinkAccent),
                                                ]),
                                                MarkerLayer(
                                                  markers: [
                                                    map.Marker(
                                                      point: currentLcocation,
                                                      width: 80,
                                                      height: 80,
                                                      child: Icon(
                                                        Icons.directions_car,
                                                        color: Colors.red,
                                                        size: 45.0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Positioned(
                                              bottom:
                                                  16.0, // Ajusta la posición vertical según tus necesidades
                                              right:
                                                  16.0, // Ajusta la posición horizontal según tus necesidades
                                              child: FloatingActionButton(
                                                onPressed: () {
                                                  // Acciones al hacer clic en el FloatingActionButton
                                                },
                                                backgroundColor:
                                                    const Color.fromARGB(
                                                        255, 53, 102, 142),
                                                child: const Icon(
                                                    Icons.my_location,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 400,
                                        height: 400,
                                        margin: const EdgeInsets.only(
                                            top: 20, left: 20),
                                        decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 142, 129, 53),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Column(children: [
                                          Container(
                                            child: Text("Conductor : -------",style: TextStyle(color:Colors.white,fontSize: 25),),
                                          ),
                                          Container(
                                            child: Text("AUTO : -------",style: TextStyle(color:Colors.white,fontSize: 25),),
                                          ),
                                          Container(
                                            child: Text("PLACA : -------",style: TextStyle(color:Colors.white,fontSize: 25),),
                                          )
                                        ]),
                                      ),
                                    ],
                                  );
                                }),
                          ),
                        ],
                      )),
                  const SizedBox(
                    width: 30,
                  ),

                  /* Container(
                    height: 500,
                    width: 1500,
                    // color:Colors.red,
                    child: 
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                          reverse: true,
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(top: 20),
                              width: 200,
                              height: 200,
                              color: const Color.fromARGB(255, 119, 118, 104),
                              child: Text("s"),

                            );/*Row(
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.only(top: 20, left: 20),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 53, 102, 142),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  width: 1100,
                                  height: 400,
                                  child: Stack(
                                    children: [
                                      FlutterMap(
                                        options: MapOptions(
                                          initialCenter:
                                              LatLng(-16.4055657, -71.5719081),
                                          initialZoom: 15.2,
                                        ),
                                        children: [
                                          TileLayer(
                                            urlTemplate:
                                                'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                            userAgentPackageName:
                                                'com.example.app',
                                          ),
                                          PolylineLayer(polylines: [
                                            Polyline(
                                                points: routePoints,
                                                color: Colors.pinkAccent),
                                          ]),
                                          MarkerLayer(
                                            markers: [
                                              map.Marker(
                                                point: currentLcocation,
                                                width: 80,
                                                height: 80,
                                                child: Icon(
                                                  Icons.directions_car,
                                                  color: Colors.red,
                                                  size: 45.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Positioned(
                                        bottom:
                                            16.0, // Ajusta la posición vertical según tus necesidades
                                        right:
                                            16.0, // Ajusta la posición horizontal según tus necesidades
                                        child: FloatingActionButton(
                                          onPressed: () {
                                            // Acciones al hacer clic en el FloatingActionButton
                                          },
                                          backgroundColor: const Color.fromARGB(
                                              255, 53, 102, 142),
                                          child: const Icon(Icons.my_location,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                Container(
                                  width: 400,
                                  height: 400,
                                  margin:
                                      const EdgeInsets.only(top: 20, left: 20),
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 53, 102, 142),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Column(children: [Container()]),
                                ),
                              ],
                            );*/
                          }),
                    ),
                  ),
*/

                  // COPPYRIGHT
                  Container(
                    //Text('Click \u{2795} to add')
                    margin: const EdgeInsets.all(30),
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            width: 50,
                            height: 50,
                            child: Image.asset('lib/imagenes/logo_sol.png')),
                        Text(" v.1.0.0 ", style: TextStyle(fontSize: 20)),
                        Text(
                          "Copyright \u00a9 COTECSA - 2024",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                      ],
                    )),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
