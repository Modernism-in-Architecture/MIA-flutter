import 'package:flutter/material.dart';

import '../../views/building_detail_view.dart';


class MapMarker extends StatefulWidget{
  const MapMarker({Key? key, required this.buildingId}) : super(key: key);
  final int buildingId;

  @override
  State<MapMarker> createState() => MapMarkerState();
}


class MapMarkerState extends State<MapMarker> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Icon(
        Icons.location_on,
        color: Colors.blue[900],
        size: 42.0,
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BuildingDetailView(buildingId: widget.buildingId),
          ),
        );
      },
    );
  }
}









