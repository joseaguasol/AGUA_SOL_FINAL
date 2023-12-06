import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';


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
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if(permission==LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied){
        return Future.error('error');
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<void>obtenerDireccion()async{
    List<Placemark> placemark = await placemarkFromCoordinates(latitud, longitud);
    print(placemark);

    if(placemark.isNotEmpty){
      Placemark lugar = placemark.first;
      setState(() {

        direccion = "${lugar.street},${lugar.subAdministrativeArea},${lugar.locality},${lugar.postalCode},\n${lugar.country},${lugar.subLocality},\n${lugar.administrativeArea}";
        if(direccion.isEmpty){
          direccion = "sja";
        }
        else{
          direccion = "";
        }
      
      });
    }
    
  }

  void getCurrentLocation()async{
    Position position = await determinarPosicion();
    setState(() {
      latitud = position.latitude;
      longitud = position.longitude;
    });
    
    await obtenerDireccion();

    print('');("------------");
    print("$position.latitude");
    print("---------------------------");
    print("$position.longitude");
  }
  
  @override
  Widget build (BuildContext context){

    final double screenHeight =MediaQuery.of(context).size.height;

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
                  //Image.asset('lib/images/logo_sol.png',width:50),
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
                   child: Text("Ubicación",style:TextStyle(fontWeight:FontWeight.w200,fontSize:25,color:Colors.white)),
                )
            ])),
          ),
        ),
      ),
    );
  }
}
/**
Container(child:Image.asset('lib/images/logo_sol.png',width: 100,)),
              Container(child:Lottie.network(urlubi),color:Colors.amber,width: 300,height:screenHeight*0.9,padding: EdgeInsets.all(10),),
              Text("Indicanos tu ubicación",style: TextStyle(fontSize: 20),)

 */