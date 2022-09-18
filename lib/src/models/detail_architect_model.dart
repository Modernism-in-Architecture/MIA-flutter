import '../helpers.dart';

class DetailArchitectModel {
  DetailArchitectModel({
    required this.id,
    required this.lastName,
    required this.firstName,
    required this.birthDay,
    required this.birthPlace,
    required this.birthCountry,
    required this.deathDay,
    required this.deathPlace,
    required this.deathCountry,
    required this.description,
    required this.relatedBuildings,
    required this.absoluteURL,
  });

  int id;
  String lastName;
  String firstName;
  String birthDay;
  String birthPlace;
  String birthCountry;
  String deathDay;
  String deathPlace;
  String deathCountry;
  String description;
  List<RelatedBuilding> relatedBuildings;
  String absoluteURL;


  factory DetailArchitectModel.fromJson(Map<String, dynamic> json) =>
      DetailArchitectModel(
        id: json["id"],
        lastName: convertToUTF8(json["lastName"]),
        firstName: convertToUTF8(json["firstName"]),
        birthDay: json["birthDay"],
        birthPlace: convertToUTF8(json["birthPlace"]),
        birthCountry: convertToUTF8(json["birthCountry"]),
        deathDay: convertToUTF8(json["deathDay"]),
        deathPlace: convertToUTF8(json["deathPlace"]),
        deathCountry: convertToUTF8(json["deathCountry"]),
        description: convertToUTF8(json["description"]),
        relatedBuildings: List<RelatedBuilding>.from(json["relatedBuildings"].map((x) => RelatedBuilding.fromJson(x))),
        absoluteURL: json["absoluteURL"],
      );

}

class RelatedBuilding {
  RelatedBuilding({
    required this.id,
    required this.name,
    required this.yearOfConstruction,
    required this.city,
    required this.country,
    required this.latitude,
    required this.longitude,
  });

  int id;
  String name;
  String yearOfConstruction;
  String city;
  String country;
  double latitude;
  double longitude;

  factory RelatedBuilding.fromJson(Map<String, dynamic> json) => RelatedBuilding(
    id: json["id"],
    name: convertToUTF8(json["name"]),
    yearOfConstruction: json["yearOfConstruction"],
    city: convertToUTF8(json["city"]),
    country: convertToUTF8(json["country"]),
    latitude: json["latitude"].toDouble(),
    longitude: json["longitude"].toDouble(),
  );

}