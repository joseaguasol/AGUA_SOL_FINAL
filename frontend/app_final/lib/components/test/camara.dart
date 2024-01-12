import 'package:app_final/components/test/holaconductor.dart';
import 'package:app_final/main.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class Camara extends StatefulWidget {
  const Camara({super.key});

  @override
  State<Camara> createState() => _CamaraState();
}

class _CamaraState extends State<Camara> {
  //late List<CameraDescription> camera;
  late CameraController cameraController;

  @override
  void initState() {
    super.initState();
    cameraController = CameraController(camera[0], ResolutionPreset.medium,
        enableAudio: false);

    cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void dispose() {
    cameraController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (cameraController.value.isInitialized) {
      return Scaffold(
          body: SafeArea(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      //mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 150,
                          margin: const EdgeInsets.only(top: 30, left: 20),
                          // color:Colors.grey,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text(
                                        "Una foto",
                                        style: TextStyle(
                                            fontSize: 29,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        "te ayuda ",
                                        style: TextStyle(fontSize: 35),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        "con tus registros",
                                        style: TextStyle(fontSize: 24),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(right: 20),
                                child: Image.asset('lib/imagenes/fotore.png'),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 20),
                          // color:Colors.grey,
                          child: Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 54,
                                width: 100,
                                child: const TextField(
                                  style: TextStyle(fontSize: 20),
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    labelText: 'S/. Monto',
                                    labelStyle: TextStyle(
                                        color: Color.fromARGB(255, 2, 31, 55)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 0, 44, 81))),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 1, 57, 103)),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              Container(
                                child: Text(
                                  "<< Ingresa la venta",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromARGB(255, 1, 31, 55)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 20, right: 0),
                          height: 300,
                          width: MediaQuery.of(context).size.width <= 480
                              ? 430
                              : 300,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 134, 129, 129),
                              borderRadius: BorderRadius.circular(20)),
                          // width: 300,
                          child: CameraPreview(cameraController),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 50, right: 50),
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: () {},
                                child: Text(
                                  "X",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        const Color.fromARGB(255, 2, 46, 83))),
                              ),
                              Container(
                                height: 60,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Icon(
                                    Icons.photo_camera,
                                    color: Colors.white,
                                  ),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              const Color.fromARGB(
                                                  255, 2, 46, 83))),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                ),
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        const Color.fromARGB(255, 2, 46, 83))),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 20),
                          height: 89,
                          //color:Colors.grey,
                          child: Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 60,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const HolaConductor()),
                                    );
                                  },
                                  child: Text(
                                    "<< Menu",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              const Color.fromARGB(
                                                  255, 0, 31, 56))),
                                ),
                              ),
                              const SizedBox(
                                width: 25,
                              ),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Genial!",
                                      style: TextStyle(fontSize: 29),
                                    ),
                                    Text(
                                      "sigamos con los pedidos",
                                      style: TextStyle(
                                          fontSize: 23,
                                          fontWeight: FontWeight.w300),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]))));
    } else {
      return Scaffold(
        body: Container(
          child: Center(
              child: Text(
            "...Detectando Cámara",
            style: TextStyle(fontSize: 30),
          )),
        ),
      );
    }
  }
}
