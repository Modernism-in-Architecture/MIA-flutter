import 'dart:convert';

import 'package:location/location.dart';


String convertToUTF8(String text) {
  List<int> bytes = text.toString().codeUnits;
  return utf8.decode(bytes);
}

Future<LocationData?> getCurrentUserLocation() async {
  bool serviceEnabled;
  PermissionStatus permissionGranted;

  Location location = Location();

  serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) {
      return null;
    }
  }

  permissionGranted = await location.hasPermission();
  if (permissionGranted == PermissionStatus.denied) {
    permissionGranted = await location.requestPermission();
    if (permissionGranted != PermissionStatus.granted) {
      return null;
    }
  }

  return await location.getLocation();
}

