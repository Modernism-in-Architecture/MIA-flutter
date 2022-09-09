import 'dart:convert';

import '../helpers.dart';

List<ListBuildingModel> listBuildingModelFromJson(List dynamic) =>
    List<ListBuildingModel>.from(dynamic.map((building) => ListBuildingModel.fromJson(building)));

class ListBuildingModel {
  ListBuildingModel({
    required this.id,
    required this.name,
    required this.city,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.buildingType,
    required this.feedImage,
  });

  int id;
  String name;
  String city;
  String country;
  double latitude;
  double longitude;
  String buildingType;
  String feedImage;


  factory ListBuildingModel.fromJson(Map<String, dynamic> json) =>
      ListBuildingModel(
        id: json["id"],
        name: convertToUTF8(json["name"]),
        city: convertToUTF8(json["city"]),
        country: convertToUTF8(json["country"]),
        latitude: json["latitude"],
        longitude: json["longitude"],
        buildingType: convertToUTF8(json["buildingType"]),
        feedImage: json["feedImage"],
      );
}
