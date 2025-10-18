import 'package:share_plus/share_plus.dart';
import 'dart:convert';

import 'package:location/location.dart';



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

Future<void> shareInformation(String sharingURL, String architect) async {
  String architectName = architect.trim();
  String msgText = architectName.isNotEmpty
      ? 'architect $architectName'
      : 'building';
  final msg = 'Check out this amazing modernist $msgText!\n'
      '$sharingURL\n\n'
      'Sent with ❤️ from my MIA app for Android.\n'
      'Get it on Google Play';

  final params = ShareParams(
    text: msg,
    title: 'Modernism in Architecture',
  );

  await SharePlus.instance.share(params);
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
