import 'package:flutter/material.dart';

class MapView extends StatefulWidget {
  const MapView({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State <MapView> createState() => _MapState();
}

class _MapState extends State<MapView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Center(
          child: Text("This the Maps Screen", style: TextStyle(fontSize: 24),),
        )
      ],
    );
  }
}