import 'package:app_final_desktop/components/empleado/armado.dart';
import 'dart:convert';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var direccion = '';
  final TextEditingController _direccion = TextEditingController();
  final TextEditingController _distrito = TextEditingController();
  final TextEditingController _ubicacion = TextEditingController();
  late double temperatura = 0.0;
  final now = DateTime.now();
  // Formato para obtener el nombre del mes
  final monthFormat = DateFormat('MMMM');

  String apiClima =
      "https://api.openweathermap.org/data/2.5/weather?q=Arequipa&appid=08607bf479e5f47f5b768154953d10f6";
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

  @override
  void initState() {
    super.initState();
    getTemperature();
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
                                      Armado(),
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
                height: 750,
                //height: MediaQuery.of(context).size.height,
                margin: const EdgeInsets.only(left: 20),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // CLIENTE

                    Container(
                      //color:Colors.green,
                      width: MediaQuery.of(context).size.width <=1580 ? 300 : 400,
                      height: MediaQuery.of(context).size.height <=800 ? 600 : 800,
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
                          const TextField(
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 1, 41, 75),
                              ),
                              decoration:  InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                labelText: "Nombres",
                                labelStyle: TextStyle(
                                  color: Color.fromARGB(255, 0, 48, 87),
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          const SizedBox(
                            height: 20,
                          ),
                          const TextField(
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 1, 41, 75),
                              ),
                              decoration:  InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                labelText: "Nombres",
                                labelStyle: TextStyle(
                                  color: Color.fromARGB(255, 0, 48, 87),
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          const SizedBox(
                            height: 20,
                          ),
                          const TextField(
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 1, 41, 75),
                              ),
                              decoration:  InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                labelText: "Nombres",
                                labelStyle: TextStyle(
                                  color: Color.fromARGB(255, 0, 48, 87),
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          const SizedBox(
                            height: 20,
                          ),
                          const TextField(
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 1, 41, 75),
                              ),
                              decoration:  InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                labelText: "Nombres",
                                labelStyle: TextStyle(
                                  color: Color.fromARGB(255, 0, 48, 87),
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          const SizedBox(
                            height: 20,
                          ),
                          const TextField(
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 1, 41, 75),
                              ),
                              decoration:  InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                labelText: "Nombres",
                                labelStyle: TextStyle(
                                  color: Color.fromARGB(255, 0, 48, 87),
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          const SizedBox(
                            height: 20,
                          ),
                          const TextField(
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 1, 41, 75),
                              ),
                              decoration:  InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                labelText: "Nombres",
                                labelStyle: TextStyle(
                                  color: Color.fromARGB(255, 0, 48, 87),
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          const SizedBox(
                            height: 20,
                          ),
                          const TextField(
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 1, 41, 75),
                              ),
                              decoration:  InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                labelText: "Nombres",
                                labelStyle: TextStyle(
                                  color: Color.fromARGB(255, 0, 48, 87),
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          const SizedBox(
                            height: 20,
                          ),
                          const TextField(
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 1, 41, 75),
                              ),
                              decoration:  InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                labelText: "Nombres",
                                labelStyle: TextStyle(
                                  color: Color.fromARGB(255, 0, 48, 87),
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          const SizedBox(
                            height: 20,
                          ),

                         /* Container(
                            
                            child: const TextField(
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 1, 41, 75),
                              ),
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                labelText: "Nombres",
                                labelStyle: TextStyle(
                                  color: Color.fromARGB(255, 0, 48, 87),
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            
                            child: TextField(
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 1, 41, 75),
                              ),
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                labelText: "Apellidos",
                                labelStyle: TextStyle(
                                  color: Color.fromARGB(255, 0, 48, 87),
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            
                            child: TextField(
                              controller: _direccion,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 1, 41, 75),
                              ),
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                labelText: "Dirección",
                                labelStyle: TextStyle(
                                  color: Color.fromARGB(255, 0, 48, 87),
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            
                            child: TextField(
                              controller: _distrito,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 1, 41, 75),
                              ),
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                labelText: "Distrito",
                                labelStyle: TextStyle(
                                  color: Color.fromARGB(255, 0, 48, 87),
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            
                            child: TextField(
                              controller: _ubicacion,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 1, 41, 75),
                              ),
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                labelText: "Ubicación",
                                labelStyle: TextStyle(
                                  color: Color.fromARGB(255, 0, 48, 87),
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            
                            child: TextField(
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ], // Añade esta línea
                              maxLength: 9,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 1, 41, 75),
                              ),
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                labelText: "+51 Celular",
                                labelStyle: TextStyle(
                                  color: Color.fromARGB(255, 0, 48, 87),
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            
                            child: TextField(
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ], // Añade esta línea
                              maxLength: 11,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 1, 41, 75),
                              ),
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                labelText: "RUC",
                                labelStyle: TextStyle(
                                  color: Color.fromARGB(255, 0, 48, 87),
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            
                            child: TextField(
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 1, 41, 75),
                              ),
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                labelText: "Empresa",
                                labelStyle: TextStyle(
                                  color: Color.fromARGB(255, 0, 48, 87),
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            
                            child: const TextField(
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 1, 41, 75),
                              ),
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                labelText: "E-mail",
                                labelStyle: TextStyle(
                                  color: Color.fromARGB(255, 0, 48, 87),
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          */
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
                      width: MediaQuery.of(context).size.width <=1580 ? 420 : 500,// //420,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            child: Text(
                              "Lista de Productos",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          //listview
                          Container(
                            padding: const EdgeInsets.all(10),
                            height: 550,
                            width: MediaQuery.of(context).size.width <= 1580 ? 420 : 500,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(20)),
                            
                            child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: 5,
                                itemBuilder: ((context, index) {
                                  return Container(
                                    margin: const EdgeInsets.only(top: 20),
                                    padding: const EdgeInsets.all(15),
                                    
                                    height: 190,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Color.fromARGB(255, 58, 75, 108),
                                    ),

                                    child: Row(
                                      children: [
                                        Container(
                                          height: 150,
                                          width: MediaQuery.of(context).size.width <= 1580 ? 90 : 150,
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                        Container(
                                            margin:
                                                const EdgeInsets.only(left: 20),
                                            height: 150,
                                            width: MediaQuery.of(context).size.width <= 1580 ? 90 : 150,
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child:const Text(
                                              "Descripción",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white),
                                            )),
                                        Container(
                                          padding: const EdgeInsets.all(20),
                                          margin:
                                              const EdgeInsets.only(left: 20),
                                          height: 150,
                                          width: MediaQuery.of(context).size.width <= 1580 ? 150 : 250,
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: const Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              TextField(
                                                style:  TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 1, 41, 75),
                                                ),
                                                decoration:
                                                     InputDecoration(
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  labelText: "Cantidad",
                                                  labelStyle: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 0, 48, 87),
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ),
                                              TextField(
                                                style:  TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 1, 41, 75),
                                                ),
                                                decoration:
                                                     InputDecoration(
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  labelText: "S/. Precio",
                                                  labelStyle: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 0, 48, 87),
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // Text("Producto"),
                                      ],
                                    ),
                                  );
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
                              width: 500,
                              height: 530,
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
                                        onPressed: () =>
                                            Navigator.pop(context, 'SI'),
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
