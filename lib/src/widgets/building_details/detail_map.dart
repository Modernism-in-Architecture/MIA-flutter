import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';


class DetailMap extends StatefulWidget {
  const DetailMap({Key? key, required this.latitude, required this.longitude}) : super(key: key);
  final double latitude;
  final double longitude;

  @override
  State<DetailMap> createState() => _DetailMapState();
}

class _DetailMapState extends State<DetailMap> {
  final MapController mapController = MapController();

  @override
  Widget build(BuildContext context) {
    final markers = <Marker>[
      Marker(
        width: 80.0,
        height: 80.0,
        point: LatLng(widget.latitude, widget.longitude),
        builder: (ctx) => const Icon(
          Icons.location_on,
          color: Colors.red,
          size: 35.0,
        ),
      ),

    ];

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          SizedBox(
            height: 200,
            child: FlutterMap(
              key: ValueKey(MediaQuery.of(context).orientation),
              options: MapOptions(
                  center: LatLng(widget.latitude, widget.longitude),
                  zoom: 13,
                  maxZoom: 15,
                  minZoom: 3,
              ),
              layers: [
                TileLayerOptions(
                  urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                  userAgentPackageName: 'dev.leaflet.flutter_map.example',
                ),
                MarkerLayerOptions(markers: markers),
              ],
            )
          )
        ]
      )
    );
  }
}
