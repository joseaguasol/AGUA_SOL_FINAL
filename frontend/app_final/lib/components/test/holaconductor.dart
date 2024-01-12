import 'package:app_final/components/test/camara.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HolaConductor extends StatefulWidget {
  const HolaConductor({super.key});

  @override
  State<HolaConductor> createState() => _HolaConductorState();
}

class _HolaConductorState extends State<HolaConductor> {
  @override
  Widget build(BuildContext context) {
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
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: Text(
                        "Hola Julio !",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: const Row(
                        children: [
                          Text(
                            "Bienvenid@ a",
                            style: TextStyle(fontSize: 25),
                          ),
                          Text(
                              "Agua Sol",
                              style: TextStyle(
                                  color: const Color.fromARGB(255, 3, 42, 74),
                                  fontFamily: 'Pacifico',
                                  fontSize: 30),
                            )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 18),
                      child: Row(
                        children: [
                          Text(
                            "Valoro tu esfuerzo!",
                            
                            style: TextStyle(fontSize: 23,
                            color: Color.fromARGB(255, 1, 54, 98),
                            fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Container(
                              height: 60,
                              width: 60,
                              child: Lottie.asset('lib/imagenes/brazo.json'))
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      height: 85,
                     // color: Colors.grey,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 100,
                            width: 210,
                            //color:Colors.green,
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
                                    " 10 ",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 0, 53, 95),
                                        fontSize: 30),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  //color:Colors.blue,
                                  child: Text(
                                    "Pedidos \nProgramados",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 20),
                            // width: 100,
                            //height: 80,
                            //color:Colors.cyan,
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
                                  label: Text(" 3 ",
                                      style: TextStyle(fontSize: 20)),
                                ),
                                Text("¿Express?",
                                    style: TextStyle(fontSize: 15))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      //color: Colors.grey,
                      height: 40,
                      child: Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                child: Text("Aquí está tus pedidos!",style:TextStyle(fontSize: 20),)),
                            const SizedBox(
                              width: 20,
                            ),
                            
                            
                          ]),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                     // color: Colors.grey,
                      height: 300,
                      child:
                       Row(children: [
                        Container(
                          width: 140,
                          height: 300,
                         // color: Colors.red,
                          child: ListView.builder(
                            itemCount:8, // Puedes establecer el itemCount general si es necesario
                            itemBuilder: (context, index) {
                              // Puedes personalizar itemCount para cada widget
                              int itemCountElevated = 5;
                              int itemCountText = 2;

                              return Column(
                                children: [
                                  if (index < itemCountElevated)
                                    Container(
                                      height: 60,
                                      margin: const EdgeInsets.only(top: 10),
                                      child: ElevatedButton(
                                        onPressed: () {},
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Color.fromARGB(255, 3, 74, 132)),
                                        ),
                                        child: Row(
                                          children: [
                                            Text("Pedido ",
                                                style:
                                                    TextStyle(color: Colors.white)),
                                            Icon(Icons.photo_camera,color: Colors.white,)
                                          ],
                                        ),
                                      ),
                                    ),
                                  // Ajusta el espacio entre los botones
                                //  const SizedBox(height: 10,),
                                  if (index < itemCountText)
                                    Container(
                                      height: 60,
                                      margin: const EdgeInsets.only(top: 10),
                                      child: ElevatedButton(
                                        onPressed: () {},
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                 Color.fromARGB(255, 231, 25, 22)),
                                        ),
                                        child: Row(
                                          children: [
                                            Text("Express ",
                                                style:
                                                    TextStyle(color: Colors.white)),
                                            Icon(Icons.photo_camera,color:Colors.white)
                                          ],
                                        ),
                                      ),
                                    ),
                                    //const SizedBox(height: 10,),
                                ],
                              );
                            },
                          ),
                        ),


                        const SizedBox(
                          width: 20,
                        ),
                        Container(width: 250, height: 300, color: Color.fromARGB(255, 245, 210, 149)),
                      ]),
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: Row(
                       // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              Container(child: Text("Completaste ",style: TextStyle(fontSize: 30),)),
                                Container(child: Text("Todo ? ",style: TextStyle(fontSize: 30),)),
                            ],
                          ),
                         

                          Container(
                            width: 100,
                            height: 60,
                            child: ElevatedButton(onPressed: (){
                              Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Camara()),
                          );
                            },
                             style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 2, 86, 155))
                             ),
                             child: Text("Si !",style:TextStyle(fontSize:20,color:Colors.white),)),
                          )
                        ],
                      ),
                    ),
                  ]))),
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
    );
  }
}
