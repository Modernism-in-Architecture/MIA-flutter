List<ListBuildingModel> listBuildingModelFromJson(List dynamic) =>
    List<ListBuildingModel>.from(dynamic.map((building) => ListBuildingModel.fromJson(building)));

class ListBuildingModel {
  ListBuildingModel({
    required this.id,
    required this.name,
    required this.city,
    required this.country,
    required this.buildingType,
    required this.feedImage,
  });

  int id;
  String name;
  String city;
  String country;
  String buildingType;
  String feedImage;


  factory ListBuildingModel.fromJson(Map<String, dynamic> json) =>
      ListBuildingModel(
        id: json["id"],
        name: json["name"],
        city: json["city"],
        country: json["country"],
        buildingType: json["buildingType"],
        feedImage: json["feedImage"],
      );
}