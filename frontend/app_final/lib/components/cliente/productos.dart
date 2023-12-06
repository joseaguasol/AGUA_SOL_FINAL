import 'package:flutter/material.dart';
import 'package:app_final/components/cliente/row_product.dart';
import 'package:app_final/components/cliente/compra.dart';
class Productos extends StatefulWidget {
  const Productos({Key? key}) : super(key: key);

  @override
  State<Productos> createState() => _Productos();
}

class _Productos extends State<Productos> {
  String ima = 'lib/imagenes/RECARGA.png';
  String desc = "botella";
  int conta = 0;

  void incrementar() {
    setState(() {
      conta++;
    });
  }

  void disminuir() {
    setState(() {
      conta--;
    });
  }

void navigateCompras(){
  Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Compra(),
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
  Widget build(BuildContext context) {
    return Scaffold(
             // backgroundColor:Colors.blue,

        appBar: AppBar(
          title: Text("Productos",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w200),),centerTitle: true,
          //automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Center(
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        ProductCustom(
                          image: ima,
                          contador: conta,
                          descripcion: desc,
                          onPressedminus: disminuir,
                          onPressedplus: incrementar,
                        ),
                        SizedBox(height: 20,),
                        ProductCustom(
                          image: ima,
                          contador: conta,
                          descripcion: desc,
                          onPressedminus: disminuir,
                          onPressedplus: incrementar,
                        ),
                        SizedBox(height: 20,),
                        ProductCustom(
                          image: ima,
                          contador: conta,
                          descripcion: desc,
                          onPressedminus: disminuir,
                          onPressedplus: incrementar,
                        ),
                        SizedBox(height: 20,),
                        ProductCustom(
                          image: ima,
                          contador: conta,
                          descripcion: desc,
                          onPressedminus: disminuir,
                          onPressedplus: incrementar,
                        ),
                        SizedBox(height: 20,),
                        ProductCustom(
                          image: ima,
                          contador: conta,
                          descripcion: desc,
                          onPressedminus: disminuir,
                          onPressedplus: incrementar,
                        ),
                        SizedBox(height: 20,),
                        ProductCustom(
                          image: ima,
                          contador: conta,
                          descripcion: desc,
                          onPressedminus: disminuir,
                          onPressedplus: incrementar,
                        ),
                        SizedBox(height: 20,),
                        ProductCustom(
                          image: ima,
                          contador: conta,
                          descripcion: desc,
                          onPressedminus: disminuir,
                          onPressedplus: incrementar,
                        ),
                        SizedBox(height: 20,),
                        ProductCustom(
                          image: ima,
                          contador: conta,
                          descripcion: desc,
                          onPressedminus: disminuir,
                          onPressedplus: incrementar,
                        ),
                        SizedBox(height: 20,),
                        ProductCustom(
                          image: ima,
                          contador: conta,
                          descripcion: desc,
                          onPressedminus: disminuir,
                          onPressedplus: incrementar,
                        ),
                        SizedBox(height: 20,),
                        ProductCustom(
                          image: ima,
                          contador: conta,
                          descripcion: desc,
                          onPressedminus: disminuir,
                          onPressedplus: incrementar,
                        ),
                        SizedBox(height: 20,),
                        ProductCustom(
                          image: ima,
                          contador: conta,
                          descripcion: desc,
                          onPressedminus: disminuir,
                          onPressedplus: incrementar,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 164, 109, 174),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: 150,
                    child: Row(
                      children: [
                       const SizedBox(width:10,),
                       Icon(Icons.shopping_cart_outlined,size: 100,color: Colors.white,),
                       const SizedBox(width:20,),
                       Text("S/.200.00",style:TextStyle(fontSize:30,color:Colors.white),),
                       const SizedBox(width:30,),
                       ElevatedButton(onPressed:(){
                          navigateCompras();
                       },
                       style:ButtonStyle(
                        fixedSize: MaterialStateProperty.all(Size(150,80))
                       ), 
                       child:Text("Confirmar",style: TextStyle(fontSize:20),))
                       
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      
    );
  }
}
