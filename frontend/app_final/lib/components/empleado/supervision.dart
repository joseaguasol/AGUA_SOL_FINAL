import 'package:flutter/material.dart';
class Supervision extends StatefulWidget{
  const Supervision({super .key});
  @override
  State<Supervision> createState()=>_Supervision();
}

class _Supervision extends State<Supervision>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Supervisión de Rutas", style: TextStyle(fontFamily: 'Pacifico',fontSize:22,fontWeight:FontWeight.w300,)),
        backgroundColor: const Color.fromARGB(255, 175, 231, 255),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            children: [
        
        
        
        
              Row(
                children:  [
                  SizedBox(
                    width: 30,
                    child: Icon(Icons.local_shipping, color: Color.fromARGB(255, 65, 65, 65),size: 27,),
                  ),
                  Column(
                    children:  [
                      SizedBox(
                        width: 220,
                        child: Text('  RUTA 1 (31)',
                              style: TextStyle(
                              fontSize:15,
                              fontWeight:FontWeight.w700, 
                              color: Color.fromARGB(255, 65, 65, 65)
                              ),
                            ),
                      ),
                      SizedBox(
                        width: 220,
                        child: Text('   Chofer: Mario Juano Perez',
                          style: TextStyle(
                            fontSize:10,
                            fontWeight:FontWeight.w400, 
                            color: Color.fromARGB(255, 65, 65, 65)
                          ),
                        )
                      )
                    ], //hijos de la columna
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: 70,
                        child: Icon(Icons.hourglass_top, color: Color.fromARGB(255, 240, 228, 0),size: 23,),
                      ),
                      SizedBox(
                        width: 70,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text('EN PROGRESO',
                            style: TextStyle(
                              fontSize:9,
                              fontWeight:FontWeight.w600, 
                              color: Color.fromARGB(255, 240, 228, 0)
                            ),
                          )
                        )
                      ),
                    ],
                  ),
                ],
              ),
        
              SizedBox(height: 5),
        
              SizedBox(
                height: 200,
                width: 200,
                child: ListView(
                  children: [
                    ListTile(
                      isThreeLine: true,
                      leading: Icon(Icons.double_arrow, size: 20,),
                      title: Text('Pedido 1: Maria Perez', style: TextStyle(fontSize:12,fontWeight:FontWeight.w600, color: Color.fromARGB(255, 65, 65, 65)),),
                      subtitle: Align(
                        alignment: Alignment.topLeft,
                        child: Column(
                          children: [
                            Text('Dirección: Sachaca - Calle Polonia 345', style: TextStyle(fontSize:9,fontWeight:FontWeight.w500, color: Color.fromARGB(255, 65, 65, 65)),),
                            Text('Productos: 7OO mL(x2), 20L RECARGA (x1)',style: TextStyle(fontSize:9,fontWeight:FontWeight.w500, color: Color.fromARGB(255, 65, 65, 65)),),
                          ],
                        ),
                      ), 
                    ),
                    ListTile(
                      isThreeLine: true,
                      leading: Icon(Icons.double_arrow, size: 20,),
                      title: Text('Pedido 2: Maria Perez', style: TextStyle(fontSize:12,fontWeight:FontWeight.w600, color: Color.fromARGB(255, 65, 65, 65)),),
                      subtitle: Align(
                        alignment: Alignment.topLeft,
                        child: Column(
                          children: [
                            Text('Dirección: Sachaca - Calle Polonia 345', style: TextStyle(fontSize:9,fontWeight:FontWeight.w500, color: Color.fromARGB(255, 65, 65, 65)),),
                            Text('Productos: 7OO mL(x2), 20L RECARGA (x1)',style: TextStyle(fontSize:9,fontWeight:FontWeight.w500, color: Color.fromARGB(255, 65, 65, 65)),),
                          ],
                        ),
                      ), 
                    ),
                    ListTile(
                      isThreeLine: true,
                      leading: Icon(Icons.double_arrow, size: 20,),
                      title: Text('Pedido 3: Maria Perez', style: TextStyle(fontSize:12,fontWeight:FontWeight.w600, color: Color.fromARGB(255, 65, 65, 65)),),
                      subtitle: Align(
                        alignment: Alignment.topLeft,
                        child: Column(
                          children: [
                            Text('Dirección: Sachaca - Calle Polonia 345', style: TextStyle(fontSize:9,fontWeight:FontWeight.w500, color: Color.fromARGB(255, 65, 65, 65)),),
                            Text('Productos: 7OO mL(x2), 20L RECARGA (x1)',style: TextStyle(fontSize:9,fontWeight:FontWeight.w500, color: Color.fromARGB(255, 65, 65, 65)),),
                          ],
                        ),
                      ), 
                    ),
                  ],
                )
              ),
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
              Row(
                children: [
                  SizedBox(
                    width: 30,
                    child: Icon(Icons.local_shipping, color: Color.fromARGB(255, 65, 65, 65),size: 27,),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: 220,
                        child: Text('  RUTA 2 (30)',
                              style: TextStyle(
                              fontSize:15,
                              fontWeight:FontWeight.w700, 
                              color: Color.fromARGB(255, 65, 65, 65)
                              ),
                            ),
                      ),
                      SizedBox(
                        width: 220,
                        child: Text('   Chofer: Pedro Jose Pendeivis',
                          style: TextStyle(
                            fontSize:10,
                            fontWeight:FontWeight.w400, 
                            color: Color.fromARGB(255, 65, 65, 65)
                          ),
                        )
                      )
                    ], //hijos de la columna
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: 70,
                        child: Icon(Icons.insert_emoticon, color: Color.fromARGB(255, 68, 226, 0),size: 23,),
                      ),
                      SizedBox(
                        width: 70,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text('COMPLETADO',
                            style: TextStyle(
                              fontSize:9,
                              fontWeight:FontWeight.w600, 
                              color: Color.fromARGB(255, 68, 226, 0)
                            ),
                          )
                        )
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 5),
        
        
              SizedBox(
                height: 200,
                width: 260,
              ),
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
              Row(
                children: [
                  SizedBox(
                    width: 30,
                    child: Icon(Icons.local_shipping, color: Color.fromARGB(255, 65, 65, 65),size: 27,),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: 220,
                        child: Text('  RUTA 3 (31)',
                              style: TextStyle(
                              fontSize:15,
                              fontWeight:FontWeight.w700, 
                              color: Color.fromARGB(255, 65, 65, 65)
                              ),
                            ),
                      ),
                      SizedBox(
                        width: 220,
                        child: Text('   Chofer: Maria Choque',
                          style: TextStyle(
                            fontSize:10,
                            fontWeight:FontWeight.w400, 
                            color: Color.fromARGB(255, 65, 65, 65)
                          ),
                        )
                      )
                    ], //hijos de la columna
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: 70,
                        child: Icon(Icons.hourglass_top, color: Color.fromARGB(255, 240, 228, 0),size: 23,),
                      ),
                      SizedBox(
                        width: 70,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text('EN PROGRESO',
                            style: TextStyle(
                              fontSize:9,
                              fontWeight:FontWeight.w600, 
                              color: Color.fromARGB(255, 240, 228, 0),
                            ),
                          )
                        )
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
        
              SizedBox(
                height: 200,
                child: ListTile(),
              ),
        
        
        
        
        
        
        
        
        
        
        
        
        
        
              
            ], // fin de los hijos de list view
          ),
        ),
      ),




     /* 
          FloatingActionButton(
            onPressed: null,
            backgroundColor: Color.fromARGB(255, 58, 196, 255),
            child: Icon(Icons.add_ic_call_outlined, color:  Color.fromARGB(255, 65, 65, 65),),
            shape: CircleBorder(),
          ),
          SizedBox(height: 10,),
          FloatingActionButton(
            onPressed: null,
            backgroundColor: Color.fromARGB(255, 58, 196, 255),
            child: Icon(Icons.directions_bike, color:  Color.fromARGB(255, 65, 65, 65),),
            shape: CircleBorder(),
          ),*/
       
    );
  }
}