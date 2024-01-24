import 'package:app_final_desktop/components/empleado/armado.dart';
import 'dart:convert';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class Producto {
  final String nombre;
  final String descripcion;
  final double precio;
  final String foto;

  int cantidad;
  double descuento;

  Producto(
      {required this.nombre,
      required this.descripcion,
      required this.precio,
      required this.foto,
      this.cantidad = 0,
      this.descuento = 0.0});
}

class Promo {
  
  final String nombre;
  final double precio;
  final String descripcion;
  final String fecha_limite;
  final String foto;
  int cantidad;
  double descuento;

  Promo(
      {
      required this.nombre,
      required this.precio,
      required this.descripcion,
      required this.fecha_limite,
      required this.foto,
      this.cantidad = 0,
      this.descuento = 0.0});
}

class ProductoPromocion {
  final int promocionId;
  final int productoId;
  final int cantidadProd;
  final int? cantidadPromo;

  ProductoPromocion({
    required this.promocionId,
    required this.productoId,
    required this.cantidadProd,
    required this.cantidadPromo,
  });
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var direccion = '';
  final TextEditingController _nombres = TextEditingController();
  final TextEditingController _apellidos = TextEditingController();
  final TextEditingController _direccion = TextEditingController();
  final TextEditingController _telefono = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _distrito = TextEditingController();
  final TextEditingController _ubicacion = TextEditingController();
  final TextEditingController _ruc = TextEditingController();

  late double temperatura = 0.0;
  final now = DateTime.now();
  // Formato para obtener el nombre del mes
  final monthFormat = DateFormat('MMMM');

  // Lista de productos
  List<Producto> listProducts = [];
  List<dynamic> listElementos = [];

  String apiClima =
      "https://api.openweathermap.org/data/2.5/weather?q=Arequipa&appid=08607bf479e5f47f5b768154953d10f6";

  String apiProducts ='http://127.0.0.1:8004/api/products';// 'https://aguasolfinal-dev-qngg.2.us-1.fl0.io/api/products';
  String apiClienteNR = 'http://127.0.0.1:8004/api/clientenr';

  String apiPromos = 'http://127.0.0.1:8004/api/promocion';

  Future<dynamic> createNR(nombre, apellidos, direccion, telefono, email,
      distrito, ubicacion, ruc) async {
    try {
      await http.post(Uri.parse(apiClienteNR),
          headers: {"Content-type": "application/json"},
          body: jsonEncode({
            "nombre": nombre,
            "apellidos": apellidos,
            "direccion": direccion,
            "telefono": telefono,
            "email": email ?? "",
            "distrito": distrito,
            "ubicacion": ubicacion,
            "ruc": ruc ?? ""
          }));
    } catch (e) {
      throw Exception('Error en la solicitud: $e');
    }
  }

  Future<dynamic> getTemperature() async {
    try {
      var res = await http.get(Uri.parse(apiClima),
          headers: {"Content-type": "application/json"});
      if (res.statusCode == 200) {
        var data = json.decode(res.body);
        print("${now}");
        //
        print("${data['main']['temp']}");
        setState(() {
          temperatura = data['main']['temp'] - 273.15;
        });
      }
    } catch (e) {
      print('Error en la solicitud: $e');
      throw Exception('Error en la solicitud: $e');
    }
  }

  Future<dynamic> getProducts() async {
    var res = await http.get(Uri.parse(apiProducts),
        headers: {"Content-type": "application/json"});

    try {
      if (res.statusCode == 200) {
        //
        var data = json.decode(res.body);
        List<Producto> tempProductos = data.map<Producto>((mapa) {
          return Producto(
              nombre: mapa['nombre'],
              descripcion: mapa['descripcion'],
              precio: mapa['precio'].toDouble(),
              foto:
                  'http://127.0.0.1:8004/images/${mapa['foto']}');
        }).toList();
        for (var i = 0; i < tempProductos.length; i++) {
          listElementos.add(tempProductos[i]);
          print("-------LISTAAAPRO");
          print(listProducts);
        }
      }
    } catch (e) {
      print('Error en la solicitud: $e');
      throw Exception('Error en la solicitud: $e');
    }
  }

