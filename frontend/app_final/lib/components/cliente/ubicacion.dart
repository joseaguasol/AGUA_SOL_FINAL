import 'package:app_final/components/cliente/bienvenido.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:async';

class Maps extends StatefulWidget{
  const Maps({super.key});

  @override
  State<Maps> createState()=>_MapsState();
}

class _MapsState extends State<Maps>{

  final urlubi = "https://lottie.host/9fb0f0a1-28e8-495b-ab6f-298264567685/fIaQSM6s3n.json";
  double latitud = 0.0;
  double longitud = 0.0;
  String direccion = "";

  // PROMESA
  Future<Position>determinarPosicion()async{
   try{
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if(permission==LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied){
        throw Exception('Necesitamos tu ubicación, para brindarte una mejor atención');
       // return Future.error('error');
      }
    }
    return await Geolocator.getCurrentPosition();
    
    }
    catch(e){
      return Future.error('error');
    }
  }

  Future<void>obtenerDireccion()async{
    List<Placemark> placemark = await placemarkFromCoordinates(latitud, longitud);
    print(placemark);

    if(placemark.isNotEmpty){
      Placemark lugar = placemark.first;
      setState(() {
        direccion = "${lugar.street},${lugar.subAdministrativeArea},${lugar.locality},${lugar.postalCode},\n${lugar.country},${lugar.subLocality},\n${lugar.administrativeArea}";
      });
    }
    
  }

  
  
  @override
  Widget build (BuildContext context){

   // final double screenHeight =MediaQuery.of(context).size.height;
   void getCurrentLocation()async{
    
    try {
    Position position = await determinarPosicion();
    setState(() {
      latitud = position.latitude;
      longitud = position.longitude;
    });

    await obtenerDireccion();

    print('------------');
    print('$position.latitude');
    print('---------------------------');
    print('$position.longitude');

    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Bienvenido()), // Reemplaza "OtraVista" con el nombre de tu nueva vista
      );
    });

  } catch (e) {
    print('Error al obtener la ubicación actual: $e');
  }
  }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Container(
            //color:Color.fromARGB(255, 252, 207, 59),
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(15),
           // color: Colors.blue,
            ),
            
            child: Center(
              child:Column(
                children:  [
                  const SizedBox(height: 20,),
                 Text("$latitud"),
                  const SizedBox(height: 2,),
                 Text("$longitud"),
                  const SizedBox(height: 10,),
                 Text("$direccion"),
                  Image.asset('lib/imagenes/logo_sol_tiny.png',width:50),
                  const SizedBox(height: 20,),
                  Text("Déjanos saber \n tu ubicación",style:TextStyle(fontSize: 42,fontWeight: FontWeight.w200)),
                  const SizedBox(height: 50,),
                  Lottie.network(urlubi),
                  ElevatedButton(onPressed: ()
                  {
                    getCurrentLocation();
                    
                  

                  },
                   style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(Size(300,60)),
                    backgroundColor: MaterialStateProperty.all(Colors.blue)
                   ),
                   child: Text("Ubicación",style:TextStyle(fontWeight:FontWeight.bold,fontSize:25,color:Colors.white)),
                )
            ])),
          ),
        ),
      ),
    );
  }
}
