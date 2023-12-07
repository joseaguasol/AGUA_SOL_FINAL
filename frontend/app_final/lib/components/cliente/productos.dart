import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:app_final/components/cliente/row_product.dart';
import 'package:app_final/components/cliente/compra.dart';
import 'package:http/http.dart' as http;

class Producto {
  final String imagen;
  final String descripcion;
  int cantidad;

  Producto({
    required this.imagen,
    required this.descripcion,
    this.cantidad = 0,
  });
}

class Productos extends StatefulWidget {
  const Productos({Key? key}) : super(key: key);

  @override
  State<Productos> createState() => _Productos();
}

class _Productos extends State<Productos> {
 // List<Map<String,dynamic>>datosProductos = [];
  List <Producto> newproduct = [];
  int enviados = 0;
  String ima = 'lib/imagenes/RECARGA.png';
  String desc = "botella";
  int conta = 0;
  String apiProduct = 'http://10.0.2.2:8004/api/products';

  Future<dynamic> getProducts()async{
    var res = await http.get(Uri.parse(apiProduct), headers: {"Content-Type": "application/json"});

      if (res.statusCode == 200) {
        var data = json.decode(res.body);
        setState(() {
          newproduct = List<Producto>.from(data.map((item) {
            return Producto(
              imagen: ima,
              descripcion: item['nombre'],
              cantidad: conta,
            );
          }));
        });
      }
    print("Después... $newproduct");
  }

  @override
  void initState(){
    super.initState();
    getProducts();

  }
  



 // LLAMADA DE API DE PRODUCTOS



void incrementar(int index) {
  setState(() {
    newproduct[index].cantidad++;
  });
}

void disminuir(int index) {
  setState(() {
    if(newproduct[index].cantidad>0){
       newproduct[index].cantidad--;
    }

   
  });
}

void navigateCompras(){
  
  List<Producto> productosContabilizados = newproduct.where((producto) => producto.cantidad > 0).toList();

  Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Compra(productos: productosContabilizados),
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
                    child: ListView.builder(
                      itemCount:newproduct.length,
                      itemBuilder:(context,index){
                        return ProductCustom(
                          image: ima,
                          contador: newproduct[index].cantidad,
                          descripcion: newproduct[index].descripcion,
                          onPressedminus: () {
                              disminuir(index);
                            },
                          onPressedplus: () {
                              incrementar(index);
                            },
                        );
                      }
                    ),
                   
                  ), SizedBox(height: 20,),
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
                          //getProducts();
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
