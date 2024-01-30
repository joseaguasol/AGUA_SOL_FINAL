import 'package:app_final/components/test/formulario.dart';
import 'package:app_final/components/test/hola.dart';
import 'package:app_final/components/test/ubicacion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:async';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class Usuario {
  final int id;
	final int rol_id;
	final String nickname;
	final String contrasena;
	String? email;
	final String nombres;// varchar(100) not null,
	final String apellidos;// varchar(200) not null,
	final String dni;// varchar(200) no,
	String fecha_nacimiento;// date not null,
	String? licencia;// varchar (100),
	String? frecuencia;// int,
	String? sexo;// varchar(100),
	String? direccion;// varchar(150),
	String? telefono;// varchar(50),
	String? codigo;// varchar(200),
	double? saldo_beneficios;// int,
	String? direccion_empresa;// varchar(200),
	String? suscripcion;// varchar(200),
	String? ubicacion; //varchar(200), --GEOMETRY
	String? ruc;// varchar(200),
	String? nombre_empresa;// varchar(200),
	String? zona_trabajo_id;//int


   Usuario(
      {required this.id,
      required this.nombres,
      required this.apellidos,
      required this.dni,
      this.codigo,
      required this.nickname,
      required this.contrasena,
      this.direccion,
      this.direccion_empresa,
      required this.fecha_nacimiento,
      this.email,
      this.frecuencia,
      this.licencia,
      this.nombre_empresa,
      required this.rol_id,
      this.ruc,
      this.saldo_beneficios,
      this.sexo,
      this.suscripcion,
      this.telefono,
      this.ubicacion,
      this.zona_trabajo_id
});
}

class Login2 extends StatefulWidget {
  const Login2({super.key});

  @override
  State<Login2> createState() => _Login2State();
}

class _Login2State extends State<Login2> {
  double opacity = 0.0;
  String apiUsers = '';
  List<Usuario>usuarios= [];

  @override
  void initState() {
    super.initState();
    //getUsers();
    // Iniciar la animación de la opacidad después de 500 milisegundos
    Timer(Duration(milliseconds: 900), () {
      setState(() {
        opacity = 1;
      });
    });
  }

  String? LoggedInWith;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

 /* Future<dynamic>getUsers()async{
    var res = await http.get(
      Uri.parse(apiUsers),
      headers: {"Content-type": "application/json"},
    );
    try {
      if (res.statusCode == 200) {
        var data = json.decode(res.body);
        List<Usuario> tempUsuario = data.map<Usuario>((mapa) {
          return Usuario(
              id: mapa['id'],
              nombres: mapa['nombres'],
              apellidos: mapa['apellidos'],
              licencia: mapa['licencia'],
              dni: mapa['dni'],
              fecha_nacimiento: mapa['fecha_nacimiento'],
              nickname: mapa['nickname'],
              contrasena: mapa['contrasena'],
              email: mapa['email'],
              rol_id: mapa['rol_id'],
              codigo: mapa['codigo'],
              direccion: mapa['direccion'],
              direccion_empresa: mapa['direccion_empresa'],
              nombre_empresa: mapa['nombre_empresa'],
              ruc: mapa['ruc'],
              sexo: mapa['sexo'],
              saldo_beneficios:mapa['saldo_beneficios'],
              suscripcion: mapa['mapa'],
              telefono: mapa['telefono'],
              ubicacion: mapa['ubicacion'],
              frecuencia: mapa['frecuencia'],
              zona_trabajo_id: mapa['zona_trabajo_id']
              
              
          );
        }).toList();

        setState(() {
          usuarios = tempUsuario;
        });
      }
    } catch (e) {
      print('Error en la solicitud: $e');
      throw Exception('Error en la solicitud: $e');
    }
  }*/

