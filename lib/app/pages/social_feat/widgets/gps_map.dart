import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MapWidget extends StatefulWidget {
  MapWidget({Key? key}) : super(key: key);

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final _mapController = MapController();

  List<LatLng> _latLngList = [
    LatLng(54, 9),
    LatLng(53, 10),
    LatLng(52, 11),
    LatLng(49, 15),
    LatLng(50.0329, 15.7774),
    LatLng(13.17, 77.55),
  ];

  Future _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
  }
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Marker> _markers = _latLngList
        .map((point) => Marker(
              point: point,
              width: 60,
              height: 60,
              builder: (context) => Icon(
                Icons.pin_drop,
                size: 60,
                color: Colors.blueAccent,
              ),
            ))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              screenSize: MediaQuery.of(context).size,
              bounds: LatLngBounds.fromPoints([
                LatLng(0, 15.34),
                LatLng(49.43, 15.34),
              ]),
              zoom: 10,
              interactiveFlags: InteractiveFlag.all & ~InteractiveFlag.rotate,
              center: LatLng(49.43, 15.34),
            ),
            nonRotatedChildren: [



              MarkerLayer(
                markers: _markers,
              ),
            ],
            children: [
              TileLayer(
                urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c'],
                userAgentPackageName: 'cz.albi.hry.albi_hry',
              ),
              CurrentLocationLayer(
                style: LocationMarkerStyle(
                  marker: const DefaultLocationMarker(
                    color: Colors.green,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                  markerSize: const Size.square(40),
                  accuracyCircleColor: Colors.green.withOpacity(0.1),
                  headingSectorColor: Colors.green.withOpacity(0.8),
                  headingSectorRadius: 120,
                ),
                moveAnimationDuration: Duration.zero, // disable animation
              ),

            ],
          ),
        ],
      ),
    );
  }
}
