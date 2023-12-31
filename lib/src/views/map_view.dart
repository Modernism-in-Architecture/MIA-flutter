import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:mia/src/widgets/maps/default_marker.dart';

import '../providers.dart';
import '../widgets/loading_screen.dart';
import '../widgets/maps/map_marker.dart';

class MapView extends ConsumerStatefulWidget {
  const MapView({super.key});

  @override
  MapViewState createState() => MapViewState();
}

class MapViewState extends ConsumerState<MapView> {
  @override
  Widget build(BuildContext context) {
    final listBuildings = ref.watch(buildingsListDataProvider);
    final currentLocation = ref.watch(mapLocation);
    final userLocation = ref.watch(currentUserLocation);
    final userGrantedLocationPermission = ref.watch(locationPermissionGrantedByUser);
    final MapController mapController = MapController();

    List<Marker> markers = [];

    listBuildings.when(
        data: (listBuildings) {
          for (final building in listBuildings) {
            markers.add(
               Marker(
                  point: LatLng(building.latitude, building.longitude),
                  child: MapMarker(buildingId: building.id),
              )
            );
          }
        },
        error: (err, s) => Text(err.toString()),
        loading: () => const LoadingScreen(),
    );

    List<Marker> getDefaultMarkerList () {
      List<Marker> defaultMarkerList = [];
      if (userGrantedLocationPermission) {
        defaultMarkerList.add(
            Marker(
              width: 80,
              height: 80,
              point: LatLng(
                  userLocation.latitude!,
                  userLocation.longitude!
              ),
              child: const DefaultLocationMarker(),
            )
        );
      }
      return defaultMarkerList;
    }

    return Stack(
      children: <Widget>[
        FlutterMap(
          mapController: mapController,
          options: MapOptions(
            initialCenter: LatLng(
                currentLocation.latitude!,
                currentLocation.longitude!
            ),
            interactionOptions: const InteractionOptions(
              flags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
            ),
            initialZoom: 14,
            maxZoom: 19,
            minZoom: 3,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'org.architecture-in-modernism',
            ),
            MarkerLayer(
                markers: getDefaultMarkerList()
            ),
            MarkerClusterLayerWidget(
              options: MarkerClusterLayerOptions(
                maxClusterRadius: 80,
                size: const Size(30, 30),
                markers: markers,
                builder: (context, markers) {
                  return FloatingActionButton(
                    heroTag: UniqueKey(),
                    backgroundColor: Colors.blue[900]!,
                    onPressed: null,
                    child: Text(
                        markers.length.toString(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                        )
                    ),
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: FloatingActionButton.small(
                  backgroundColor: Colors.blue[900]?.withOpacity(0.6),
                  onPressed: () {
                    mapController.move(
                        LatLng(
                            userLocation.latitude!,
                            userLocation.longitude!
                        ), 14);
                  },
                  child:
                    const Icon(
                      CupertinoIcons.location,
                      color: Colors.white60,
                  ),
                ),
              ),
            ),
          ],
        )
      ]
    );
  }
}
