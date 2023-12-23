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
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
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
                      child: Text(
                        "Bienvenid@",
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 18),
                      child: Row(
                        children: [
                          Text(
                            "agradezco tu esfuerzo",
                            style: TextStyle(fontSize: 18),
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
                        height: 100,
                        color: Colors.grey),
                  ]))),


      drawer: Drawer(
                      child: ListView(
                        children: [
                          DrawerHeader(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 2, 68, 122),
                            ),
                            child:const Text(
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
