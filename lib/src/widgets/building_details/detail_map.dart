import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../../providers.dart';
import '../loading_screen.dart';


class DetailMap extends ConsumerStatefulWidget {
  const DetailMap({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.previewImage,
  });
  final double latitude;
  final double longitude;
  final String previewImage;

  @override
  DetailMapState createState() => DetailMapState();
}

class DetailMapState extends ConsumerState<DetailMap> {
  final MapController mapController = MapController();

  @override
  Widget build(BuildContext context) {

    final markers = <Marker>[
      Marker(
        point: LatLng(widget.latitude, widget.longitude),
        child: GestureDetector(
          onTap: () {
            ref.read(mapLocation.notifier).state = MapLocation(
              latitude: widget.latitude, longitude: widget.longitude
            );
            ref.read(selectedViewIndex.notifier).state = 1;
            ref.read(appBarTitleProvider.notifier).state = titles[1];
            Navigator.popUntil(context, ModalRoute.withName("/"));
          },
          child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue[900]!.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 3),
                  ),
                ],
                border: Border.all(
                  color: Colors.blue[900]!,
                  width: 1.5,
                ),
              ),
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: widget.previewImage,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(child: LoadingScreen()),
                  errorWidget: (context, url, error) => Center(
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Image.asset("lib/assets/images/mia-logo.png"),
                    ),
                  ),
                ),
              )
          ),
        ),
      )
    ];

    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: Column(
            children: [
              SizedBox(
                  height: 200,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: FlutterMap(
                          key: ValueKey(MediaQuery.of(context).orientation),
                          options: MapOptions(
                              center: LatLng(widget.latitude, widget.longitude),
                              zoom: 13,
                              maxZoom: 15,
                              minZoom: 3,
                          ),
                          children: [
                            TileLayer(
                              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                              userAgentPackageName: 'org.architecture-in-modernism',
                            ),
                            MarkerLayer(
                                markers: markers
                            ),
                          ],
                      )
                  )
              )
            ]
        )
    );
  }
}
