import 'package:app_final/components/test/hola.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class Ubicacion extends StatefulWidget {
  const Ubicacion({super.key});

  @override
  State<Ubicacion> createState() => _UbicacionState();
}

class _UbicacionState extends State<Ubicacion> {
  bool _isloading = false;

  Future<void> currentLocation() async {
    var location = new Location();

    // bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    setState(() {
      _isloading = true;
    });
    // Verificar si el servicio de ubicación está habilitado
    var _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      // Solicitar habilitación del servicio de ubicación
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        // Mostrar mensaje al usuario indicando que el servicio de ubicación es necesario
        setState(() {
          _isloading = true;
        });
        return;
      }
    }

    // Verificar si se otorgaron los permisos de ubicación
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      // Solicitar permisos de ubicación
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        // Mostrar mensaje al usuario indicando que los permisos de ubicación son necesarios
        return;
      }
    }

    // Obtener la ubicación
    try {
      _locationData = await location.getLocation();

      print("----ubicación--");
      print(_locationData);
      // Aquí puedes utilizar la ubicación obtenida (_locationData)
    } catch (e) {
      // Manejo de errores, puedes mostrar un mensaje al usuario indicando que hubo un problema al obtener la ubicación.
      print("Error al obtener la ubicación: $e");
    } finally {
      setState(() {
        _isloading = false;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Hola()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Container(
              //width: 200,
              margin: const EdgeInsets.only(top: 80, right: 20),
              // color: Colors.red,
              child: Row(
                children: [
                  Expanded(
                    child: Container(),
                  ),
                  const Text("Mejora!",
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.w400)),
                ],
              ),
            ),
            const SizedBox(
              height: 0,
            ),
            Container(
              //width: 200,
              margin: const EdgeInsets.only(right: 20),
              //color: Colors.red,
              child: Row(
                children: [
                  Expanded(
                    child: Container(),
                  ),
                  const Text("Tú experiencia de entrega",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w300)),
                ],
              ),
            ),
            Container(
              //width: 200,
              margin: const EdgeInsets.only(right: 20),
              //color: Colors.red,
              child: Row(
                children: [
                  Expanded(
                    child: Container(),
                  ),
                  const Text("Déjanos saber tu ubicación",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w200)),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
                width: 150,
                height: 60,
                margin: const EdgeInsets.only(right: 20),
                //color: Colors.red,
                child: ElevatedButton(
                  onPressed: () {
                    currentLocation();
                  },
                  child: _isloading
                      ? CircularProgressIndicator()
                      : Text(
                          ">> Aquí",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w400),
                        ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 1, 59, 107))),
                )),
            //Expanded(child: Container()),
            const SizedBox(
              height: 80,
            ),
            Container(
              child: Opacity(
                  opacity: 0.9,
                  child: Image.asset('lib/imagenes/ubicacion.jpg')),
            ),
          ]),
        ),
      ),
    );
  }
}
