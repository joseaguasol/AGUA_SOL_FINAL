import 'package:app_final/components/test/asistencia.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class Producto {
  final String nombre;
  final double precio;
  final String descripcion;

  final String foto;

  Producto(
      {required this.nombre,
      required this.precio,
      required this.descripcion,
      required this.foto});
}

class Hola extends StatefulWidget {
  final String? url;
  const Hola({this.url, Key? key}) : super(key: key);

  @override
  State<Hola> createState() => _HolaState();
}

class _HolaState extends State<Hola> with TickerProviderStateMixin {
  String apiProducts = 'http://10.0.2.2:8004/api/products';
  List<Producto> listProducto = [];

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAutoScroll();
    });
    getProducts();
  }

  bool _autoScrollInProgress = false;

  void _startAutoScroll() {
    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (!_autoScrollInProgress) {
        _autoScroll();
      }
    });
  }

  void _autoScroll() async {
    // Marcar que el desplazamiento automático está en progreso
    _autoScrollInProgress = true;

    print("Auto-scroll initiated");

    // Espera 5 segundos antes de iniciar el desplazamiento automático
    await Future.delayed(const Duration(seconds: 2));

    if (_scrollController.hasClients) {
      print("ScrollController has clients");

      // Desplázate hacia abajo
      await _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 5),
        curve: Curves.easeInOut,
      );

      // Espera 4 segundos antes de volver a la posición inicial
      await Future.delayed(const Duration(seconds: 4));

      // Desplázate de nuevo hacia arriba
      await _scrollController.animateTo(
        0.0,
        duration: const Duration(seconds: 5),
        curve: Curves.easeInOut,
      );
    } else {
      print("ScrollController has no clients");
    }

    // Marcar que el desplazamiento automático ha terminado
    _autoScrollInProgress = false;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<dynamic> getProducts() async {
    print("-------get products---------");
    var res = await http.get(
      Uri.parse(apiProducts),
      headers: {"Content-type": "application/json"},
    );
    try {
      if (res.statusCode == 200) {
        var data = json.decode(res.body);
        List<Producto> tempProducto = data.map<Producto>((mapa) {
          return Producto(
              nombre: mapa['nombre'],
              precio: mapa['precio'].toDouble(),
              descripcion: mapa['descripcion'],
              foto:
                  'http://10.0.2.2:8004/images/${mapa['foto'].replaceAll(r'\\', '/')}');
        }).toList();

        setState(() {
          listProducto = tempProducto;
          //conductores = tempConductor;
        });
        print("....lista productos");
        print(listProducto[0].foto);
      }
    } catch (e) {
      print('Error en la solicitud: $e');
      throw Exception('Error en la solicitud: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final TabController _tabController = TabController(length: 2, vsync: this);
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 2, 68, 122),
                ),
                child: const Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                title: Text('Opción 1'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Opción 2'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(
                height: 200,
              ),
              ElevatedButton(
                  onPressed: () {
                    //Navigator.pushReplacementNamed(context, '/loginsol');
                  },
                  child: Text("Salir")),
            ],
          ),
        ),
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin:
                            const EdgeInsets.only(top: 10, left: 20, right: 20),
                        //color:Colors.red,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () {
                                  _scaffoldKey.currentState?.openDrawer();
                                },
                                icon: Icon(Icons.menu)),
                            Container(
                              child: ClipRRect(
                                child: widget.url != null
                                    ? Image.network(widget.url!)
                                    : Image.asset('lib/imagenes/chica.jpg'),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 84, 81, 81),
                                  borderRadius: BorderRadius.circular(20)),
                              height: 50,
                              width: 50,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20),
                        child: Text(
                          "Hola, Stefanny !",
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 20,
                              color: Color.fromARGB(255, 3, 34, 60)),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20),
                        child: const Row(
                          children: [
                            Text(
                              "Bienvenid@ a ",
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Color.fromARGB(255, 3, 34, 60)),
                            ),
                            Text(
                              "Agua Sol",
                              style: TextStyle(
                                  color: const Color.fromARGB(255, 3, 42, 74),
                                  fontFamily: 'Pacifico',
                                  fontSize: 35),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 70,
                        margin: const EdgeInsets.only(left: 20),
                        // color: Colors.grey,
                        child: Row(
                          // mainAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Disfruta!",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 30,
                                  color: Color.fromARGB(255, 3, 34, 60)),
                            ),
                            Container(
                                //height: 80,
                                // width: 80,
                                child: Lottie.asset('lib/imagenes/vasito.json'))
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        //color:Colors.red,
                        height: 50,
                        margin: const EdgeInsets.only(left: 20),
                        child: TabBar(
                            controller: _tabController,
                            indicatorWeight: 10,
                            labelStyle: TextStyle(
                                fontSize:
                                    20), // Ajusta el tamaño del texto de la pestaña seleccionada
                            unselectedLabelStyle: TextStyle(fontSize: 16),
                            labelColor: const Color.fromARGB(255, 0, 52, 95),
                            unselectedLabelColor: Colors.grey,
                            indicatorColor: Color.fromARGB(255, 21, 168, 14),
                            tabs: [
                              Tab(
                                text: "Promociones",
                              ),
                              Tab(
                                text: "Productos",
                              ),
                            ]),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20, left: 20),
                        height: 350,

                        //
                        width: double.maxFinite,
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            ListView.builder(
                                controller: _scrollController,
                                scrollDirection: Axis.horizontal,
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context, '/promos');
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      height: 300,
                                      width: 300,
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromARGB(255, 71, 106, 133),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          image: const DecorationImage(
                                            image: AssetImage(
                                                'lib/imagenes/bodegon.png'),
                                            fit: BoxFit.cover,
                                          )),
                                    ),
                                  );
                                }),
                            ListView.builder(
                                scrollDirection: Axis.horizontal,
                                controller: _scrollController,
                                itemCount: listProducto.length,
                                itemBuilder: (context, index) {
                                  Producto producto = listProducto[index];
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, '/productos');
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      height: 300,
                                      width: 300,
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromARGB(255, 75, 108, 134),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          image: DecorationImage(
                                            image: NetworkImage(producto.foto),
                                            fit: BoxFit.cover,
                                          )),
                                    ),
                                  );
                                }),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Container(
                        height: 100,
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        //color: Colors.grey,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                    margin: const EdgeInsets.only(right: 90),
                                    child: const Text(
                                      "Mejora!",
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w300,
                                          color:
                                              Color.fromARGB(255, 2, 46, 83)),
                                    )),
                                Container(
                                    margin: const EdgeInsets.only(right: 80),
                                    //color:Colors.grey,
                                    child: const Text(
                                      "Tú vida",
                                      style: TextStyle(
                                          fontSize: 30,
                                          color:
                                              Color.fromARGB(255, 3, 31, 54)),
                                    )),
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              // color:Colors.amber,
                              child: Text(
                                "Necesitas",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 6, 46, 78)),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        child: Row(children: [
                          Container(
                            width: 150,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text(
                                        'PRONTO',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 4, 80, 143)),
                                      ),
                                      content: const Text(
                                        'Muy pronto te sorprenderemos!',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pop(); // Cierra el AlertDialog
                                          },
                                          child: const Text(
                                            'OK',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25,
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
                                    const Color.fromARGB(255, 0, 59, 108)),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons
                                        .attach_money_outlined, // Reemplaza con el icono que desees
                                    size: 24,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                      width:
                                          8), // Ajusta el espacio entre el icono y el texto según tus preferencias
                                  Text(
                                    " Aquí ",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(child: Container()),
                          Container(
                            width: 200,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Asistencia()),
                                );
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    const Color.fromARGB(255, 0, 59, 108)),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons
                                        .face, // Reemplaza con el icono que desees
                                    size: 28,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                      width:
                                          8), // Ajusta el espacio entre el icono y el texto según tus preferencias
                                  Text(
                                    "¿ Asistencia ?",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ]))));
  }
}
