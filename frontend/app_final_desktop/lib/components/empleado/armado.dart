//import 'package:slidable_button/slidable_button.dart';
import 'package:lottie/lottie.dart';
//import 'package:flutter/services.dart';
//import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

import 'package:flutter/material.dart';

class Armado extends StatefulWidget {
  const Armado({super.key});

  @override
  State<Armado> createState() => _ArmadoState();
}

class _ArmadoState extends State<Armado> {
  var direccion = '';
  final TextEditingController _searchController = TextEditingController();
  //final TextEditingController _distrito = TextEditingController();
  //final TextEditingController _ubicacion = TextEditingController();
  List<String> dataList = [
    'Sandia Manzanita',
    'Banana',
    'Cereza',
    'Uva',
    'asdf',
    'asdfa',
    'jjjj',
    'ddd'
  ];

  @override
  Widget build(BuildContext context) {
    List<String> filteredList = dataList
        .where((item) =>
            item.toLowerCase().contains(_searchController.text.toLowerCase()))
        .toList();
    
    return Scaffold(
        // drawer: Drawer(),
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Row(children: [
                  Container(
                    color: Color.fromARGB(255, 1, 61, 111),
                    child: Column(
                      children: [
                        Container(
                            margin: const EdgeInsets.only(
                                top: 35, left: 15, right: 15),
                            child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.call_to_action_outlined,
                                  color: Colors.white,
                                  size: 50,
                                ))),
                        Container(
                            margin: const EdgeInsets.only(
                                top: 35, left: 15, right: 15),
                            child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.content_paste_search,
                                  color: Colors.white,
                                  size: 50,
                                ))),
                      ],
                    ),
                  ),
                 Expanded(
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${MediaQuery.of(context).size.width}"),
                          
                          Text("${MediaQuery.of(context).size.height}"),
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
                                        itemCount: filteredList.length,
                                        itemBuilder: (context, index) {
                                          return ListTile(
                                            title: Text(filteredList[index]),
                                            /*trailing: Row(*/
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
                                        itemCount: filteredList.length,
                                        itemBuilder: (context, index) {
                                          return ListTile(
                                            title: Text(
                                              filteredList[index],
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            /*trailing: Row(*/
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
                                        itemCount: filteredList.length,
                                        itemBuilder: (context, index) {
                                          return ListTile(
                                            title: Text(
                                              filteredList[index],
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            /*trailing: Row(*/
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
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


                         
                        ],
                      ),
                    ),
                  
                ])))
      );
  }
}
