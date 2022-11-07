import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../../main.dart';
import '../widgets/loading_screen.dart';
import '../widgets/maps/map_marker.dart';


class MapView extends ConsumerStatefulWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  MapViewState createState() => MapViewState();
}

class MapViewState extends ConsumerState<MapView> {

  @override
  Widget build(BuildContext context) {
    final listBuildings = ref.watch(buildingsListDataProvider);
    final currentLocation = ref.watch(mapLocation);
    List<Marker> markers = [];

    listBuildings.when(
        data: (listBuildings) {
          for (final building in listBuildings) {
            markers.add(
               Marker(
                  point: LatLng(building.latitude, building.longitude),
                  builder: (BuildContext context) {
                    return MapMarker(buildingId: building.id);
                }
              )
            );
          }
        },
        error: (err, s) => Text(err.toString()),
        loading: () => const LoadingScreen(),
    );

    return FlutterMap(
      layers: [
        TileLayerOptions(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: ['a', 'b', 'c'],
          userAgentPackageName: 'org.architecture-in-modernism',
        ),
        MarkerClusterLayerOptions(
          maxClusterRadius: 80,
          size: const Size(40, 40),
          fitBoundsOptions: const FitBoundsOptions(
            padding: EdgeInsets.all(50),
          ),
          markers: markers,
          polygonOptions: const PolygonOptions(
              borderColor: Colors.blueAccent,
              color: Colors.black12,
              borderStrokeWidth: 1
          ),
          builder: (context, markers) {
            return FloatingActionButton(
              heroTag: UniqueKey(),
              onPressed: null,
              child: Text(markers.length.toString()),
            );
          },
        ),
      ],
      options: MapOptions(
        plugins: [MarkerClusterPlugin(),],
        center: LatLng(currentLocation.latitude!, currentLocation.longitude!),
        interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
        zoom: 14,
        maxZoom: 19,
        minZoom: 3,
      ),
    );
  }
}
