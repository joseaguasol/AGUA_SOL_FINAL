//import 'package:slidable_button/slidable_button.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
//import 'package:flutter/services.dart';
//import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:flutter/material.dart';
import 'dart:convert';

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
class Conductor{
  final int id;
  final String nombres;
  final String apellidos;
  final String licencia;
  final String dni;
  final String fecha;
  

  bool seleccionado; // Nuevo campo para rastrear la selección

  Conductor(
      {required this.id,
      required this.nombres,
      required this.apellidos,
      required this.licencia,
      required this.dni,
      required this.fecha,
      this.seleccionado = false});
}

class Armado extends StatefulWidget {
  const Armado({super.key});

  @override
  State<Armado> createState() => _ArmadoState();
}

class _ArmadoState extends State<Armado> {
  late ScrollController _scrollController;
  late ScrollController _scrollControllerAgendados;
  late ScrollController _scrollControllerExpress;
  late io.Socket socket;
  List<Pedido> hoypedidos = [];
  List<Pedido> hoyexpress = [];
  List<Pedido> agendados = [];
  List<Pedido> obtenerPedidoSeleccionado = [];

  DateTime now = DateTime.now();

  // formattedDate = "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";

  var direccion = '';
  String apiPedidos = 'http://127.0.0.1:8004/api/pedido';
  final TextEditingController _searchController = TextEditingController();
  //final TextEditingController _distrito = TextEditingController();
  //final TextEditingController _ubicacion = TextEditingController();
  

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    connectToServer();
    getPedidos();
  }

  void actualizarObtenidos(){
    setState(() {
      obtenerPedidoSeleccionado = [...hoypedidos,...hoyexpress,...agendados]
      .where((element) => element.seleccionado).toList();

    });
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



  void connectToServer() {
    print("dentro de connecttoServer");
    // Reemplaza la URL con la URL de tu servidor Socket.io
    socket = io.io('http://127.0.0.1:8004', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'reconnect': true,
      'reconnectionAttempts': 5,
      'reconnectionDelay': 1000,
    });

    socket.connect();
    socket.onConnect((_) {
      print('Conexión establecida');
    });

    socket.onDisconnect((_) {
      print('Conexión desconectada');
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
            fechaparseada.day == now.day)
        {
          Pedido nuevoHoy = Pedido(
            id: data['id'],
            cliente_id: data['cliente_id'],
            cliente_nr_id:data['cliente_nr_id'],
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
            fechaparseada.day == now.day)
        {
          Pedido nuevoExpress = Pedido(
            id: data['id'],
            cliente_id: data['cliente_id'],
            cliente_nr_id:data['cliente_nr_id'],
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
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });

    socket.onConnectError((error) {
      print("error de conexion $error");
    });

    socket.onError((error) {
      print("error de socket, $error");
    });
  }

  @override
  void dispose() {
    socket.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
        // drawer: Drawer(),
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Row(children: [
                  NavigationRail(
                    backgroundColor: Color.fromRGBO(2, 84, 151, 1),
                    //extended: true,
                    destinations: const [
                      NavigationRailDestination(
                        icon: Icon(Icons.water_drop,
                            size: 50, color: Colors.white),
                        label: Text(
                          'Inicio',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ),
                      //const SizedBox(height: 2,),
                      NavigationRailDestination(
                        icon: Icon(Icons.assistant_direction_outlined,
                            size: 50, color: Colors.white),
                        label: Text(
                          'Rutear',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.sensor_occupied,
                            size: 50, color: Colors.white),
                        label: Text(
                          'Supervisión',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.my_library_books,
                            size: 50, color: Colors.white),
                        label: Text(
                          'Informe',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ),
                    ],
                    selectedIndex: 0,
                    labelType: NavigationRailLabelType.none,
                    onDestinationSelected: (value) {
                      print('selected: $value');
                    },
                  ),
                  
                  // CONTENIDO
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${MediaQuery.of(context).size.width}"),
                          Text("${MediaQuery.of(context).size.height}"),

                          // TITULOS
                          Container(
                            //color: Colors.grey,
                            margin: const EdgeInsets.only(top: 0, left: 20),
                            child: Row(
                              children: [
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Vamos a Rutear!",
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    Text(
                                      "Aquí está la info de los pedidos",
                                      style: TextStyle(fontSize: 30),
                                    )
                                  ],
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 50),
                                  height: 150,
                                  width: 150,
                                  child:
                                      Lottie.asset('lib/imagenes/rutita.json'),
                                ),
                              ],
                            ),
                          ),

                          // PEDIDOS
                          Row(
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
                                    const Text("Agendados",style: TextStyle(fontSize: 20),),
                                    TextField(controller: _searchController,
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
                                        // controller: _scrollControllerAgendados,
                                        itemCount: agendados.length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            margin:
                                                const EdgeInsets.only(top: 10),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Colors.white),
                                            child: ListTile(
                                              trailing: Checkbox(
                                                value: agendados[index].seleccionado,
                                                onChanged: (value) {
                                                  setState(() {
                                                    agendados[index].seleccionado = value ?? false;
                                                    obtenerPedidoSeleccionado =agendados.where((element) => element.seleccionado).toList();
                                                    if(value == true){
                                                      agendados[index].estado = "en proceso";
                                                      // AQUI DEBO TAMBIEN HACER "update pedido set estado = en proceso"
                                                      // esto con la finalidad de que se maneje el estado en la database
                                                      actualizarObtenidos();
                                                    }
                                                    else{
                                                      agendados[index].estado = 'pendiente';
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
                                                  Text('Estado: ${agendados[index].estado}',
                                                  style: TextStyle(color: agendados[index].estado == 'pendiente' ? Colors.red
                                                    : agendados[index].estado == 'en proceso' ? Colors.blue
                                                    : agendados[index].estado == 'entregado' ? Colors.green
                                                    : Colors.black),),
                                                  
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
                                    color: Color.fromARGB(255, 137, 108, 139)),
                                margin: const EdgeInsets.only(left: 20),
                                padding: const EdgeInsets.all(15),
                                width: 500,
                                height: 300,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  //crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Hoy",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                    TextField(
                                      controller: _searchController,
                                      onChanged: (value) {
                                        setState(
                                            () {}); // Actualiza el estado al cambiar el texto
                                      },
                                      decoration: InputDecoration(
                                        labelStyle: const TextStyle(
                                            color: Colors.white),
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
                                            margin:
                                                const EdgeInsets.only(top: 10),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: ListTile(
                                              trailing: Checkbox(
                                                value: hoypedidos[index].seleccionado,
                                                onChanged: (value) {
                                                  setState(() {
                                                    hoypedidos[index].seleccionado = value ?? false;
                                                    obtenerPedidoSeleccionado =hoypedidos.where((element) => element.seleccionado).toList();
                                                    if(value == true){
                                                      hoypedidos[index].estado = "en proceso";
                                                      // AQUI DEBO TAMBIEN HACER "update pedido set estado = en proceso"
                                                      // esto con la finalidad de que se maneje el estado en la database
                                                      actualizarObtenidos();
                                                    }
                                                    else{
                                                      hoypedidos[index].estado = 'pendiente';
                                                      // AQUI DEBO TAMBIEN HACER "update pedido set estado = pendiente"
                                                      // esto con la finalidad de que se maneje el estado en la database
                                                      actualizarObtenidos();
                                                    }
                                                  });
                                                },
                                              ),
                                              title: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text('Pedido ID: ${hoypedidos[index].id}'),
                                                  Text('Cliente ID: ${hoypedidos[index].cliente_id}'),
                                                  Text('Monto Total: ${hoypedidos[index].monto_total}'),
                                                  Text('Estado: ${hoypedidos[index].estado}',
                                                  style: TextStyle(color:hoypedidos[index].estado== 'pendiente' ? Colors.red
                                                  :hoypedidos[index].estado == 'en proceso' ? Colors.blue
                                                  :hoypedidos[index].estado == 'entregado' ? Colors.green
                                                  : Colors.black),),
                                                  Text('Fecha: ${hoypedidos[index].fecha}'),
                                                  Text('Tipo: ${hoypedidos[index].tipo}'),
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
                                width: 500,
                                height: 300,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  //crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Express",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                    TextField(
                                      controller: _searchController,
                                      onChanged: (value) {
                                        setState(
                                            () {}); // Actualiza el estado al cambiar el texto
                                      },
                                      decoration: InputDecoration(
                                        labelStyle: const TextStyle(
                                            color: Colors.white),
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
                                        reverse: true,
                                        itemCount: hoyexpress.length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            margin:
                                                const EdgeInsets.only(top: 10),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: ListTile(
                                              trailing: Checkbox(
                                                value: hoypedidos[index].seleccionado,
                                                onChanged: (value) {
                                                  setState(() {
                                                    hoyexpress[index].seleccionado = value ?? false;
                                                    obtenerPedidoSeleccionado =hoyexpress.where((element) => element.seleccionado).toList();
                                                    if(value == true){
                                                      hoyexpress[index].estado = "en proceso";
                                                      // AQUI DEBO TAMBIEN HACER "update pedido set estado = en proceso"
                                                      // esto con la finalidad de que se maneje el estado en la database
                                                      actualizarObtenidos();
                                                    }
                                                    else{
                                                      hoyexpress[index].estado = 'pendiente';
                                                      // AQUI DEBO TAMBIEN HACER "update pedido set estado = pendiente"
                                                      // esto con la finalidad de que se maneje el estado en la database
                                                      actualizarObtenidos();
                                                    }
                                                  });
                                                },
                                              ),
                                              title: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text('Pedido ID: ${hoyexpress[index].id}'),
                                                  Text('Cliente ID: ${hoyexpress[index].cliente_id}'),
                                                  Text('Monto Total: ${hoyexpress[index].monto_total}'),
                                                  Text('Estado: ${hoyexpress[index].estado}',
                                                  style: TextStyle(color:hoyexpress[index].estado== 'pendiente' ? Colors.red
                                                  :hoyexpress[index].estado == 'en proceso' ? Colors.blue
                                                  :hoyexpress[index].estado == 'entregado' ? Colors.green
                                                  : Colors.black),),
                                                  Text('Fecha: ${hoyexpress[index].fecha}'),
                                                  Text('Tipo: ${hoyexpress[index].tipo}'),
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
                            ],
                          ),

                          // CREAR RUTA
                          Container(
                            margin: const EdgeInsets.only(top: 20, left: 20),
                            child: Text(
                              "Creando rutas",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w500),
                            ),
                          ),
                          Container(
                            // color: Colors.grey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(25),
                                      margin: const EdgeInsets.only(
                                          top: 20, left: 20),
                                      height: 300,
                                      width: 300,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Color.fromARGB(
                                              255, 153, 13, 146)),
                                      child: Column(
                                        children: [
                                          Text(
                                            "Pedidos Seleccionados",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Expanded(
                                            child: ListView.builder(
                                              reverse: true,
                                              itemCount: obtenerPedidoSeleccionado.length,
                                              itemBuilder: (context, index) {
                                                return Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 10),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    decoration: BoxDecoration(
                                                        color: Colors.yellow,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20)),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text("Pedido ID: ${obtenerPedidoSeleccionado[index].id} "),
                                                        Text(
                                                            "Cliente ID: ${obtenerPedidoSeleccionado[index].cliente_id}"),
                                                        Text(
                                                            "Monto Total: ${obtenerPedidoSeleccionado[index].monto_total}"),
                                                        Text("Fecha: ${obtenerPedidoSeleccionado[index].fecha}"),
                                                        Text("Tipo: ${obtenerPedidoSeleccionado[index].tipo}")
                                                      ],
                                                    ));
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 500,
                                      height: 300,
                                      margin: const EdgeInsets.only(
                                          top: 20, left: 20),
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color:
                                              Color.fromARGB(255, 13, 153, 18)),
                                      child: Column(
                                        children: [
                                          Text(
                                            "Conductores",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white),
                                          ),
                                          const SizedBox(
                                            height: 19,
                                          ),
                                          Expanded(
                                            child: ListView.builder(
                                              itemCount: 10,
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 10),
                                                  padding:
                                                      const EdgeInsets.all(20),
                                                  decoration: BoxDecoration(
                                                      color: Colors.yellow,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "C1: Paul",
                                                        style: TextStyle(
                                                            fontSize: 20),
                                                      ),
                                                      Icon(Icons
                                                          .account_circle_outlined)
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      margin: const EdgeInsets.only(
                                          top: 20, left: 20),
                                      width: 700,
                                      height: 300,
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 13, 151, 153),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: FlutterMap(
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
                                          ]),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.only(top: 20, left: 320),
                                  height: 50,
                                  width: 190,
                                  // color: Colors.black,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    child: Text(
                                      "¿ Crear ?",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Color.fromARGB(255, 13, 90, 153)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // RESUMEN
                          Container(
                            margin: const EdgeInsets.only(left: 20, top: 20),
                            child: Text(
                              "Resumen de rutas",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w500),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(20),
                            margin: const EdgeInsets.only(
                                left: 20, top: 20, bottom: 20),
                            height: 300,
                            width: 1380,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 13, 90, 153),
                                borderRadius: BorderRadius.circular(20)),
                            child: Expanded(
                              child: ListView.builder(
                                itemCount: 15,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: const EdgeInsets.only(top: 20),
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                        color: Colors.yellow,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: ListTile(
                                      title: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "R:$index C:$index Pedidos:P$index P$index P$index",
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          /* Container(
                              decoration: const BoxDecoration(color: Colors.grey),
                              margin: const EdgeInsets.only(top: 10, left: 20),
                              child: Text(
                                "CRUD rutas",
                                style: TextStyle(fontSize: 30),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 20),
                              padding: const EdgeInsets.all(5),
                              color: Colors.red,
                              // width: 700,
                              height: 600,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                //mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    width: 700,
                                    height: 500,
                                    color: Colors.yellow,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // LISTA DE CONDUCTORES
                                        Text(
                                          "Iniciemos las Rutas",
                                          style: TextStyle(fontSize: 25),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(5),
                                          height: 190,
                                          width: 500,
                                          color: Colors.purple,
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 150,
                                                width: 240,
                                                color: Colors.blue,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        "Conductores Disponibles"),
                                                    Container(
                                                      color: Colors.pink,
                                                      height: 130,
                                                      child: ListView.builder(
                                                        itemCount: 19,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return Container(
                                                            color: Colors.white,
                                                            margin:
                                                                const EdgeInsets
                                                                    .only(top: 5),
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                    "C$index : Jhon"),
                                                                Icon(Icons
                                                                    .co_present_outlined),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                height: 150,
                                                width: 240,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(15),
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            'lib/imagenes/ruteando.jpg'),
                                                        fit: BoxFit.fill)),
                      
                                                //color: Colors.white,
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                      
                                        // RANGOS Y PUNTOS : PEDIDOS
                                        Container(
                                          height: 220,
                                          width: 600,
                                          color: Colors.brown,
                                          padding: const EdgeInsets.all(15),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 90,
                                                color: Colors.cyan,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text("Rango de Pedidos"),
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    Row(
                                                      //mainAxisAlignment: MainAxisAlignment.start,
                                                      //crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text("Del"),
                                                        const SizedBox(
                                                          width: 19,
                                                        ),
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            // borderRadius: BorderRadius.circular(10),
                                                            color: Colors
                                                                .amberAccent,
                                                          ),
                                                          width: 60,
                                                          height: 30,
                                                          child: TextField(
                                                            decoration:
                                                                InputDecoration(
                                                                    labelText:
                                                                        'Px'),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 19,
                                                        ),
                                                        Text("al"),
                                                        const SizedBox(
                                                          width: 19,
                                                        ),
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            //borderRadius: BorderRadius.circular(10),
                                                            color: Colors
                                                                .amberAccent,
                                                          ),
                                                          width: 60,
                                                          height: 30,
                                                          child: TextField(
                                                            decoration:
                                                                InputDecoration(
                                                                    labelText:
                                                                        'Py'),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 19,
                                                        ),
                                                        Text("asignado a"),
                                                        const SizedBox(
                                                          width: 20,
                                                        ),
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            // borderRadius: BorderRadius.circular(10),
                                                            color: Colors
                                                                .amberAccent,
                                                          ),
                                                          width: 60,
                                                          height: 30,
                                                          child: TextField(
                                                            decoration:
                                                                InputDecoration(
                                                                    labelText:
                                                                        'Cx'),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 20,
                                                        ),
                                                        Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              // borderRadius: BorderRadius.circular(10),
                                                              color: Colors
                                                                  .amberAccent,
                                                            ),
                                                            width: 60,
                                                            height: 50,
                                                            child: Icon(
                                                              Icons
                                                                  .add_circle_outline_outlined,
                                                              size: 50,
                                                              color: Colors
                                                                  .pinkAccent,
                                                            )),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                height: 100,
                                                color: Colors.grey,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text("Puntos Pedidos"),
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    Row(
                                                      //mainAxisAlignment: MainAxisAlignment.start,
                                                      //crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text("Del"),
                                                        const SizedBox(
                                                          width: 19,
                                                        ),
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            // borderRadius: BorderRadius.circular(10),
                                                            color: Colors
                                                                .amberAccent,
                                                          ),
                                                          width: 160,
                                                          height: 30,
                                                          child: TextField(
                                                            decoration:
                                                                InputDecoration(
                                                                    labelText:
                                                                        'Px'),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 19,
                                                        ),
                                                        Text("asignado a"),
                                                        const SizedBox(
                                                          width: 20,
                                                        ),
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            // borderRadius: BorderRadius.circular(10),
                                                            color: Colors
                                                                .amberAccent,
                                                          ),
                                                          width: 60,
                                                          height: 30,
                                                          child: TextField(
                                                            decoration:
                                                                InputDecoration(
                                                                    labelText:
                                                                        'Cx'),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 20,
                                                        ),
                                                        Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              // borderRadius: BorderRadius.circular(10),
                                                              color: Colors
                                                                  .amberAccent,
                                                            ),
                                                            width: 60,
                                                            height: 60,
                                                            child: IconButton(
                                                                onPressed: () {},
                                                                icon: Icon(
                                                                  Icons
                                                                      .add_circle_outline,
                                                                  size: 50,
                                                                ))),
                                                      ],
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
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Container(
                                    height: 150,
                                    width: 240,
                                    padding: const EdgeInsets.all(5),
                                    color:
                                        const Color.fromARGB(255, 33, 243, 159),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Rutas asignados"),
                                        Container(
                                          color: Colors.pink,
                                          height: 130,
                                          child: ListView.builder(
                                            itemCount: 19,
                                            itemBuilder: (context, index) {
                                              return Container(
                                                color: Colors.white,
                                                margin:
                                                const EdgeInsets.only(top: 5),
                                                child: Row(
                                                  children: [
                                                    Text("R$index :P$index >> C$index Jhon"),
                                                    IconButton(onPressed: (){},
                                                     icon: Icon(Icons.delete)
                                                    )
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10,),
                            Container(
                              margin: const EdgeInsets.only(left: 20),
                              color: Colors.green,
                              child: Text("Supervisión Rutas"),
                      
                            ),
                            const SizedBox(height: 20,),
                            Container(
                              margin: const EdgeInsets.only(left: 20),
                              height: 700,
                              color:Colors.blueGrey,
                              child: Text("s"),
                            ),
                      
                          */
                        ],
                      ),
                    ),
                  ),
                ]))));
  }
}