  Future<dynamic> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential authResult =
          await _auth.signInWithCredential(credential);
      final User? user = authResult.user;
      LoggedInWith = "google";
      return user;
    } catch (e) {
      print('Error during Google sign-in: $e');
      return null;
    }
  }

  Future<dynamic> signInWithFacebook() async {
    // Inicia sesión con Facebook
    try {
      print("tengo hambre chamo");
      final LoginResult result = await FacebookAuth.instance.login();
      print("no he desayunado");
      if (result.status == LoginStatus.success) {
        final AccessToken? accessToken = result.accessToken;
        final AuthCredential credential =
            FacebookAuthProvider.credential(accessToken!.token);

        // Autentica con Firebase
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        final User? user = userCredential.user;
        LoggedInWith = "face";
        return user;
      }
    } catch (e) {
      print("aca?");
      print(e.toString());
      // Manejar el error
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final anchoActual = MediaQuery.of(context).size.width;
    final largoActual = MediaQuery.of(context).size.height;
    
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 234, 234, 255),
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
                height: MediaQuery.of(context).size.height/8,
                width: MediaQuery.of(context).size.width/2.25,
                child: Opacity(
                    opacity: 1,
                    child: Image.asset('lib/imagenes/logo_sol_tiny.png')),
              ),
             
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.only(left: 20),
                child: const Text(
                  "Llevando vida a tu hogar !",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20),
                child: const Text(
                  "Conoce la mejor agua del Sur.",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w100),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.only(left: 20),
                width: 200, //MediaQuery.of(context).size.width*0.5,
                height: 30, //MediaQuery.of(context).size.height * 0.5,
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
                height: 30, //MediaQuery.of(context).size.height * 0.5,
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
              Container(
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
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20),
                child: ElevatedButton(
                  onPressed: () {
                    print(largoActual);
                    print(anchoActual);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Formu()),
                    );
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 1, 61, 109))),
                  child: const Text(
                    "Registrar",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w300),
                  ),
                ),
              ),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () async {
                        User? user = await signInWithGoogle();
                        if (user != null) {
                          print(user);
                          print('Usuario autenticado con Google:');
                          print('UID: ${user.uid}');
                          print('Nombre: ${user.displayName}');
                          print('Correo Electrónico: ${user.email}');
                          print('${user.uid}');
                          // Resto de tu código...
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Hola(
                                      url: user.photoURL,
                                      LoggedInWith: LoggedInWith)));
                        } else {
                          print(
                              'Inicio de sesión con Google cancelado o error');
                        }
                        print("ooog");
                      },
                      child: Image.asset(
                        'lib/imagenes/google.png',
                        width: 30,
                        height: 30,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: () async {
                        /*print("face");*/
                        User? user = await signInWithFacebook();
                        print(user);
                        if (user != null) {
                          // Navegar a la siguiente pantalla o realizar acciones después del inicio de sesión
                          print(user);
                          print('Usuario autenticado con Facebook:');
                          print('UID: ${user.uid}');
                          print('Nombre: ${user.displayName}');
                          print('Correo Electrónico: ${user.email}');
                          print('${user.uid}');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Hola(
                                      url: user.photoURL,
                                      LoggedInWith: LoggedInWith)));
                        } else {
                          print(
                              'Inicio de sesión con Facebook cancelado o error');
                        }
                        print("ooog");
                      },
                      child: Image.asset(
                        'lib/imagenes/facebook.png',
                        width: 30,
                        height: 30,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: Center(
                  child: Container(
                        
                    //color: Colors.red,
                    height: MediaQuery.of(context).size.height/3,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(left: 20, right: 20,bottom: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                        image:const DecorationImage(
                            image: AssetImage('lib/imagenes/parejitajoven.jpg'),
                            fit: BoxFit.fill)),
                    // padding: EdgeInsets.all(20),
                    // child: Image.asset('lib/imagenes/BIDON7.png'),
                  ),
                ),
              ),
              
            ],
          ),
        ),
      ),
      //),
    );
  }
}
