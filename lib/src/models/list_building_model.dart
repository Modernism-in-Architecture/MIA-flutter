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
    required this.previewImage,
  });

  int id;
  String name;
  String city;
  String country;
  double latitude;
  double longitude;
  String buildingType;
  String feedImage;
  String previewImage;


  factory ListBuildingModel.fromJson(Map<String, dynamic> json) =>
      ListBuildingModel(
        id: json["id"],
        name: (json['name'] as String?) ?? '',
        city: (json['city'] as String?) ?? '',
        country: (json['country'] as String?) ?? '',
        latitude: json["latitude"],
        longitude: json["longitude"],
        buildingType: (json['buildingType'] as String?) ?? '',
        feedImage: (json['feedImage'] as String?) ?? '',
        previewImage: (json['previewImage'] as String?) ?? '',
      );
}
