import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:flutter_share_me/flutter_share_me.dart';


String convertToUTF8(String text) {
  List<int> bytes = text.toString().codeUnits;
  return utf8.decode(bytes);
}

String removeDiacritics(String str) {
  const diacritics =
      'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËĚèéêëěðČÇçčÐĎďÌÍÎÏìíîïĽľÙÚÛÜŮùúûüůŇÑñňŘřŠšŤťŸÝÿýŽž';
  const nonDiacritics =
      'AAAAAAaaaaaaOOOOOOOooooooEEEEEeeeeeeCCccDDdIIIIiiiiLlUUUUUuuuuuNNnnRrSsTtYYyyZz';

  for (int i = 0; i < diacritics.length; i++) {
    str = str.replaceAll(diacritics[i], nonDiacritics[i]);
  }

  return str;
}

class CustomIntent extends Intent {

}

void shareInformation(sharingURL, architect) {
  String architectName = architect;
  String msgText = "building";
  if (architectName != "") {
    msgText = "architect $architectName";
  }
  String msg =
      "Check out this amazing modernist $msgText!\n"
      "$sharingURL\n\n"
      "Sent with ❤️ from my MIA app for Android. "
      "Download it in your Google Play Store.";

  final FlutterShareMe flutterShareMe = FlutterShareMe();
  flutterShareMe.shareToSystem(msg: msg);
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
