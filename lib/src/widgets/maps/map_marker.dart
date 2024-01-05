import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../views/building_detail_view.dart';
import '../loading_screen.dart';


class MapMarker extends StatefulWidget{
  const MapMarker({
    super.key,
    required this.buildingId,
    required this.previewImage,
    required this.name,
  });
  final int buildingId;
  final String previewImage;
  final String name;

  @override
  State<MapMarker> createState() => MapMarkerState();
}


class MapMarkerState extends State<MapMarker> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BuildingDetailView(
                buildingId: widget.buildingId
            ),
          ),
        );
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
    );
  }
}









