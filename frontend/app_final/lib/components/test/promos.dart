import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Promos extends StatefulWidget {
  const Promos({super.key});

  @override
  State<Promos> createState() => _PromosState();
}

class _PromosState extends State<Promos> {
  @override
  Widget build(BuildContext context) {
    //final TabController _tabController = TabController(length: 2, vsync: this);

    return Scaffold(
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    //mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        //height: 0,
                        //color: Colors.grey,
                        margin: const EdgeInsets.only(top:20,left: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                //color: Colors.grey,
                                //margin: const EdgeInsets.only(left: 20),
                                //height: 100,
                                child: Text(
                                  "Llévate !",
                                  style: TextStyle(color:Color.fromARGB(255, 7, 55, 95),fontSize: 35),
                                ),
                              ),
                              Container(
                                //color: Colors.grey,
                                //height: 100,
                                child: Text(
                                  "las mejores promos",
                                  style: TextStyle(fontSize: 25),
                                ),
                              ),
                              Container(
                                //color: Colors.grey,
                                // height: 100,
                                child: Text(
                                  "Solo para tí",
                                  style: TextStyle(fontSize:35),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 20),
                            height: 200,
                            width: 180,
                            child: Image.asset('lib/imagenes/gotitapastel.jpg'),
                          )
                        ]),
                      ),
                      const SizedBox(height: 30,),
                      Container(
                        margin: const EdgeInsets.only(left: 20),
                        decoration: BoxDecoration(
                          color:const Color.fromARGB(255, 0, 91, 165),
                          borderRadius: BorderRadius.circular(20)
                        ),
                        padding: const EdgeInsets.all(8),
                        height: 380,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: 5,
                          itemBuilder: (context, index){
                            return Container(
                              margin: const EdgeInsets.only(top:10),
                              height: 150,
                              //color: Colors.green,
                              child: Row(
                                children: [
                                  Container(
                                    
                                    width: 150,
                                    height: 150,
                                    decoration:const BoxDecoration(
                                      
                                      image: DecorationImage(
                                         image: AssetImage('lib/imagenes/bodegoncito.jpg'),
                                         fit:BoxFit.cover,
                                      )
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    //color:Colors.blue,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,                                      children: [
                                        Text("Llévate la promo 3 x S/.20",
                                        style: TextStyle(fontSize:20,
                                        color:Colors.white)),
                                        Text("Válido por 1 mes",
                                        style: TextStyle(fontSize:15,
                                        color:Colors.white)),
                                        const SizedBox(height: 5,),
                                        Container(
                                          height: 80,
                                          width: 160,
                                          //color:Colors.pink,
                                          child: Row(
                                            children: [
                                              IconButton(onPressed: (){},
                                              iconSize: 45,
                                              color:Color.fromARGB(255, 224, 234, 228),
                                              icon: Icon(Icons.remove_circle_outline)),
                                              Text(" 1 ",
                                              style: TextStyle(color:Colors.white,fontSize: 35),),
                                              IconButton(onPressed: (){},
                                                iconSize: 45,
                                                color: Color.fromARGB(255, 224, 41, 206),
                                               icon: Icon(Icons.add_circle_outline))
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                 
                                ],
                              ),
                            );
                          },
                        )
                          
                         
                      ),
                       const SizedBox(height: 20,),
                      Container(
                        margin: const EdgeInsets.only(left: 20),
                        child: Text("Su importe es",style: TextStyle(color:const Color.fromARGB(255, 0, 60, 110),
                        fontSize: 25),),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20),
                        child: Text("S/.220.00",
                        style: TextStyle(fontWeight:FontWeight.w300,fontSize:29,color:const Color.fromARGB(255, 0, 40, 73)),),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20),
                        child: Text("Quieres la promo?",
                        style: TextStyle(fontSize:29,color:const Color.fromARGB(255, 0, 40, 73)),),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20),
                       child: Row(children: [
                        Container(
                          height: 50,
                          width: 150,
                          child: ElevatedButton(onPressed:(){},
                           child: Text("Si !",style: TextStyle(
                            fontSize:20,color:Colors.white),),
                           style:ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 2, 50, 89))
                           )),
                        ),
                         const SizedBox(width: 20,),
                         Container(
                          
                          height: 80,
                          width: 80,
                          child: Stack(
                            children: [
                              Lottie.asset('lib/imagenes/party.json'),
                              Lottie.asset('lib/animatios/anim_16.json'),
                            ],
                          ))

                       ],),
                      )


                    ]))));
  }
}
