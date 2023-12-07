import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

const List<String> list = <String>[
  'Ruta 1',
  'Ruta 2',
  'Ruta 3',
  'Ruta 4',
  'Ruta 5',
  'Ruta 6',
  'Ruta 7'
];

const List<String> conductores = <String>[
  'Pedrito','Jhon','Luquitas'
];

const List<String> pedidos = <String>[
  'Pedido 1',
  'Pedido 2',
  'Pedido 3',
  'Pedido 4',
  'Pedido 5',
  'Pedido 6',
  'Pedido 7',
  'Pedido 8',
  'Pedido 9',
  'Pedido 10',
  'Pedido 11',
  'Pedido 12',
];

class ArmadoRuta extends StatefulWidget {
  const ArmadoRuta({Key? key}) : super(key: key);

  @override
  State<ArmadoRuta> createState() => _ArmadoRutaState();
}

class _ArmadoRutaState extends State<ArmadoRuta> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 215, 248),
      appBar: AppBar(
        title: Text('Armado de Rutas',textAlign: TextAlign.start,),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: pedidos.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Text(pedidos[index] + ':'),
                      DropdownMenu<String>(
                        initialSelection: list.first,
                        onSelected: (String? value) {
                          setState(() {
                            dropdownValue = value!;
                          });
                        },
                        dropdownMenuEntries: list
                            .map<DropdownMenuEntry<String>>(
                              (String value) => DropdownMenuEntry<String>(
                                value: value,
                                label: value,
                              ),
                            )
                            .toList(),
                      ),
                      const SizedBox(width: 15,),
                      DropdownMenu<String>(
                        initialSelection: conductores.first,
                        onSelected: (String? value) {
                          setState(() {
                            dropdownValue = value!;
                          });
                        },
                        dropdownMenuEntries: conductores
                            .map<DropdownMenuEntry<String>>(
                              (String value) => DropdownMenuEntry<String>(
                                value: value,
                                label: value,
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(15),
              width: double.infinity,
              height: double.infinity,
              child: FlutterMap(
                options: MapOptions(
                  initialCenter: LatLng(-16.4091667,-71.5691667),
                  initialZoom: 16,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.app',
                  ),
                  //MarkerLayer(markers:),
                  RichAttributionWidget(
                    attributions: [
                      TextSourceAttribution(
                        'OpenStreetMap contributors',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}