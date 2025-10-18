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
        lastName: (json["lastName"] as String?) ?? '',
        firstName: (json["firstName"] as String?) ?? '',
        birthDay: json["birthDay"],
        birthPlace: (json["birthPlace"] as String?) ?? '',
        birthCountry: (json["birthCountry"] as String?) ?? '',
        deathDay: (json["deathDay"] as String?) ?? '',
        deathPlace: (json["deathPlace"] as String?) ?? '',
        deathCountry: (json["deathCountry"] as String?) ?? '',
        description: (json["description"] as String?) ?? '',
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
    name: (json["name"] as String?) ?? '',
    yearOfConstruction: json["yearOfConstruction"],
    city: (json["city"] as String?) ?? '',
    country: (json["country"] as String?) ?? '',
    latitude: json["latitude"].toDouble(),
    longitude: json["longitude"].toDouble(),
  );

}