import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../providers/club.provider.dart';

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
    final theme = Theme.of(context);
    final clubProvider = Provider.of<ClubProvider>(context);

    List<Marker> _markers1 = clubProvider.clubs
        .map((club) => Marker(
              point: LatLng(club.latitude, club.longitude),
              width: 50,
              height: 50,
              builder: (context) => Container(
                child: IconButton(
                  icon: const Icon(Icons.location_on),
                  color: Colors.blueAccent,
                  iconSize: 40,
                  onPressed: () {
                    print('Marker tapped');
                    //open dialog with club info
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text(club.name),
                              content: Text(club.description?? 'No description'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Close'))
                              ],
                            ));
                  },
                ),
              )
            ))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Map', style: theme.textTheme.headline4),
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              screenSize: MediaQuery.of(context).size,
              maxZoom: 18,
              minZoom: 5,
              maxBounds: LatLngBounds.fromPoints([
                LatLng(52.09662294502995, 11.260742187500002),
                LatLng(46.31242790407178, 20.566894531250004),
              ]),
              bounds: LatLngBounds.fromPoints([
                LatLng(51.09662294502995, 12.260742187500002),
                LatLng(48.31242790407178, 18.566894531250004),
              ]),
              zoom: 10,
              interactiveFlags: InteractiveFlag.all & ~InteractiveFlag.rotate,
              center: LatLng(49.43, 15.34),
            ),
            nonRotatedChildren: [



              MarkerLayer(
                markers: _markers1,
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
                    color: Colors.blueAccent,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                  markerSize: const Size.square(30),
                  headingSectorRadius: 80,
                ),
                moveAnimationDuration: Duration.zero, // disable animation
              ),

            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        shape: const CircleBorder(),
        onPressed: () async {
          Position position = await _getCurrentLocation();
          _mapController.move(LatLng(position.latitude, position.longitude), 15);
        },
        child: const Icon(Icons.my_location),
      )
    );
  }
}
