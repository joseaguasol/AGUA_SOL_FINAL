import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_final_desktop/components/empleado/armado.dart';
import 'package:app_final_desktop/components/empleado/inicio.dart';

String apiUsers = 'http://127.0.0.1:8004/api/login';

class UserData {
  final int roleId;
  final String username;
  final String name;
  final String lastName;
  final String dni;

  UserData({
    required this.roleId,
    required this.username,
    required this.name,
    required this.lastName,
    required this.dni,
  });

  // Método para convertir el objeto a un mapa JSON
  Map<String, dynamic> toJson() {
    return {
      'rol_id': roleId,
      'nickname': username,
      'nombres': name,
      'apellidos': lastName,
      'dni': dni,
    };
  }

  // Método para crear una instancia del objeto desde un mapa JSON
  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      roleId: json['rol_id'],
      username: json['nickname'],
      name: json['nombres'],
      lastName: json['apellidos'],
      dni: json['dni'],
    );
  }
}

class Login1 extends StatefulWidget {
  const Login1({Key? key}) : super(key: key);

  @override
  State<Login1> createState() => _Login1State();
}

// Método para guardar el objeto UserData en SharedPreferences
Future<void> saveUserData(UserData userData) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('userData', jsonEncode(userData.toJson()));
  print("resultado:");
  print(prefs.getString('userData'));
}

Future<UserData?> getUserData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userDataString = prefs.getString('userData');

  if (userDataString != null) {
    // Convertir el JSON a un mapa y luego a una instancia de UserData
    Map<String, dynamic> userDataMap = json.decode(userDataString);
    return UserData.fromJson(userDataMap);
  }

  return null;
}

class _Login1State extends State<Login1> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> _login() async {
    try {
      final response = await http.post(
        Uri.parse(apiUsers),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'nickname': usernameController.text,
          'contrasena': passwordController.text,
        }),
      );

      print('Cuerpo de la respuesta: ${response.body}');

      if (response.statusCode == 200) {
        // Parsear la respuesta JSON
        Map<String, dynamic>? jsonResponse = json.decode(response.body);

        // Obtener valores del usuario
        int roleId = jsonResponse!['rol_id'];
        String username = jsonResponse['nickname'];
        String name = jsonResponse['nombres'];
        String lastName = jsonResponse['apellidos'];
        String dni = jsonResponse['dni'];

        // Crear instancia del objeto UserData
        UserData userData = UserData(
          roleId: roleId,
          username: username,
          name: name,
          lastName: lastName,
          dni: dni,
        );

        // Guardar el objeto UserData en SharedPreferences
        await saveUserData(userData);

        // Redirigir según el valor de rol_id
        if (roleId == 2) {
          // Redirigir a una página específica para el rol 2
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Armado()),
          );
        } else if (roleId == 1 || roleId == 3) {
          // Redirigir a otra página para otros roles
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Inicio()),
          );
        }
      } else {
        // Manejar errores de inicio de sesión aquí
        print(
            'Error al iniciar sesión. Código de estado: ${response.statusCode}');
      }
    } catch (e) {
      print('Error en la solicitud POST: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Campo de usuario
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'Usuario',
              ),
            ),
            SizedBox(height: 16.0),

            // Campo de contraseña
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Contraseña',
              ),
            ),
            SizedBox(height: 16.0),

            // Botón de inicio de sesión
            ElevatedButton(
              onPressed: _login,
              child: Text('Iniciar sesión'),
            ),
            SizedBox(height: 8.0),

            // Enlace de olvido de contraseña
            TextButton(
              onPressed: () {
                print("¿Olvidaste tu contraseña?");
              },
              child: Text('¿Olvidaste tu contraseña?'),
            ),
          ],
        ),
      ),
    );
  }
}
