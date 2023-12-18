import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;

class BienvenidaConductor extends StatefulWidget{

  const BienvenidaConductor({Key? key}) : super(key: key);
  //const BienvenidaConductor({super.key});

  @override
  State<BienvenidaConductor> createState()=>_BienvenidaConductor();
}


String url = 'https://aguasol.onrender.com/api/user_conductor';


class _BienvenidaConductor extends State<BienvenidaConductor>{

List<dynamic> datosConductor=[];
var nombreConductor='';

Future<dynamic>getPedidos() async{
    var res = await http.get(Uri.parse(url),
    headers:{"Content-Type":"application/json"});
    datosConductor = json.decode(res.body);
    nombreConductor=datosConductor[0]['nombres'];
    print(nombreConductor);
    return nombreConductor;
}


  @override
  void initState() {
  super.initState();
  getPedidos();
  }
  

 
  var ruta=2;

  @override
  Widget build(BuildContext context){

    return Container(

      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [Color.fromARGB(255, 255, 255, 255),Color.fromARGB(255, 28, 187, 255)],
        )
      ),



      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text("Bienvenid@", style: TextStyle(fontSize:20,fontWeight:FontWeight.w300,color: Color.fromARGB(255, 63, 63, 63))),
          leading: const IconButton(
            onPressed: null, 
            icon: Icon(Icons.menu)
          ),
          backgroundColor: const Color.fromARGB(255, 56, 195, 255),
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),



        body: Padding(

          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text('¡Buenos días, ${nombreConductor}!',style: const TextStyle(fontSize:19,fontWeight:FontWeight.w500,color: Color.fromARGB(255, 92, 92, 92))) ,
              ),
              const Text('Tu ruta asignada es la',style: TextStyle(fontSize:17,fontWeight:FontWeight.w500,color:  Color.fromARGB(255, 92, 92, 92),fontStyle: FontStyle.italic)),
              Text('RUTA $ruta',style: const TextStyle(fontSize:17,fontWeight:FontWeight.w500,color:  Color.fromARGB(255, 92, 92, 92),fontStyle: FontStyle.italic)),
              SizedBox(
                height: 160,
                child: Lottie.asset('lib/animations/anim_4.json',height: 700),
              ),
              ElevatedButton(
                onPressed: (){
                }, 
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 240, 240, 240),
                ),
                child: const Text('¡COMENZAR!', style: TextStyle(color: Colors.black),),
              ),
          ],
        ),
      ),
    )
    );
  }
}
