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
                       // color: Colors.grey,
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
                                  style: TextStyle(color:Color.fromARGB(255, 7, 55, 95),
                                  fontSize: 35,fontWeight: FontWeight.w300),
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
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.blue,
                              image: DecorationImage(
                                image: AssetImage('lib/imagenes/gotitapastel.jpg'),
                                fit: BoxFit.fill,
                              )
                            ),
                           
                          )
                        ]),
                      ),
                      const SizedBox(height: 30,),
                      Container(
                        margin: const EdgeInsets.only(left: 20),
                        decoration: BoxDecoration(
                          color:Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.circular(20)
                        ),
                        padding: const EdgeInsets.all(8),
                        height: 400,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, index){
                            return Container(
                              margin: const EdgeInsets.only(left:10),
                              padding: const EdgeInsets.all(10),
                              
                             // height: 150,
                             decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                             // color: Colors.green,
                             ),
                             width: 400,
                              
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    
                                    width: 390,
                                    height: 220,
                                    decoration: BoxDecoration(
                                      //color:Colors.orange,
                                      image: DecorationImage(
                                         image: AssetImage('lib/imagenes/bodegoncito.jpg'),
                                         fit:BoxFit.cover,
                                      )
                                    ),
                                  ),
                                  Container(
                                    height: 120,
                                    margin: const EdgeInsets.only(left: 0),
                                   // color:Colors.blue,
                                    child: Column(
                                      //crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      
                                      children: [

                                        Text("Llévate la promo 3 x S/.20",
                                        style: TextStyle(fontSize:20,
                                        color:const Color.fromARGB(255, 2, 79, 141))),
                                        Text("Válido por 1 mes",
                                        style: TextStyle(fontSize:20,
                                        color:const Color.fromARGB(255, 0, 89, 161))),
                                        const SizedBox(height: 5,),
                                        Container(
                                          height: 50,
                                          width: 160,
                                          //color:Colors.pink,
                                          child: Row(
                                            children: [
                                              IconButton(onPressed: (){},
                                              iconSize: 40,
                                              color:Colors.amber,
                                              icon: Icon(Icons.remove_circle_outline)),
                                              Text(" 1 ",
                                              style: TextStyle(color:const Color.fromARGB(255, 0, 82, 149),
                                              fontSize: 30),),
                                              IconButton(onPressed: (){},
                                                iconSize: 40,
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
                            backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 2, 91, 164))
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
