import 'package:flutter/material.dart';
import 'package:app_final/components/cliente/productos.dart';

class Bienvenido extends StatefulWidget {
  const Bienvenido({Key? key}) : super(key: key);

  @override
  State<Bienvenido> createState() => _Bienvenido();
}

class _Bienvenido extends State<Bienvenido> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

 //final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
 void navigateToProductos(){
  Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Productos(),
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
      //backgroundColor: Colors.amber,
      key: _scaffoldKey,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Stack(
            children: [
              Center(
                child: Column(
                  children: [
                    Text("Bienvenido",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w200),),
                    SizedBox(height: 50,),
                    Text("Promociones",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w200),),
                   // SizedBox(height: 20,),

                    Container(
                      
                      width: 340,height:200,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 237, 242, 181),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child:ListView(
                        // This next line does the trick.
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          const SizedBox(width: 20,),
                          Container(
                            child: Image.asset('lib/imagenes/promocion.jpg',height: 300,),
                            width: 300,
                            color: Colors.red,
                          ),
                          const SizedBox(width: 20,),
                          Container(
                            child: Image.asset('lib/imagenes/promocion.jpg',height: 300,),
                            width: 300,
                            color: Colors.blue,
                          ),
                          const SizedBox(width: 20,),

                          Container(
                            child: Image.asset('lib/imagenes/promocion.jpg',height: 300,),
                            width: 300,
                            color: Colors.green,
                          ),
                          const SizedBox(width: 20,),
                          Container(
                            child: Image.asset('lib/imagenes/promocion.jpg',height: 300,),
                            width: 300,
                            color: Colors.yellow,
                          ),
                          const SizedBox(width: 20,),
                          Container(
                            child: Image.asset('lib/imagenes/promocion.jpg',height: 300,),
                            width: 300,
                            color: Colors.orange,
                          ),
                        ],
                      ),),

                     SizedBox(height: 30,),
                    Text("Productos",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w200),),
                    //SizedBox(height: 20,),


                    InkWell(
                              onTap: (){
                                navigateToProductos();
                              },
                            

                    child:Container(
                      width: 340,
                      height:250,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 40, 182, 168) ,
                        borderRadius: BorderRadius.circular(15)
                      ),
                      
                      child: Image.asset('lib/imagenes/bodegon.png',height:200,),)),

                     SizedBox(height: 40,),
                    Text("Monedero",style: TextStyle(fontSize:20,fontWeight: FontWeight.w200),),
                    //SizedBox(height: 20,),

                    Container(width: 340,height:90,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(25)
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                      const  SizedBox(width: 20,),
                      Text("Saldo \nS/. 100.00",style: TextStyle(color:Colors.yellow,fontSize: 15,fontWeight: FontWeight.bold),),
                      Icon(Icons.currency_exchange,size: 25,color: Colors.yellow,),
                      Icon(Icons.savings_outlined,size: 68,color: Colors.yellow,),
                     const SizedBox(width: 20,)
                    ],),)

                  ],
                ),
              ),

              // Icono superpuesto
              Positioned(
                top: 10,
                left: 10,
                child: GestureDetector(
                  onTap: () {
                    _scaffoldKey.currentState?.openDrawer();
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Icon(
                      color: Colors.white,
                      Icons.account_circle_outlined,
                      size: 45,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menú',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Opción 1'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Opción 2'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
