import 'package:flutter/material.dart';

class Productos extends StatefulWidget {
  const Productos({super.key});

  @override
  State<Productos> createState() => _ProductosState();
}

class _ProductosState extends State<Productos> {
  @override
  Widget build(BuildContext context) {
    //final TabController _tabController = TabController(length: 2, vsync: this);

    return Scaffold(
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 30, left: 20),
                      //color:Colors.grey,
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
                                      color:
                                          const Color.fromARGB(255, 1, 46, 84),
                                      fontSize: 19,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: 200,
                            height: 200,
                            //color: Colors.grey,
                            child: Image.asset('lib/imagenes/disfruta.png'),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 25,),
                    Container(
                      margin: const EdgeInsets.only(left: 20,right: 20),
                      height: 400,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color:Color.fromARGB(255, 42, 105, 153),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                                color:Color.fromARGB(255, 68, 102, 132),
                                width: 3
                              )
                      ),

                      //
                      
                      child:ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: 4,
                        itemBuilder: (context,index){

                          return Container(
                            margin: const EdgeInsets.only(top: 10,bottom: 10),
                            height: 200,
                            width: 50,
                            child: Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 20) ,
                                  height: 150,
                                  width: 100,
                                  decoration: const BoxDecoration(
                                    //color: Colors.grey,
                                    image: DecorationImage(
                                      image: AssetImage('lib/imagenes/BIDON7.png'),
                                      fit: BoxFit.fill
                                    )
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text("Presentación de 700ml",
                                      style:TextStyle(fontSize: 20,color:Color.fromARGB(255, 255, 255, 255)),),
                                      const Text("S/.2",style: TextStyle(fontSize: 35,color: Colors.white),),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                        IconButton(onPressed:(){},
                                        iconSize: 45,
                                        color: Colors.white,
                                         icon:const Icon(Icons.remove_circle_outline),),
                                        const Text("10",style: TextStyle(color: Colors.white,fontSize:30),),
                                        IconButton(onPressed: (){},
                                        iconSize: 45,
                                        color: Colors.white,
                                         icon:const Icon(Icons.add_circle_outline),),
                                      ],),
                                    ],
                                  ),
                                ),
                                Container(),
                              ],
                            ),
                            decoration: BoxDecoration(
                              //color: Colors.amber
                              
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
                      style: TextStyle(fontWeight: FontWeight.w700,fontSize: 30,color:const Color.fromARGB(255, 1, 32, 56)),),
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
                      width: 100,
                      height: 50,
                      child:ElevatedButton(onPressed: (){},
                       style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 0, 24, 43))
                       ),
                       child: const Text("Sí",style: TextStyle(fontWeight: FontWeight.w300,fontSize: 25,color: Colors.white),)),
                    ),

                  ],
                ))));
  }
}
