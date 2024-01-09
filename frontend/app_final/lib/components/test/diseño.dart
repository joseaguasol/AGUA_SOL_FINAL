import 'package:app_final/components/test/hola.dart';
import 'package:app_final/components/test/ubicacion.dart';
import 'package:flutter/material.dart';

class Login2 extends StatefulWidget {
  const Login2({super.key});

  @override
  State<Login2> createState() => _Login2State();
}

class _Login2State extends State<Login2> {
  @override
  Widget build(BuildContext context) {
    final anchoActual = MediaQuery.of(context).size.width;
    final largoActual = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Text("Ancho X largo: ${anchoActual}x ${largoActual.toStringAsFixed(2)}"),
              Container(
                //color: Colors.amber,
                margin: const EdgeInsets.only(top: 30, left: 20),
                height: 150,
                width: 150,
                child: Opacity(
                    opacity: 1,
                    child: Image.asset('lib/imagenes/logo_sol_tiny.png')),
              ),
              Container(
                margin: const EdgeInsets.only(top: 0, left: 20),
                child: const Text(
                  "Agua Sol",
                  style: TextStyle(
                      fontSize: 40,
                      fontFamily: 'Pacifico',
                      color: Color.fromARGB(255, 1, 43, 78)),
                ),
              ),
              const SizedBox(
                height: 0,
              ),
              Container(
                margin: const EdgeInsets.only(left: 20),
                child: const Text(
                  "Llevando vida a tu hogar !",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20),
                child: const Text(
                  "Conoce la mejor agua del Sur.",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w100),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.only(left: 20),
                width: 200, //MediaQuery.of(context).size.width*0.5,
                height: 50, //MediaQuery.of(context).size.height * 0.5,
                child: const TextField(
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 0, 36, 97))),

                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    //border:OutlineInputBorder(),
                    labelText: 'Usuario',
                    labelStyle: TextStyle(
                        color: Color.fromARGB(255, 8, 62, 107),
                        fontSize: 20,
                        fontWeight: FontWeight.w200),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.only(left: 20),
                width: 200, //MediaQuery.of(context).size.width*0.5,
                height: 50, //MediaQuery.of(context).size.height * 0.5,
                child: const TextField(
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 0, 36, 97))),

                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    //border:OutlineInputBorder(),
                    labelText: 'Contraseña',
                    labelStyle: TextStyle(
                        color: Color.fromARGB(255, 8, 62, 107),
                        fontSize: 20,
                        fontWeight: FontWeight.w200),
                  ),
                  obscureText: true,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                  width: 200,
                  height: MediaQuery.of(context).size.height < 480 ? 40 : 50,
                  margin: const EdgeInsets.only(left: 20),
                  child: ElevatedButton(
                      onPressed: () {
                        print(largoActual);
                        print(anchoActual);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Ubicacion()),
                        );
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 1, 61, 109))),
                      child: const Text(
                        "Bienvenido",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w300),
                      ))),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: 200,
                //color:Colors.red,
                margin: const EdgeInsets.only(left: 20),
                child: const Center(child: Text("o continua con:")),
              ),
              const SizedBox(
                height: 3,
              ),
              Container(
                  //color:Colors.red,
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  width: 200,
                  child: Row(
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 50,
                      ),
                      Image.asset(
                        'lib/imagenes/google.png',
                        height: 40,
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Image.asset(
                        'lib/imagenes/facebook.png',
                        height: 40,
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                    ],
                  )),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                  //color: Colors.red,
                  height: 300,
                  width: 400,
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('lib/imagenes/bodegoncito.jpg'),
                      fit: BoxFit.fitHeight
                    )
                  ),
                  // padding: EdgeInsets.all(20),
                 // child: Image.asset('lib/imagenes/BIDON7.png'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