  Future<dynamic> getPromos() async {
    var res = await http.get(Uri.parse(apiPromos),
        headers: {"Content-type": "application/json"});

    try {
      if (res.statusCode == 200) {
        //
        var data = json.decode(res.body);
        List<Promo> tempPromos = data.map<Promo>((mapa) {
          return Promo(
              nombre: mapa['nombre'],
              descripcion: mapa['descripcion'],
              precio: mapa['precio'].toDouble(),
              fecha_limite: mapa['fecha_limite'].toString(),
              foto:
                  'http://127.0.0.1:8004/images/${mapa['foto']}');
        }).toList();
        for (var i = 0; i < tempPromos.length; i++) {
          listElementos.add(tempPromos[i]);
   
        }
      }
    } catch (e) {
      print('Error en la solicitud: $e');
      throw Exception('Error en la solicitud: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getTemperature();
    getProducts();
    getPromos();
  }

  @override
  Widget build(BuildContext context) {
    // Formato para obtener el nombre del mes
    final monthFormat = DateFormat('MMMM');

    // Obtener el nombre del mes
    final monthName = monthFormat.format(now);

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 191, 195, 199),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CABECERA

              Container(
                //color:Colors.grey,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        margin: const EdgeInsets.only(left: 20),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hola,Floreshita",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w200),
                            ),
                            Row(
                              children: [
                                Text(
                                  "Bienvenid@ a ",
                                  style: TextStyle(fontSize: 25),
                                ),
                                Text(
                                  "Agua Sol",
                                  style: TextStyle(
                                      fontFamily: 'Pacifico', fontSize: 25),
                                )
                              ],
                            ),
                          ],
                        )),
                    const SizedBox(
                      width: 50,
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 20),
                      width: 60,
                      height: 60,
                      // color:Colors.blueGrey,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: const DecorationImage(
                              image: AssetImage('lib/imagenes/chica.jpg'))),
                    ),
                    const SizedBox(
                      width: 150,
                    ),
                    const SizedBox(
                      width: 150,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          Text(
                            "Arequipa, ${now.day} de ${monthName} del ${now.year}",
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            "${temperatura.toStringAsFixed(1)} ° C",
                            style: TextStyle(fontSize: 40),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                //width:anchoActual,
                //height:largoActual,
              ),
              Container(
                margin: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    const Text(
                      "Sistema de Pedido",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Container(
                        margin: const EdgeInsets.only(left: 20),
                        width: 60,
                        height: 60,
                        child: Lottie.asset('lib/imagenes/call.json')),
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      const Armado(),
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
                                Color.fromARGB(255, 135, 83, 128))),
                        child: Text("Sistema de Ruteo >>",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),

              // CONTENIDO
              const SizedBox(
                height: 20,
              ),

              Container(
                height: 650,
                //height: MediaQuery.of(context).size.height,
                margin: const EdgeInsets.only(left: 20),
                //color: Colors.blue,

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // FORMULARIO

                    Container(
                      //color:Colors.green,
                      width:
                          MediaQuery.of(context).size.width <= 1580 ? 300 : 400,
                      height:
                          MediaQuery.of(context).size.height <= 800 ? 700 : 800,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            child: const Text(
                              "Datos del Cliente",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          SingleChildScrollView(
                            child: Container(
                              //  height: MediaQuery.of(context).size.height/1.45,//1.5,
                              margin: const EdgeInsets.only(bottom: 0),
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        controller: _nombres,
                                        decoration: const InputDecoration(
                                          labelText: 'Nombres',
                                          hintText: 'Ingrese sus nombres',
                                          isDense: true,
                                          labelStyle: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Color.fromARGB(255, 1, 55, 99),
                                          ),
                                          hintStyle: TextStyle(
                                            fontSize: 13.0,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'El campo es obligatorio';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      TextFormField(
                                        controller: _apellidos,
                                        decoration: InputDecoration(
                                          labelText: 'Apellidos',
                                          hintText: 'Ingrese sus apellidos',
                                          isDense: true,
                                          labelStyle: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Color.fromARGB(255, 1, 55, 99),
                                          ),
                                          hintStyle: TextStyle(
                                            fontSize: 13.0,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'El campo es obligatorio';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      TextFormField(
                                        controller: _direccion,
                                        decoration: InputDecoration(
                                          labelText: 'Direccion',
                                          hintText: 'Ingrese su direccion',
                                          isDense: true,
                                          labelStyle: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Color.fromARGB(255, 1, 55, 99),
                                          ),
                                          hintStyle: TextStyle(
                                            fontSize: 13.0,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'El campo es obligatorio';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      TextFormField(
                                        controller: _telefono,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ], // Añade esta línea
                                        //maxLength: 9,
                                        decoration: InputDecoration(
                                            labelText: 'Teléfono',
                                            hintText: 'Ingrese su teléfono',
                                            isDense: true,
                                            labelStyle: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 1, 55, 99),
                                            ),
                                            hintStyle: TextStyle(
                                              fontSize: 13.0,
                                              color: Colors.grey,
                                            )),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'El campo es obligatorio';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      TextFormField(
                                        controller: _email,
                                        decoration: InputDecoration(
                                          labelText: 'Email',
                                          hintText: 'Ingrese su email',
                                          isDense: true,
                                          labelStyle: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Color.fromARGB(255, 1, 55, 99),
                                          ),
                                          hintStyle: TextStyle(
                                            fontSize: 13.0,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      TextFormField(
                                        controller: _distrito,
                                        decoration: InputDecoration(
                                          labelText: 'Distrito',
                                          hintText: 'Ingrese su dirección',
                                          isDense: true,
                                          labelStyle: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Color.fromARGB(255, 1, 55, 99),
                                          ),
                                          hintStyle: TextStyle(
                                            fontSize: 13.0,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'El campo es obligatorio';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      TextFormField(
                                        controller: _ubicacion,
                                        decoration: InputDecoration(
                                            labelText: 'Ubicación(Lat:Long)',
                                            hintText: 'Ingrese su ubicación',
                                            isDense: true,
                                            labelStyle: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 1, 55, 99),
                                            ),
                                            hintStyle: TextStyle(
                                              fontSize: 13.0,
                                              color: Colors.grey,
                                            )),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'El nombre es obligatorio';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      TextFormField(
                                        controller: _ruc,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ], // Añade esta línea
                                        maxLength: 11,
                                        decoration: InputDecoration(
                                            labelText: 'RUC',
                                            hintText: 'Ingrese su RUC',
                                            isDense: true,
                                            labelStyle: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 1, 55, 99),
                                            ),
                                            hintStyle: TextStyle(
                                              fontSize: 13.0,
                                              color: Colors.grey,
                                            )),
                                      ),
                                      const SizedBox(
                                        height: 50,
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      width: 20,
                    ),

                    // PRODUCTOS

                    Container(
                      //color:Colors.red,

                      height: 600,
                      width: MediaQuery.of(context).size.width <= 1580
                          ? 420
                          : 500, // //420,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            child: const Text(
                              "Lista de Productos y Promociones",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          //listview
                          Container(
                            padding: const EdgeInsets.all(10),
                            height: 535,
                            width: MediaQuery.of(context).size.width <= 1580
                                ? 420
                                : 500,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey),
                            child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: listElementos.length,
                                itemBuilder: ((context, index) {
                                  dynamic elementoActual = listElementos[index];
                                  if (elementoActual is Producto) {
                                    // Producto
                                    Producto producto = elementoActual;

                                    // CONTENEDOR PRINCIPAL

                                    return Container(
                                      margin: const EdgeInsets.only(top: 10),
                                      padding: const EdgeInsets.all(10),
                                      height: 200,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: const Color.fromARGB(
                                            255, 58, 75, 108),
                                      ),
                                      child: Row(
                                        children: [
                                          // IMAGENES DE PRODUCTO
                                          Container(
                                            height: 150,
                                            width: MediaQuery.of(context)
                                                        .size
                                                        .width <=
                                                    1580
                                                ? 90
                                                : 150,
                                            decoration: BoxDecoration(
                                                // color: Colors.grey,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        producto.foto))),
                                          ),

                                          // DESCRIPCIÓN DE PRODUCTO

                                          Container(
                                              margin: const EdgeInsets.only(
                                                  left: 20),
                                              height: 180,
                                              width: MediaQuery.of(context)
                                                          .size
                                                          .width <=
                                                      1580
                                                  ? 90
                                                  : 150,
                                              decoration: BoxDecoration(
                                                // color: Colors.grey,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "Presentación:${producto.nombre}",
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    "${producto.descripcion}",
                                                    style: const TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    "Precio: S/.${producto.precio}",
                                                    style: const TextStyle(
                                                        fontSize: 24,
                                                        color: Color.fromARGB(
                                                            255,
                                                            100,
                                                            237,
                                                            105)),
                                                  ),
                                                ],
                                              )),

                                          // ENTRADAS NUMÉRICAS

                                          Container(
                                            padding: const EdgeInsets.all(15),
                                            margin:
                                                const EdgeInsets.only(left: 20),
                                            height: 180,
                                            width: MediaQuery.of(context)
                                                        .size
                                                        .width <=
                                                    1580
                                                ? 150
                                                : 250,
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                // CANTIDAD
                                                TextFormField(
                                                  keyboardType:
                                                      const TextInputType
                                                          .numberWithOptions(
                                                          decimal: true),
                                                  decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor: const Color
                                                        .fromARGB(255, 223, 225,
                                                        226), // Cambia este color según tus preferencias

                                                    hintText: 'Cantidad',
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    hintStyle: const TextStyle(
                                                        fontSize: 12),
                                                  ),
                                                  style: const TextStyle(
                                                      fontSize: 12),
                                                ),

                                                // PRECIO

                                                TextFormField(
                                                  keyboardType:
                                                      const TextInputType
                                                          .numberWithOptions(
                                                          decimal: true),
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .allow(RegExp(
                                                            r'^\d+\.?\d{0,2}')),
                                                  ],
                                                  decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor: const Color
                                                        .fromARGB(255, 223, 225,
                                                        226), // Cambia este color según tus preferencias

                                                    hintText: 'S/. Descuento',
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    hintStyle: const TextStyle(
                                                        fontSize: 12),
                                                  ),
                                                  style: const TextStyle(
                                                      fontSize: 12),
                                                ),

                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      showModalBottomSheet(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return Container(
                                                            height: 280,
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(16.0),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                const Text(
                                                                  'Autorizado por:',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            3,
                                                                            64,
                                                                            113),
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    height: 10),
                                                                const TextField(
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            1,
                                                                            41,
                                                                            75),
                                                                  ),
                                                                  decoration:
                                                                      const InputDecoration(
                                                                    filled:
                                                                        true,
                                                                    fillColor:
                                                                        Colors
                                                                            .white,
                                                                    labelText:
                                                                        "Nombre:",
                                                                    labelStyle:
                                                                        TextStyle(
                                                                      color: Color
                                                                          .fromARGB(
                                                                              255,
                                                                              0,
                                                                              48,
                                                                              87),
                                                                      fontSize:
                                                                          13,
                                                                    ),
                                                                  ),
                                                                ),
                                                                TextField(
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            1,
                                                                            41,
                                                                            75),
                                                                  ),
                                                                  decoration:
                                                                      const InputDecoration(
                                                                    filled:
                                                                        true,
                                                                    fillColor:
                                                                        Colors
                                                                            .white,
                                                                    labelText:
                                                                        "Cargo:",
                                                                    labelStyle:
                                                                        TextStyle(
                                                                      color: Color
                                                                          .fromARGB(
                                                                              255,
                                                                              0,
                                                                              48,
                                                                              87),
                                                                      fontSize:
                                                                          13,
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    height: 10),
                                                                ElevatedButton(
                                                                  style: ButtonStyle(
                                                                      backgroundColor: MaterialStateProperty.all(const Color
                                                                          .fromARGB(
                                                                          255,
                                                                          1,
                                                                          62,
                                                                          111))),
                                                                  onPressed:
                                                                      () {
                                                                    print(
                                                                        "ubi añadidda");
                                                                    // Aquí puedes manejar la lógica para agregar la ubicación
                                                                    //String nuevaUbicacion = ubicacionController.text;
                                                                    // ... lógica para agregar la ubicación ...
                                                                    // Cerrar el modal después de agregar la ubicación
                                                                    /* Navigator.pop(
                                                              context);*/
                                                                  },
                                                                  child:
                                                                      const Row(
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .account_box_outlined,
                                                                        color: Colors
                                                                            .blue,
                                                                        size:
                                                                            25,
                                                                      ),
                                                                      Text(
                                                                        ' Confirmar',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                20,
                                                                            fontWeight: FontWeight
                                                                                .w400,
                                                                            color: Color.fromARGB(
                                                                                255,
                                                                                77,
                                                                                231,
                                                                                82)),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                    child: Text("Confirmar?"))
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  
                                  } else if (elementoActual is Promo) {
                                    // Promos
                                    Promo promo = elementoActual;

                                    // CONTENEDOR PRINCIPAL
                                    return Container(
                                      margin: const EdgeInsets.only(top: 10),
                                      padding: const EdgeInsets.all(10),
                                      height: 200,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: const Color.fromARGB(
                                            255, 58, 75, 108),
                                      ),
                                      child: Row(
                                        children: [
                                          // IMAGENES DE PRODUCTO
                                          Container(
                                            height: 150,
                                            width: MediaQuery.of(context)
                                                        .size
                                                        .width <=
                                                    1580
                                                ? 90
                                                : 150,
                                            decoration: BoxDecoration(
                                                // color: Colors.grey,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        promo.foto))),
                                          ),

                                          // DESCRIPCIÓN DE PRODUCTO

                                          Container(
                                              margin: const EdgeInsets.only(
                                                  left: 20),
                                              height: 180,
                                              width: MediaQuery.of(context)
                                                          .size
                                                          .width <=
                                                      1580
                                                  ? 90
                                                  : 150,
                                              decoration: BoxDecoration(
                                                // color: Colors.grey,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "Presentación:${promo.nombre}",
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    "${promo.descripcion}",
                                                    style: const TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    "Precio: S/.${promo.precio}",
                                                    style: const TextStyle(
                                                        fontSize: 24,
                                                        color: Color.fromARGB(
                                                            255,
                                                            100,
                                                            237,
                                                            105)),
                                                  ),
                                                ],
                                              )),

                                          // ENTRADAS NUMÉRICAS

                                          Container(
                                            padding: const EdgeInsets.all(15),
                                            margin:
                                                const EdgeInsets.only(left: 20),
                                            height: 180,
                                            width: MediaQuery.of(context)
                                                        .size
                                                        .width <=
                                                    1580
                                                ? 150
                                                : 250,
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                // CANTIDAD
                                                TextFormField(
                                                  keyboardType:
                                                      const TextInputType
                                                          .numberWithOptions(
                                                          decimal: true),
                                                  decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor: const Color
                                                        .fromARGB(255, 223, 225,
                                                        226), // Cambia este color según tus preferencias

                                                    hintText: 'Cantidad',
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    hintStyle: const TextStyle(
                                                        fontSize: 12),
                                                  ),
                                                  onChanged: (value) {
                                                    print("valor detectado: $value");
                                                    // SETEAR DE LA LISTA MIXTA(PROD Y PROMO)
                                                    listElementos[index].cantidad =value;
                                                  },
                                                  style: const TextStyle(
                                                      fontSize: 12),
                                                ),

                                                // PRECIO

                                                TextFormField(
                                                  keyboardType:
                                                      const TextInputType
                                                          .numberWithOptions(
                                                          decimal: true),
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .allow(RegExp(
                                                            r'^\d+\.?\d{0,2}')),
                                                  ],
                                                  decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor: const Color
                                                        .fromARGB(255, 223, 225,
                                                        226), // Cambia este color según tus preferencias

                                                    hintText: 'S/. Descuento',
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    hintStyle: const TextStyle(
                                                        fontSize: 12),
                                                  ),
                                                  onChanged: (value) {
                                                    print("valor detectado: $value");
                                                    // SETEAR DE LA LISTA MIXTA(PROD Y PROMO)
                                                    listElementos[index].descuento =value;
                                                  },
                                                  style: const TextStyle(
                                                      fontSize: 12),
                                                ),

                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      showModalBottomSheet(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return Container(
                                                            height: 280,
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(16.0),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                const Text(
                                                                  'Autorizado por:',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            3,
                                                                            64,
                                                                            113),
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    height: 10),
                                                                const TextField(
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            1,
                                                                            41,
                                                                            75),
                                                                  ),
                                                                  decoration:
                                                                      const InputDecoration(
                                                                    filled:
                                                                        true,
                                                                    fillColor:
                                                                        Colors
                                                                            .white,
                                                                    labelText:
                                                                        "Nombre:",
                                                                    labelStyle:
                                                                        TextStyle(
                                                                      color: Color
                                                                          .fromARGB(
                                                                              255,
                                                                              0,
                                                                              48,
                                                                              87),
                                                                      fontSize:
                                                                          13,
                                                                    ),
                                                                  ),
                                                                ),
                                                                TextField(
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            1,
                                                                            41,
                                                                            75),
                                                                  ),
                                                                  decoration:
                                                                      const InputDecoration(
                                                                    filled:
                                                                        true,
                                                                    fillColor:
                                                                        Colors
                                                                            .white,
                                                                    labelText:
                                                                        "Cargo:",
                                                                    labelStyle:
                                                                        TextStyle(
                                                                      color: Color
                                                                          .fromARGB(
                                                                              255,
                                                                              0,
                                                                              48,
                                                                              87),
                                                                      fontSize:
                                                                          13,
                                                                    ),
                                                                  ),
                                                                  onChanged: (value) {
                                                                    
                                                                  },
                                                                ),
                                                                const SizedBox(
                                                                    height: 10),
                                                                ElevatedButton(
                                                                  style: ButtonStyle(
                                                                      backgroundColor: MaterialStateProperty.all(const Color
                                                                          .fromARGB(
                                                                          255,
                                                                          1,
                                                                          62,
                                                                          111))),
                                                                  onPressed:
                                                                      () {
                                                                    print(
                                                                        "ubi añadidda");
                                                                    // Aquí puedes manejar la lógica para agregar la ubicación
                                                                    //String nuevaUbicacion = ubicacionController.text;
                                                                    // ... lógica para agregar la ubicación ...
                                                                    // Cerrar el modal después de agregar la ubicación
                                                                    /* Navigator.pop(
                                                              context);*/
                                                                  },
                                                                  child:
                                                                      const Row(
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .account_box_outlined,
                                                                        color: Colors
                                                                            .blue,
                                                                        size:
                                                                            25,
                                                                      ),
                                                                      Text(
                                                                        ' Confirmar',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                20,
                                                                            fontWeight: FontWeight
                                                                                .w400,
                                                                            color: Color.fromARGB(
                                                                                255,
                                                                                77,
                                                                                231,
                                                                                82)),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                    child: Text("Confirmar?"))
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );

                                  }
                                  else{
                                    return Container(
                                      child: Text("NO PRODUCTS"),
                                    );
                                  }

                                  // Producto producto = listProducts[index];
                                })),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),

                    // UBICACIÓN

                    Container(
                      height: 600,

                      //color:Colors.red,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            child: Text(
                              "Ubicación",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Container(
                              padding: const EdgeInsets.all(10),
                              width: 500,
                              height: 530,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey),
                              // padding: const EdgeInsets.all(9),

                              //padding: const EdgeInsets.all(20),
                              child: OpenStreetMapSearchAndPick(
                                buttonTextStyle: TextStyle(fontSize: 12),
                                buttonColor:
                                    const Color.fromARGB(255, 40, 69, 92),
                                buttonText: 'Obtener coordenadas',
                                onPicked: (pickedData) {
                                  setState(() {
                                    //direccion = pickedData.addressName;
                                    String road =
                                        pickedData.address['road'] ?? '';
                                    String neighbourhood =
                                        pickedData.address['neighbourhood'] ??
                                            '';
                                    String city =
                                        pickedData.address['city'] ?? '';
                                    var latitude = pickedData.latLong.latitude;
                                    var longitude =
                                        pickedData.latLong.longitude;

                                    _direccion.text = '$road $neighbourhood';
                                    _distrito.text = '$city';
                                    _ubicacion.text = '$latitude $longitude';
                                  });
                                  print(pickedData.latLong.latitude);
                                  print(pickedData.latLong.longitude);
                                  print(pickedData.address);
                                  print(pickedData.addressName);
                                  print("-----------------");
                                  print(pickedData.address['city']);
                                  print("---OBJETO DIRECCIÓN---");
                                  print(pickedData.address.values);
                                },
                              )),
                        ],
                      ),
                    ),

                    // BOTONES REGISTROS
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      height: 600,
                      //color:Colors.cyan,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              height: 200,
                              width: 200,
                              child: ElevatedButton(
                                onPressed: () => showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title:
                                        const Text('Vas a registrar el pedido'),
                                    content: const Text('¿Estas segur@?'),
                                    actions: <Widget>[
                                      ElevatedButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'Cancelar'),
                                        child: const Text('Cancelar'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            print("datos personales");
                                            print("$_nombres , $_apellidos");
                                            await createNR(
                                                _nombres.text,
                                                _apellidos.text,
                                                _direccion.text,
                                                _telefono.text,
                                                _email.text,
                                                _distrito.text,
                                                _ubicacion.text,
                                                _ruc.text);
                                            Navigator.pop(context, 'SI');
                                          }
                                        },
                                        child: const Text('SI'),
                                      ),
                                    ],
                                  ),
                                ),
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        const Color.fromARGB(
                                            255, 35, 74, 106))),
                                child: const Text(
                                  '¿ Registrar ?',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25),
                                ),
                              )),
                          Container(
                            margin: const EdgeInsets.only(top: 70),
                            height: 320,
                            width: 200,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(20),
                                image: const DecorationImage(
                                    image: AssetImage(
                                        'lib/imagenes/botellasuper.jpg'),
                                    fit: BoxFit.cover)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              /**/
            ],
          ),
        ),
      )),
    );
  }
}
