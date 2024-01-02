import 'package:slidable_button/slidable_button.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/services.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

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




  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      // drawer: Drawer(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              NavigationRail(
                backgroundColor: Color.fromRGBO(2, 84, 151, 1),
              //extended: true,
                destinations:  const[
                  NavigationRailDestination(
                    icon: Icon(Icons.water_drop,
                     size: 50,
                     color: Colors.white),
                    label: Text(
                      'Inicio',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                  //const SizedBox(height: 2,),
                  NavigationRailDestination(
                    icon: Icon(Icons.assistant_direction_outlined,
                    size: 50,
                        color: Colors.white),
                    label: Text(
                      'Rutear',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.sensor_occupied,
                    size: 50,
                     color: Colors.white),
                    label: Text(
                      'Supervisión',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.my_library_books, 
                    size: 50,
                    color: Colors.white),
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
              // VerticalDivider(thickness: 10, width: 3),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                                        fontSize: 20,
                                        fontWeight: FontWeight.w200),
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
                                            fontFamily: 'Pacifico',
                                            fontSize: 25),
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
                                image: DecorationImage(
                                    image:
                                        AssetImage('lib/imagenes/chica.jpg'))),
                          ),
                          const SizedBox(
                            width: 150,
                          ),
                          Container(
                            child: Icon(Icons.brightness_5),
                          ),
                          Container(
                            width: 100,
                            child: HorizontalSlidableButton(
                              width: MediaQuery.of(context).size.width / 3,
                              buttonWidth: 50.0,
                              color: Colors.grey,
                              buttonColor: Color.fromARGB(255, 2, 75, 134),
                              dismissible: false,
                              // label: Center(child: Text('Slide Me')),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                              ),
                              onChanged: (position) {
                                setState(() {
                                  if (position == SlidableButtonPosition.end) {
                                    //   result = 'Button is on the right';
                                  } else {
                                    //result = 'Button is on the left';
                                  }
                                });
                              },
                            ),
                          ),
                          Container(
                            child: Icon(Icons.dark_mode_outlined),
                          ),
                          const SizedBox(
                            width: 150,
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: Column(
                              children: [
                                Text(
                                  "Arequipa,2 de enero del 2024",
                                  style: TextStyle(fontSize: 25),
                                ),
                                Text(
                                  "21 ° C",
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
                          Text(
                            "Una Llamada ?",
                            style: TextStyle(
                                color: const Color.fromARGB(255, 2, 68, 121),
                                fontSize: 25,
                                fontWeight: FontWeight.w300),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Container(
                              width: 40,
                              height: 40,
                              child: Lottie.asset('lib/imagenes/call.json'))
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.grey,
                      margin: const EdgeInsets.only(left: 20),
                      child: Column(
                        children: [
                          Text(
                            "Genial! registra los datos aquí",
                            style: TextStyle(
                                fontSize: 25,
                                color: const Color.fromARGB(255, 1, 65, 118)),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 700,
                      //height: MediaQuery.of(context).size.height,
                      margin: const EdgeInsets.only(left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                           // color: Colors.grey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    "Datos Cliente",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                Container(
                                  width: 300,
                                  child: TextField(
                                    style:  TextStyle(
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
                                  width: 300,
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
                                  width: 300,
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
                                  width: 300,
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
                                  width: 300,
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
                                  width: 300,
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
                                  width: 300,
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
                                  width: 300,
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
                                  width: 300,
                                  child: TextField(
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
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Container(
                            height: 700,
                            width: MediaQuery.of(context).size.width / 3,
                            child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: 5,
                                itemBuilder: ((context, index) {
                                  return Container(
                                      margin: const EdgeInsets.only(top: 20),
                                      width: 500,
                                      height: 150,
                                      color: Colors.amber);
                                })),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Container(
                              width: 500,
                              height: 700,
                              child: OpenStreetMapSearchAndPick(
                                buttonTextStyle: TextStyle(fontSize: 12),
                                buttonColor:
                                    const Color.fromARGB(255, 1, 88, 160),
                                buttonText: 'Obtener coordenadas',
                                onPicked: (pickedData) {
                                  setState(() {
                                    //direccion = pickedData.addressName;
                                  String road = pickedData.address['road'] ?? '';
                                  String neighbourhood = pickedData.address['neighbourhood'] ?? '';
                                  String city = pickedData.address['city'] ?? '';
                                  var latitude = pickedData.latLong.latitude;
                                  var longitude = pickedData.latLong.longitude;

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
                      Container(
                        child: Row(
                          children: [
                             ElevatedButton(onPressed: (){},
                             child: Text("Registrar")),
                            ElevatedButton(onPressed: (){},
                             child: Text("Limpiar")),
                          ],
                        ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
