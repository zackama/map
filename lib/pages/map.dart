import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'api_service.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapV extends StatefulWidget {
  MapV({super.key});

  @override
  State<MapV> createState() => _MapVState();
}

class _MapVState extends State<MapV> {
  final ApiService apiService = ApiService();

  Future<List<dynamic>?>? getUsers() async {
    var addr = Uri.parse("https://api.npoint.io/b181a1cad095f3ac8132");
    var res = await http.get(addr);

    if (res.statusCode == 200) {
      var users = jsonDecode(res.body);
      return users;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Map View"),
        ),
        backgroundColor: const Color.fromARGB(255, 90, 153, 184),
      ),
      body: Container(
        child: FutureBuilder<List<dynamic>?>(
          future: getUsers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                final markers = (snapshot.data as List<dynamic>)
                    .map((user) => Marker(
                          width: 80.0,
                          height: 80.0,
                          point: LatLng(user['Latitude'], user['Longitude']),
                          child: GestureDetector(
                            onTap: () {
                              // Use a function to show a dialog or a custom widget
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(user['SiteName']),
                                    content: Text(
                                        'Work Order Number: ${user['WorkOrderNumber']}'),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('Close'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Icon(
                              Icons.pin_drop_rounded,
                              color: user['IsOpen'] ? Colors.blue : Colors.red,
                              size: 35,
                            ),
                          ),
                        ))
                    .toList();

                return FlutterMap(
                  options: MapOptions(
                    initialZoom: 11.0,
                    minZoom: 3,
                    maxZoom: 18,
                    initialCenter: const LatLng(24.6455021, 46.7026293),
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.app',
                    ),
                    MarkerLayer(markers: markers),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}