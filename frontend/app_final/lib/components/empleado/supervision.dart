import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'dart:math';

class Supervision extends StatefulWidget {
  const Supervision({Key? key}) : super(key: key);

  @override
  State<Supervision> createState() => _SupervisionState();
}

class _SupervisionState extends State<Supervision> {
  final List<LatLng> routeCoordinates = [
    LatLng(-16.40521646629229, -71.57102099896395), // Puente Fatima
    LatLng(-16.409123, -71.537864), // Punto A
    LatLng(-16.408621, -71.538210), // Punto B
    LatLng(-16.387654, -71.542098), // Punto J
    LatLng(-16.400123, -71.540256), // Punto A
    LatLng(-16.394276, -71.551809), // Punto B
    LatLng(-16.408932, -71.523482), // Punto C
    LatLng(-16.420765, -71.515688), // Punto D
    LatLng(-16.389632, -71.525739), // Punto E
    LatLng(-16.404123, -71.558394), // Punto F
    LatLng(-16.397475, -71.512548), // Punto G
    LatLng(-16.416789, -71.530956), // Punto H
    LatLng(-16.411234, -71.555720), // Punto I
    LatLng(-16.387654, -71.542098), // Punto J
    LatLng(-16.415245, -71.534607), // Punto A
    LatLng(-16.404910, -71.547812), // Punto B
    LatLng(-16.400892, -71.525317), // Punto C
    LatLng(-16.408546, -71.517649), // Punto D
    LatLng(-16.420590, -71.527074), // Punto E
    LatLng(-16.399976, -71.540883), // Punto F
    LatLng(-16.413621, -71.554457), // Punto G
    LatLng(-16.394760, -71.530665), // Punto H
    LatLng(-16.409975, -71.549272), // Punto I
    LatLng(-16.389543, -71.517308), // Punto J
  ];

  double calculateTotalDistance(List<LatLng> coordinates) {
    double totalDistance = 0;

    for (int i = 0; i < coordinates.length - 1; i++) {
      totalDistance += distanceBetweenCoordinates(
        coordinates[i].latitude,
        coordinates[i].longitude,
        coordinates[i + 1].latitude,
        coordinates[i + 1].longitude,
      );
    }

    return totalDistance;
  }

  double distanceBetweenCoordinates(
      double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371; // Radio de la Tierra en kilómetros

    double dLat = _degreesToRadians(lat2 - lat1);
    double dLon = _degreesToRadians(lon2 - lon1);

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degreesToRadians(lat1)) *
            cos(_degreesToRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);

    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = earthRadius * c; // Distancia en kilómetros

    return distance;
  }

  double _degreesToRadians(double degrees) {
    return degrees * (pi / 180);
  }

  void sortCoordinates(List<LatLng> coordinates) {
    for (int i = 0; i < coordinates.length - 1; i++) {
      int minIndex = i;
      double minDistance = double.infinity;
      // Buscar la coordenada más cercana excluyendo las ya ordenadas
      for (int j = i + 1; j < coordinates.length; j++) {
        double distance = distanceBetweenCoordinates(
          coordinates[i].latitude,
          coordinates[i].longitude,
          coordinates[j].latitude,
          coordinates[j].longitude,
        );

        if (distance < minDistance) {
          minDistance = distance;
          minIndex = j;
        }
      }
      LatLng temp = coordinates[minIndex];
      coordinates[minIndex] = coordinates[i + 1];
      coordinates[i + 1] = temp;
    }
  }

  @override
  Widget build(BuildContext context) {
    sortCoordinates(routeCoordinates);

    // Añadir una nueva coordenada a la lista después de ordenarla
    routeCoordinates.add(routeCoordinates.first);

    double totalDistance = calculateTotalDistance(routeCoordinates);

    List<Marker> markers = [];
    for (LatLng coordinate in routeCoordinates) {
      markers.add(
        Marker(
          width: 40.0,
          height: 40.0,
          point: coordinate,
          child: Container(
            child: Icon(
              Icons.location_pin,
              color: Colors.red,
              size: 40.0,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Ruta'),
      ),
      body: Stack(
        children: [
          Container(
            height: 400,
            width: double.infinity,
            child: FlutterMap(
              options: MapOptions(
                initialCenter: LatLng(-16.40521646629229,
                    -71.57102099896395), // Centro del mapa (California)
                initialZoom: 12.0, // Nivel de zoom
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                ),
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: routeCoordinates,
                      color: Colors.lightBlueAccent, // Color de la línea
                      strokeWidth: 3.0, // Ancho de la línea
                    ),
                  ],
                ),
                MarkerLayer(markers: markers),
              ],
            ),
          ),
          Positioned(
            top: 20,
            left: 20,
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Distancia Total: ${totalDistance.toStringAsFixed(2)} km',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}