import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:mia/src/views/home_view.dart';

import '../../../main.dart';
import '../../views/map_view.dart';


class DetailMap extends ConsumerStatefulWidget {
  const DetailMap({Key? key, required this.latitude, required this.longitude}) : super(key: key);
  final double latitude;
  final double longitude;

  @override
  DetailMapState createState() => DetailMapState();
}

class DetailMapState extends ConsumerState<DetailMap> {
  final MapController mapController = MapController();

  @override
  Widget build(BuildContext context) {

    final globalScaffold = ref.watch(scaffoldHomeViewKey);

    final markers = <Marker>[
      Marker(
        point: LatLng(widget.latitude, widget.longitude),
        builder: (context) => GestureDetector(
          child: const Icon(
                Icons.location_on,
                color: Colors.blue,
                size: 35.0,
              ),
          onTap: () {
            ref.read(mapLocation.notifier).state = MapLocation(
              latitude: widget.latitude, longitude: widget.longitude
            );
            ref.read(selectedViewIndex.notifier).state = 1;
            ref.read(appBarTitleProvider.notifier).state = titles[1];

            // Navigator.pushNamed(
            //     globalScaffold.currentContext!,
            //     RoutesName.homePage
            // );
            Navigator.pop(
              context,
              // globalScaffold.currentContext!,
              MaterialPageRoute(
                builder: (context) => const HomeView(),
              ),
            );
          },
        ),
      )
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
                  userAgentPackageName: 'org.architecture-in-modernism',
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
