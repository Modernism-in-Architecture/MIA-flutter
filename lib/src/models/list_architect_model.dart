import '../helpers.dart';

List<ListArchitectModel> listArchitectModelFromJson(List dynamic) =>
    List<ListArchitectModel>.from(dynamic.map((architect) => ListArchitectModel.fromJson(architect)));

class ListArchitectModel {
  ListArchitectModel({
    required this.id,
    required this.lastName,
    required this.firstName,
  });

  int id;
  String lastName;
  String firstName;


  factory ListArchitectModel.fromJson(Map<String, dynamic> json) =>
      ListArchitectModel(
        id: json["id"],
        lastName: convertToUTF8(json["lastName"]),
        firstName: convertToUTF8(json["firstName"]),
      );
}
