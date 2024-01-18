import 'package:app_final/components/test/camara.dart';
import 'package:app_final/components/test/pedido.dart';
import 'package:flutter/material.dart';
//import 'package:lottie/lottie.dart';

class Ruta {
  final List<Pedido> pedidos;
  final int kilometraje;
  const Ruta({
    Key? key,
    required this.pedidos,
    required this.kilometraje,
  });
}

class HolaConductor extends StatefulWidget {
  const HolaConductor({super.key});
  @override
  State<HolaConductor> createState() => _HolaConductorState();
}

class _HolaConductorState extends State<HolaConductor> {
  String apiRutas = 'http://10.0.2.2:8004/api/promocion';
  int numerodePedidosNormales = 13;
  int numerodePedidosExpress = 3;

  @override
  void initState() {
    super.initState();
    //getProducts();
  }

  @override
  Widget build(BuildContext context) {
    int numeroTotalPedidos = numerodePedidosExpress + numerodePedidosNormales;
    int pedidoActual = 1;
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
                    /*Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: Text(
                        "Hola Julio !",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),*/
                    /*Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: const Row(
                        children: [
                          Text(
                            "Bienvenid@ a ",
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            "Agua Sol",
                            style: TextStyle(
                                color: const Color.fromARGB(255, 3, 42, 74),
                                fontFamily: 'Pacifico',
                                fontSize: 25),
                          )
                        ],
                      ),
                    ),*/
                    /*Container(
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
                    ),*/

                    //este container tiene los pedidos programas y express
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      height: 75,
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
                                    " ${numerodePedidosNormales} ",
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 0, 53, 95),
                                        fontSize: 20),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  //color:Colors.blue,
                                  child: Text(
                                    "Pedidos \nProgramados",
                                    style: TextStyle(fontSize: 15),
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
                                  label: Text(" ${numerodePedidosExpress} ",
                                      style: TextStyle(fontSize: 20)),
                                ),
                                Text("Express", style: TextStyle(fontSize: 15))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      //color: Colors.grey,
                      height: 90,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                                child: Text(
                              "Pedido $pedidoActual/$numeroTotalPedidos ",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            )),
                            Container(
                                child: Text(
                              "Productos: ..... de la API",
                              style: TextStyle(fontSize: 14),
                            )),
                            Container(
                                child: Text(
                              "Cliente: ..... de la API",
                              style: TextStyle(fontSize: 14),
                            )),
                            Container(
                                child: Text(
                              "Monto: ..... de la API",
                              style: TextStyle(fontSize: 14),
                            )),
                          ]),
                    ),
                    SizedBox(height: 10),

                    Container(
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      color: Colors.green,
                      height: 200,
                      width: 500,
                      child: Text("Aqui se corre el mapa"),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    Container(
                        margin: const EdgeInsets.only(left: 20),
                        child: Text(
                          "Tipo de pago:",
                          style: TextStyle(fontSize: 18),
                        )),

                    const SizedBox(
                      height: 20,
                    ),

                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 150,
                            height: 40,
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Camara()),
                                  );
                                },
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Color.fromARGB(255, 2, 86, 155))),
                                child: Text(
                                  "Yape/Pin",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                )),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Container(
                            width: 150,
                            height: 40,
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Camara()),
                                  );
                                },
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Color.fromARGB(255, 2, 86, 155))),
                                child: Text(
                                  "Efectivo",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                )),
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
                          "Problemas al entregar el pedido",
                          style: TextStyle(fontSize: 18),
                        )),

                    const SizedBox(
                      height: 20,
                    ),

                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      width: 250,
                      height: 40,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Camara()),
                            );
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Color.fromARGB(255, 2, 86, 155))),
                          child: Text(
                            "No pude entregar el pedido",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          )),
                    ),
                  ]))),
    );
  }
}
