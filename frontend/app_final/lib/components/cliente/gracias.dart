import 'package:app_final/components/cliente/bienvenido.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

//import 'package:app_final/components/cliente/row_product.dart';

class Gracias extends StatefulWidget {
  const Gracias({super.key});

  @override
  State<Gracias> createState() => _GraciasState();
}

class _GraciasState extends State<Gracias>{
    void navigateToBienvenido(){
  Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Bienvenido(),
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
      backgroundColor: const Color.fromARGB(255, 163, 223, 165),
      body: SafeArea(
        child:Padding(
          padding: EdgeInsets.all(2),
          child: Column(
            children: [
              Lottie.asset('lib/imagenes/Animation - 1701877289450.json'),
              const SizedBox(height: 40,),
              Text("¡Tu Orden \nestá Confirmada =)!",textAlign:TextAlign.center,style:TextStyle(fontSize: 55,color:Colors.white,fontWeight: FontWeight.bold)),
                            const SizedBox(height: 60,),

              ElevatedButton(onPressed:() {
                navigateToBienvenido();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
                fixedSize: MaterialStateProperty.all(Size(300,60))
              ), child: Text("Listo",style: TextStyle(fontSize: 40,color:Colors.white),))
            ],
          ),
        ),
      ),
    );
  }
}