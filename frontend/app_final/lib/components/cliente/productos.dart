import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:app_final/components/cliente/row_product.dart';
import 'package:app_final/components/cliente/compra.dart';
import 'package:http/http.dart' as http;
import 'package:app_final/provider/usuarios_model.dart';
import 'package:app_final/provider/usuario_provider.dart';
import 'package:provider/provider.dart';

//
class Producto {
  final int id;
  final String nombre;
  final int precio;
  final String descripcion;
  final String imagen;
  final int stock;
  
  int cantidad;

  Producto({
    this.id =0,
    this.nombre='',
    this.precio =0,
    this.descripcion = '',
    required this.imagen,
    this.stock = 0,
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
  int total = 0;
  String apiProduct = 'http://10.0.2.2:8004/api/products';
 

 // AQUI RECIBIMOS LOS PRODUCTOS DE LA API Y LUEGO añadimos a la clase producto
 // con la finalidad de manejar cada instancia por separado
 

  Future<dynamic> getProducts()async{

    // LLLAMADA DE API PRODUCTS
    var res = await http.get(Uri.parse(apiProduct), headers: {"Content-Type": "application/json"});

      if (res.statusCode == 200) {
        var data = json.decode(res.body);
        setState(() {
          newproduct = List<Producto>.from(data.map((item) {
            return Producto(
              id: item['id'],
              nombre: item['nombre']??'',
              precio: item['precio'],
              descripcion: item['descripcion'],
              stock: item['stock'],
              imagen: ima,
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
  print("DENTRO .......NAVIGATE OMPRAS");
  print("${newproduct.length}");
  //print("${newproduct.ca}");

  Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Compra(productos: productosContabilizados,montoTotal: obtenerTotal(),),
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

  int obtenerTotal (){
    int stotal = 0;

  List<Producto> productosContabilizados = newproduct.where((producto) => producto.cantidad > 0).toList();

   for (var producto in productosContabilizados) {
    print("Cantidad: ${producto.cantidad}, Precio: ${producto.precio}");
    stotal += producto.cantidad * producto.precio;
  }

  print("Total: $stotal");

  return stotal;
  }

  
  @override
  Widget build(BuildContext context) {
    final usuarioProvider = Provider.of<UsuarioProvider>(context);
    total =obtenerTotal();

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
                          nombre: newproduct[index].nombre,
                          precio: newproduct[index].precio,
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
                       Text("${total}",style:TextStyle(fontSize:30,color:Colors.white),),
                       const SizedBox(width:30,),
                       ElevatedButton(onPressed:(){
                          //getProducts();
                          print("dentro de producc");
                          print("usaurio nick,${usuarioProvider.getusuarioActual.nick}");
                          if (usuarioProvider.getusuarioActual is Empleado) {
                            print("${(usuarioProvider.getusuarioActual as Empleado).nombre}");
                          } 

                          print("id,${usuarioProvider.getusuarioActual.id}");
                          print("rolid,${usuarioProvider.getusuarioActual.rolid}");
                          

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
