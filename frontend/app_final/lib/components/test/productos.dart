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
    //  backgroundColor:Color.fromARGB(255, 65, 68, 67),
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
                      height: 400,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                      //  color:Color.fromARGB(255, 246, 197, 255),
                        borderRadius: BorderRadius.circular(15),
                       border: Border.all(
                          color: Color.fromARGB(255, 21, 168, 14),
                               // color:Color.fromARGB(255, 68, 102, 132),
                                width: 1.0
                         )
                      ),

                      //
                      
                      child:ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        itemBuilder: (context,index){

                          return Container(
                            margin: const EdgeInsets.only(left: 10),
                            height: 100,
                            width: 295,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 20) ,
                                  height: 250,
                                  width: 160,
                                  decoration: const BoxDecoration(
                                  //  color: Color.fromARGB(255, 217, 215, 215),
                                    image: DecorationImage(
                                      image: AssetImage('lib/imagenes/BIDON7.png'),
                                      fit: BoxFit.fill
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
                                      const Text("Presentación de 700ml",
                                      style:TextStyle(fontSize: 20,color:Color.fromARGB(255, 0, 51, 93)),),
                                      const Text("S/.2",style: TextStyle(fontSize:25,color: Color.fromARGB(255, 0, 44, 81)),),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                       // mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                        IconButton(onPressed:(){},
                                        iconSize: 30,
                                        color: const Color.fromARGB(255, 0, 57, 103),
                                         icon:const Icon(Icons.remove_circle_outline,color: Colors.amber,),),
                                        const Text("10",
                                        style: TextStyle(color: Color.fromARGB(255, 0, 50, 90),
                                        fontSize:27),),
                                        IconButton(onPressed: (){},
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
                            decoration:const BoxDecoration(
                            //color: Color.fromARGB(255, 165, 165, 165)
                              
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
                      width: 100,
                      height: 50,
                      child:ElevatedButton(onPressed: (){},
                       style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 3, 92, 165))
                       ),
                       child: const Text("Sí",style: TextStyle(fontWeight: FontWeight.w300,fontSize: 25,color: Colors.white),)),
                    ),

                  ],
                ))));
  }
}
