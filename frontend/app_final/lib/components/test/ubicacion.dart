import 'package:flutter/material.dart';

class Ubicacion extends StatefulWidget {
  const Ubicacion({super.key});

  @override
  State<Ubicacion> createState() => _UbicacionState();
}

class _UbicacionState extends State<Ubicacion>{
  
  @override
  Widget build (BuildContext context){
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
            Container(
              //width: 200,
              margin: const EdgeInsets.only(top: 80,right: 20),
             // color: Colors.red,
              child: Row(
                children: [
                  Expanded(child: Container(),),
                  const Text("Mejora!",style: TextStyle(fontSize: 40,fontWeight: FontWeight.w400)),
                ],
              ),
            ),
            const SizedBox(height: 0,),
            Container(
              //width: 200,
              margin: const EdgeInsets.only(right: 20),
              //color: Colors.red,
              child: Row(
                children: [
                  Expanded(child: Container(),),
                  const Text("Tú experiencia de entrega",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w300)),
                ],
              ),
            ),
            Container(
              //width: 200,
              margin: const EdgeInsets.only(right: 20),
              //color: Colors.red,
              child: Row(
                children: [
                  Expanded(child: Container(),),
                  const Text("Déjanos saber tu ubicación",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w200)),
                ],
              ),
            ),
            const SizedBox(height: 20,),
            Container(
              width: 150,
              height: 60,
              margin: const EdgeInsets.only(right: 20),
              //color: Colors.red,
              child: ElevatedButton(onPressed: (){},
               child:Text(">> Aquí",style: TextStyle(color:Colors.white,fontSize:20,fontWeight: FontWeight.w400),),
               style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 1, 59, 107))
                
               ),
               )
            ),
            //Expanded(child: Container()),
            const SizedBox(height: 80,),
            Container(
              child: Opacity(
                opacity: 0.9,
                child: Image.asset('lib/imagenes/ubicacion.jpg')),
            ),

          ]),
        ),
      ),
    );
  }
}