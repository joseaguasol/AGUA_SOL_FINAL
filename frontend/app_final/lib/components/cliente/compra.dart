import 'package:app_final/components/cliente/bienvenido.dart';
import 'package:flutter/material.dart';
import 'package:app_final/components/cliente/gracias.dart';
import 'package:app_final/components/cliente/productos.dart';
import 'package:flutter_animate/flutter_animate.dart';
//import 'package:app_final/components/cliente/row_product.dart';

class Compra extends StatefulWidget {
  //final List<Producto> productos;
  final List<Producto> productos;
  const Compra({required this.productos});

  @override
  State<Compra> createState() => _Compra();
}

class _Compra extends State<Compra>{

    bool normal = false;
    bool express = false;
    int cantidad = 0;

   
    void navigateGracias(){
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => Gracias(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.easeInOutQuart;

              var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);

              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 800),
          ),
        );
        }





    @override
    Widget build (BuildContext context){
      return Scaffold(
       // backgroundColor: const Color.fromARGB(255, 240, 211, 122),
        appBar: AppBar(
          title: Text("Detalle de Compra",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w200),),centerTitle: true,
          //automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(25),
              child: Column(
                children: [
                 // Text("Resumen de Compra",textAlign:TextAlign.start,style:TextStyle(color:Colors.black)),
                  Expanded(
                    child: ListView(
                      children: [
                        Container(
                        
                        height: 280,
                        //width: 100,
                        decoration: BoxDecoration(
                          color:Color.fromARGB(255, 124, 231, 126),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.all(10),
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                  
                          Row(
                            children: [
                              Icon(Icons.checklist_rounded,size: 40,),
                              const SizedBox(width:15,),
                              Text("Compra",style:TextStyle(fontWeight: FontWeight.w200,fontSize: 40)),
                            ],
                          ),
                          Expanded(
                            
                            child: ListView.builder(
                              
                              padding: EdgeInsets.all(5),
                              itemCount: widget.productos.length,
                              itemBuilder: (context,index){
                              return
                               Row(
                                 children: [
                                   Icon(Icons.check_circle_outlined),
                                   const SizedBox(width: 10,),
                                   Text("Cantidad de Productos:${widget.productos[index].cantidad}",style:TextStyle(fontWeight: FontWeight.w200,fontSize: 20)),
                                 ],
                               );
                            
                              }),
                          ),
                          Text("Subtotal:   S/.105.00",style:TextStyle(fontWeight: FontWeight.w200,fontSize: 20))
                          
                        ]),           
                      ),
                        SizedBox(height: 30,),
                        Container(
                          height: 200,
                          
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 191, 223, 46),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.all(15),
                          child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            Row(
                              children: [
                                Icon(Icons.person_pin_outlined,size: 40,),
                                SizedBox(width: 15,),
                                Text("Usuario",style:TextStyle(fontWeight: FontWeight.w200,fontSize: 40)),
                              ],
                            ),
                            Text(" - Nombres: Pedro P. Perez Perez",style:TextStyle(fontWeight: FontWeight.w200,fontSize: 20)),
                            Text(" - Direccion: Av. Brasil 204",style:TextStyle(fontWeight: FontWeight.w200,fontSize: 20))
                    
                    
                          ]),           
                        ).animate().shake(),
                        SizedBox(height: 30,),
                      
                        Container(
                        
                        height: 180,
                        width: 400,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 172, 171, 168),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.all(10),
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Text("Tipo de Envío:",style:TextStyle(fontWeight: FontWeight.w200,fontSize: 30)),
                          Row(children: [
                            Container(
                              height: 50,
                              
                              child:Icon(Icons.warehouse_outlined,color:Colors.white,size: 55,)
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                child: Text("Normal (Se agenda para mañana)"),
                              ),
                            ),
                            Container(
                              child: Checkbox(
                                checkColor: Colors.white,
                  
                                value: normal,
                                onChanged:(bool? value){
                                  setState(() {
                                    normal = value!;
                                  });
                                },
                              ),
                            )
                  
                          ],),
                          Row(children: [
                            Container(
                              height: 50,
                              
                              child:Icon(Icons.local_shipping,color:Colors.white,size: 55,)
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                child: Text("Express (Se entrega HOY + S/.10.00)"),
                              ),
                            ),
                            Container(
                              child: Checkbox(
                                checkColor: Colors.white,
                  
                                value: normal,
                                onChanged:(bool? value){
                                  setState(() {
                                    normal = value!;
                                  });
                                },
                              ),
                            )
                  
                          ],),
                  
                        ]),           
                      ),
                        
                      ],
                    ),
                  ),

                  //

                  SizedBox(height: 30,),
                      Container(
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color:Color.fromARGB(255, 82, 125, 97)
                        ),
                        child: Row(
                          children: [
                           const SizedBox(width:10,),
                           Icon(Icons.payments_outlined,size: 50,color: Colors.white,),
                           const SizedBox(width:20,),
                           Text("S/.200.00",style:TextStyle(fontSize:30,color:Colors.white),),
                           const SizedBox(width:30,),
                           ElevatedButton(onPressed:(){
                              navigateGracias();
                           },
                           style:ButtonStyle(
                            fixedSize: MaterialStateProperty.all(Size(150,80))
                           ), 
                           child:Text("Confirmar",style: TextStyle(fontSize:20),))
                           
                          ],
                        ),           
                      ),   

                ]
              )
          )
        )
      );
    }
}

                /*  ListView(
                    children: [
                      SizedBox(height: 20,),
                      Text("Resumen",style: TextStyle(fontWeight: FontWeight.w200,fontSize: 20),),
                      Container(
                        
                        height: 320,
                        width: 400,
                        decoration: BoxDecoration(
                          color:const Color.fromARGB(255, 177, 220, 178),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.all(10),
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                  
                          Text("Compra:",style:TextStyle(fontWeight: FontWeight.w200,fontSize: 30)),
                          Expanded(
                            
                            child: ListView.builder(
                              
                              padding: EdgeInsets.all(5),
                              itemCount: widget.productos.length,
                              itemBuilder: (context,index){
                              return Text("Cantidad de Productos:${widget.productos[index].cantidad}",style:TextStyle(fontWeight: FontWeight.w200,fontSize: 20));
                            
                              }),
                          ),
                  
                          Text(" - Bidon x 3  :   S/.90.00",style:TextStyle(fontWeight: FontWeight.w200,fontSize: 20)),
                          Text(" - Botellas x 3  :   S/.10.00",style:TextStyle(fontWeight: FontWeight.w200,fontSize: 20)),
                          Text("Subtotal:   S/.105.00",style:TextStyle(fontWeight: FontWeight.w200,fontSize: 20))
                  
                  
                        ]),           
                      ),
                      // USUARIO ------------->
                      SizedBox(height: 30,),
                      Container(
                        
                        height: 200,
                        width: 400,
                        decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.all(10),
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Text("Usuario:",style:TextStyle(fontWeight: FontWeight.w200,fontSize: 30)),
                          Text(" - Nombres: Pedro P. Perez Perez",style:TextStyle(fontWeight: FontWeight.w200,fontSize: 20)),
                          Text(" - Direccion: Av. Brasil 204",style:TextStyle(fontWeight: FontWeight.w200,fontSize: 20))
                  
                  
                        ]),           
                      ),
                      SizedBox(height: 30,),
                      
                      
                      // ENVÍOS---------------->
                      Container(
                        
                        height: 180,
                        width: 400,
                        decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.all(10),
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Text("Tipo de Envío:",style:TextStyle(fontWeight: FontWeight.w200,fontSize: 30)),
                          Row(children: [
                            Container(
                              height: 50,
                              
                              child:Icon(Icons.warehouse_outlined,color:Colors.white,size: 55,)
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                child: Text("Normal (Se agenda para mañana)"),
                              ),
                            ),
                            Container(
                              child: Checkbox(
                                checkColor: Colors.white,
                  
                                value: normal,
                                onChanged:(bool? value){
                                  setState(() {
                                    normal = value!;
                                  });
                                },
                              ),
                            )
                  
                          ],),
                          Row(children: [
                            Container(
                              height: 50,
                              
                              child:Icon(Icons.local_shipping,color:Colors.white,size: 55,)
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                child: Text("Express (Se entrega HOY + S/.10.00)"),
                              ),
                            ),
                            Container(
                              child: Checkbox(
                                checkColor: Colors.white,
                  
                                value: normal,
                                onChanged:(bool? value){
                                  setState(() {
                                    normal = value!;
                                  });
                                },
                              ),
                            )
                  
                          ],),
                  
                        ]),           
                      ),

                      // Confirmación ----------------------------->
                      SizedBox(height: 30,),
                      Container(
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color:Colors.purple
                        ),
                        child: Row(
                          children: [
                           const SizedBox(width:10,),
                           Icon(Icons.payments_outlined,size: 50,color: Colors.white,),
                           const SizedBox(width:20,),
                           Text("S/.200.00",style:TextStyle(fontSize:30,color:Colors.white),),
                           const SizedBox(width:30,),
                           ElevatedButton(onPressed:(){
                              navigateGracias();
                           },
                           style:ButtonStyle(
                            fixedSize: MaterialStateProperty.all(Size(150,80))
                           ), 
                           child:Text("Confirmar",style: TextStyle(fontSize:20),))
                           
                          ],
                        ),           
                      ),
                      SizedBox(height: 30,)
                  
                    
                      
                  
                    ],
                  ),*/
