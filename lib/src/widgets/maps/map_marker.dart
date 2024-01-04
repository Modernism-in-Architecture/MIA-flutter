import 'package:flutter/material.dart';

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
              child: Image.network(
                  widget.previewImage,
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return const Center(child: LoadingScreen());
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                        child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Image.asset("lib/assets/images/mia-logo.png")
                        )
                    );
                  },
              ),
          )
      ),
    );
  }
}









