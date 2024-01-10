import 'package:app_final/components/test/hola.dart';
import 'package:app_final/components/test/pedido.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:lottie/lottie.dart';


class Producto {
  
  final String nombre;
  final double precio;
  final String descripcion;
  
  final String foto;
  //String estado;

  //bool seleccionado; // Nuevo campo para rastrear la selección

  Producto(
      {
      required this.nombre,
      required this.precio,
      required this.descripcion,
      
      required this.foto
      });
      //this.seleccionado = false});
}

class Productos extends StatefulWidget {
  const Productos({super.key});

  @override
  State<Productos> createState() => _ProductosState();
}

class _ProductosState extends State<Productos> {

  String apiProducts = 'http://10.0.2.2:8004/api/products';
  List<Producto>listProducto = [];

  @override
  void initState(){
    super.initState();
    getProducts();
  }

  Future<dynamic>getProducts() async{
    print("-------get products---------");
    var res = await http.get(Uri.parse(apiProducts),
    headers: {"Content-type":"application/json"},
    );
    try {
      if (res.statusCode == 200) {
        var data = json.decode(res.body);
        List<Producto> tempProducto = data.map<Producto>((mapa) {
          return Producto(
              
              nombre: mapa['nombre'],
              precio:mapa['precio'].toDouble(),
              descripcion: mapa['descripcion'],
              foto:
                  'http://10.0.2.2:8004/images/${mapa['foto'].replaceAll(r'\\', '/')}'
          );
        }).toList();

        setState(() {
          listProducto = tempProducto;
          //conductores = tempConductor;
        });
        print("....lista productos");
        print(listProducto);
      }
    } catch (e) {
      print('Error en la solicitud: $e');
      throw Exception('Error en la solicitud: $e');
    }


  }

  @override
  Widget build(BuildContext context) {
    //final TabController _tabController = TabController(length: 2, vsync: this);

    return Scaffold(
    //  backgroundColor:Color.fromARGB(255, 65, 68, 67),
        appBar: AppBar(
          title: Text(""),
        ),
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 30, left: 20),
                     // color:Colors.grey,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Container(
                                child: const Text(
                                  "Disfruta!",
                                  style: TextStyle(
                                      color:
                                          const Color.fromARGB(255, 1, 42, 76),
                                      fontWeight: FontWeight.w200,
                                      fontSize: 45),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 20),
                                //color:Colors.grey,
                                //height:100,
                                child:const Text(
                                  "Nuestros Productos",
                                  style: TextStyle(
                                      color:
                                          const Color.fromARGB(255, 1, 45, 80),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 20),
                                //color:Colors.grey,
                                //height:100,
                                child: const Text(
                                  "están hechos para ti!",
                                  style: TextStyle(
                                      color: const Color.fromARGB(255, 1, 46, 84),
                                      fontSize: 19,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 60),
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                              color:const Color.fromARGB(255, 129, 120, 120),
                              borderRadius: BorderRadius.circular(20)
                            ),
                            //color: Colors.grey,
                            child: Image.asset('lib/imagenes/disfruta.png'),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 25,),
                    Container(
                      margin: const EdgeInsets.only(left: 20,right: 20),
                      padding:const EdgeInsets.all(6),
                      height: 400,
                      
                      decoration: BoxDecoration(
                      //  color:Color.fromARGB(255, 246, 197, 255),
                        borderRadius: BorderRadius.circular(15),
                       border: Border.all(
                          color: const Color.fromARGB(255, 21, 168, 14),
                               // color:Color.fromARGB(255, 68, 102, 132),
                                width: 3.0
                         )
                      ),

                      //
                      
                      child:ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: listProducto.length,
                        itemBuilder: (context,index){
                          Producto producto = listProducto[index];
                          return Container(
                            margin: const EdgeInsets.only(left: 10),
                            height: 100,
                            width: 295,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color:Color.fromARGB(255, 75, 108, 134),
                           // color: Color.fromARGB(255, 165, 165, 165)
                              
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin:  const EdgeInsets.only(left: 20) ,
                                  height: 250,
                                  width: 160,
                                  decoration:  BoxDecoration(
                                  //  color: Color.fromARGB(255, 217, 215, 215),
                                    image: DecorationImage(
                                      image: NetworkImage(producto.foto),
                                      fit: BoxFit.scaleDown
                                    )
                                  ),
                                ),
                                const SizedBox(height: 10,),
                                Container(
                                  //color:Colors.grey,
                                  margin: const EdgeInsets.only(left: 20),
                                  child: Column(
                                    //crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                       Text('Presentación ${producto.nombre}',
                                      style:const TextStyle(fontSize: 15,color:Color.fromARGB(255, 255, 255, 255)),),
                                      Text("S/.${producto.precio}  ${producto.descripcion} ",
                                      style: const TextStyle(fontSize:20,color: Color.fromARGB(255, 248, 249, 250)),),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                       // mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                        IconButton(onPressed:(){},
                                        iconSize: 30,
                                        color: const Color.fromARGB(255, 0, 57, 103),
                                         icon:const Icon(Icons.remove_circle_outline,color: Colors.amber,),),
                                        const Text("10",
                                        style: TextStyle(color: Color.fromARGB(255, 236, 237, 238),
                                        fontSize:27),),
                                        IconButton(onPressed: (){

                                        },
                                        iconSize: 30,
                                        color: const Color.fromARGB(255, 0, 49, 89),
                                         icon:const Icon(Icons.add_circle_outline,color: Colors.purpleAccent,),),
                                      ],),
                                    ],
                                  ),
                                ),
                                Container(),
                              ],
                            ),
                            
                          );
                        }
                        ) ,
                    ),

                    const SizedBox(height: 20,),
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      child:const Text("Su importe es de:",
                      style: TextStyle(fontWeight: FontWeight.w300,fontSize: 25,color:Color.fromARGB(255, 1, 25, 44)),),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: const Text("S/.200.00",
                      style: TextStyle(fontWeight: FontWeight.w300,fontSize: 30,color:Color.fromARGB(255, 4, 62, 107)),),
                    ),
                    const SizedBox(height: 10,),
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: const Text("¿Gustas ordenar?",
                      style: TextStyle(fontWeight: FontWeight.w400,fontSize: 30,color:const Color.fromARGB(255, 1, 32, 56)),),
                    ),
                    //const SizedBox(height: 20,),
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      width: 200,
                      height: 100,
                      //color:Colors.grey,
                      child:Row(
                        children: [
                          ElevatedButton(onPressed: (){
                            print("si");
                            Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Pedido()),
                    );
                          },
                           style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 3, 92, 165))
                           ),
                           child: const Text("Sí",style: TextStyle(fontWeight: FontWeight.w300,fontSize: 25,color: Colors.white),)),
                          Container(
                            height: 100,
                            width: 100,
                            child: Lottie.asset('lib/imagenes/cajita.json'))
                        ],
                      ),
                    ),

                  ],
                ))));
  }
}
