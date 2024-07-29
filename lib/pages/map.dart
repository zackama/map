import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_marker_cluster_2/flutter_map_marker_cluster.dart';

class MapV extends StatefulWidget {
  @override
  State<MapV> createState() => _MapVState();
}

class _MapVState extends State<MapV> {
  List<LatLng> tappedPoints = [
    const LatLng(24.6455021, 46.7026293),
    const LatLng(24.6829613, 46.7751984),
    const LatLng(24.5846596, 46.596848),
    const LatLng(24.6455641, 46.7025137),
    const LatLng(24.8514205, 46.6604173),
    const LatLng(24.6776421, 46.6934988),
    const LatLng(24.6366172, 46.5585161),
    const LatLng(24.694337, 46.7207966),
    const LatLng(24.8177651, 46.610498),
    const LatLng(24.7568433, 46.6889917),
  ];
  @override
  Widget build(BuildContext context) {
    final markers = tappedPoints
    .map((LatLng)=>Marker(
      point: LatLng, 
     child: const Icon(Icons.pin_drop,
     color: Colors.red,
     size: 40,),
     ))
     .toList();
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Map View"),
        ),
        backgroundColor: const Color.fromARGB(255, 90, 153, 184),
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialZoom: 11.0,
              minZoom: 3,
              maxZoom: 18,
              initialCenter: const LatLng(24.6455021, 46.7026293),
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
             
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: [
                      LatLng(24.38, 46.43),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
