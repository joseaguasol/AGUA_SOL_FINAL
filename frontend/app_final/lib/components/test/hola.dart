import 'package:flutter/material.dart';

class Hola extends StatefulWidget {
  const Hola({super.key});

  @override
  State<Hola> createState() => _HolaState();
}

class _HolaState extends State<Hola> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final TabController _tabController = TabController(length: 2, vsync: this);

    return Scaffold(
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
                            const Icon(
                              Icons.menu,
                              color: Colors.black,
                              size: 30,
                            ),
                            Container(
                              child: ClipRRect(
                                child: Image.asset('lib/imagenes/chica.jpg'),
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
                        margin: const EdgeInsets.only(left: 20),
                        child: Text(
                          "Disfruta!",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 30,
                              color: Color.fromARGB(255, 3, 34, 60)),
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
                                scrollDirection: Axis.horizontal,
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    height: 300,
                                    width: 300,
                                    decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 75, 108, 134),
                                        borderRadius: BorderRadius.circular(50),
                                        image: const DecorationImage(
                                          image: AssetImage(
                                              'lib/imagenes/bodegon.png'),
                                          fit: BoxFit.cover,
                                        )),
                                  );
                                }),
                            ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    height: 300,
                                    width: 300,
                                    decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 75, 108, 134),
                                        borderRadius: BorderRadius.circular(50),
                                        image: const DecorationImage(
                                          image: AssetImage(
                                              'lib/imagenes/BIDON7.png'),
                                          fit: BoxFit.cover,
                                        )),
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
                              children:[
                                Container(
                                  margin: const EdgeInsets.only(right: 90),
                                    child: const Text(
                                  "Mejora!",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w300,
                                      color: Color.fromARGB(255, 2, 46, 83)),
                                )),
                                Container(
                                  margin: const EdgeInsets.only(right:80),
                                  //color:Colors.grey,
                                    child:const Text(
                                  "Tú vida",
                                  style: TextStyle(
                                      fontSize: 30,
                                      color: Color.fromARGB(255, 3, 31, 54)),
                                )),
                              ],
                            ),
                            const Text(
                              "Tranquilo",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w300,
                                  color: Color.fromARGB(255, 6, 46, 78)),
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
                              onPressed: () {},
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    const Color.fromARGB(255, 0, 59, 108)),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.attach_money_outlined, // Reemplaza con el icono que desees
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
                              onPressed: () {},
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
