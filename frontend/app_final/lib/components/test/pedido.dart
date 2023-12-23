import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Pedido extends StatefulWidget {
  const Pedido({super.key});

  @override
  State<Pedido> createState() => _PedidoState();
}

class _PedidoState extends State<Pedido> {
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
                      height: 200,
                      margin: const EdgeInsets.only(top: 30,left: 20),
                      //color:Colors.grey,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 0),
                            height:200 ,
                            width: 180,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage('lib/imagenes/mañana.png')
                              ),
                              //color:const Color.fromARGB(255, 186, 164, 164)
                            ),
                          ),
                          //Expanded(child: Container()),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [

                              Container(
                                margin: const EdgeInsets.only(right: 20),
                                //color: Colors.blue,
                                child: Text("Tu pedido",
                                style: 
                                TextStyle(color:const Color.fromARGB(255, 17, 62, 98),
                                fontSize: 39,fontWeight:FontWeight.w300),)),
                              Container(
                                margin: const EdgeInsets.only(right: 20),
                            child: Text("se agendó",
                            style: TextStyle(fontSize: 35,color: const Color.fromARGB(255, 3, 39, 68)),),
                          ),
                          Container(
                            margin: const EdgeInsets.only(right:20),
                            child:Text("para mañana",
                            style: TextStyle(fontSize: 30,fontWeight: FontWeight.w200),),
                          ),
                          Container(
                            margin: const EdgeInsets.only(right:20),
                            child:Text("aquí esta el detalle",
                            style: TextStyle(fontSize: 25,
                            fontWeight: FontWeight.w400),),
                          ),
                            ],
                          ),
                                                  
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 20,),
                    Container(
                      margin: const EdgeInsets.only(left: 20,right: 20),
                      //color:Colors.grey,

                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                            border: Border.all(width: 2)
                          ),
                      child: ListView.builder(
                        itemCount: 8,
                        itemBuilder:(context,index){
                        return Container(
                          margin: const EdgeInsets.only(left: 20),
                          child: Row(
                            children: [
                              Icon(Icons.water_drop_outlined,size: 40,),
                              const SizedBox(width: 50,),
                              Text("Bidón 20L cantidad: 3",
                              style: TextStyle(fontSize: 20),),
                            ],
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      //color:Colors.grey,
                      height: 50,
                      child: Text("El total es de: S/.200.00",
                      style:TextStyle(color: const Color.fromARGB(255, 1, 34, 60),fontSize: 28,fontWeight: FontWeight.w500),),

                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      height: 60,
                      //color:Colors.grey,
                      width: 140,
                      child: ElevatedButton(onPressed: (){},
                       child: Text("Listo !",
                       style: TextStyle(fontSize: 25,color:Colors.white),),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 1, 34, 60))
                      ),
                       ),

                    ),
                    const SizedBox(height: 20,),
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: Text("Lo necesitas",
                      style: TextStyle(fontSize: 40,fontWeight: FontWeight.w300),),
                    ),
                     Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: Text("HOY ?",style: TextStyle(fontSize: 40),),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            color:Colors.amber,
                            child:Lottie.asset('lib/imagenes/anim_13.json'),),
                          Text(" + S/.10 conviértelo en Pedido express",
                          style: TextStyle(fontSize: 20),),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15,),
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      height: 60,
                      //color:Colors.grey,
                      width: 180,
                      child: ElevatedButton(onPressed: (){},
                       child: Text("Express >>",
                       style: TextStyle(fontSize: 25,color:const Color.fromARGB(255, 1, 31, 56)),),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 219, 214, 214))
                      ),
                       ),

                    ),
                  
                  ],
                ))));
  }
}
