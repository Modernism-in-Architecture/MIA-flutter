import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mia/src/widgets/custom_title_bar.dart';

import 'models/list_architect_model.dart';
import 'models/list_building_model.dart';
import 'network/mia_api_client.dart';

List titles = ["Buildings", "Places", "Architects"];

class MapLocation {
  MapLocation({required this.longitude, required this.latitude});

  double? latitude;
  double? longitude;
}

final locationPermissionGrantedByUser = StateProvider<bool>((ref) {
  return false;
});

final _defaultMapLocation = MapLocation(longitude: 12.3731, latitude: 51.3397);

final mapLocation = StateProvider<MapLocation>((ref) {
  return _defaultMapLocation;
});

final currentUserLocation = StateProvider<MapLocation>((ref) {
  return _defaultMapLocation;
});

final selectedArchitectId = StateProvider<String>((ref) {
  return "";
});

GlobalKey globalKey = GlobalKey();
final scaffoldHomeViewKey = Provider<GlobalKey>((ref) {
  return globalKey;
});

final appBarTitleProvider = StateProvider<String>((ref) {
  return titles[0];
});

final selectedViewIndex = StateProvider<int>((ref) {
  return 0;
});

final searchQueryProvider = StateProvider<String>((ref) {
  return "";
});

final appBarIcon = StateProvider<Icon>((ref) {
  return const Icon(Icons.search);
});

final appBarType = StateProvider<Widget>((ref) {
  return const CustomTitleBar();
});

final buildingsListDataProvider = FutureProvider<List<ListBuildingModel>>((ref) async {
  return ref.read(miaApiProvider).getBuildings();
});

final architectsListDataProvider = FutureProvider<List<ListArchitectModel>>((ref) async {
  return ref.read(miaApiProvider).getArchitects();
});
