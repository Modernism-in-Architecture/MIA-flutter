import '../helpers.dart';

class DetailBuildingModel {
  DetailBuildingModel({
    required this.id,
    required this.name,
    required this.yearOfConstruction,
    required this.isProtected,
    required this.address,
    required this.zipCode,
    required this.city,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.galleryImages,
    required this.subtitle,
    required this.todaysUse,
    required this.buildingType,
    required this.history,
    required this.description,
    required this.directions,
    required this.architects,
    required this.absoluteURL,
  });

  int id;
  String name;
  String yearOfConstruction;
  bool isProtected;
  String address;
  String zipCode;
  String city;
  String country;
  double latitude;
  double longitude;
  List<String> galleryImages;
  String subtitle;
  String todaysUse;
  String buildingType;
  String history;
  String description;
  String directions;
  List<Architect> architects;
  String absoluteURL;


  factory DetailBuildingModel.fromJson(Map<String, dynamic> json) =>
      DetailBuildingModel(
        id: json["id"],
        name: convertToUTF8(json["name"]),
        yearOfConstruction: json["yearOfConstruction"],
        isProtected: json["isProtected"],
        address: convertToUTF8(json["address"]),
        zipCode: json["zipCode"],
        city: convertToUTF8(json["city"]),
        country: convertToUTF8(json["country"]),
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        galleryImages: List<String>.from(json["galleryImages"].map((x) => x)),
        subtitle: convertToUTF8(json["subtitle"]),
        todaysUse: convertToUTF8(json["todaysUse"]),
        buildingType: convertToUTF8(json["buildingType"]),
        history: convertToUTF8(json["history"]),
        description: convertToUTF8(json["description"]),
        directions: convertToUTF8(json["directions"]),
        architects: List<Architect>.from(json["architects"].map((x) => Architect.fromJson(x))),
        absoluteURL: json["absoluteURL"],
      );

}

class Architect {
  Architect({
    required this.id,
    required this.lastName,
    required this.firstName,
  });

  int id;
  String lastName;
  String firstName;

  factory Architect.fromJson(Map<String, dynamic> json) => Architect(
    id: json["id"],
    lastName:  convertToUTF8(json["lastName"]),
    firstName:  convertToUTF8(json["firstName"]),
  );

}