import 'dart:convert';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:mia/src/models/detail_building_model.dart';
import 'package:mia/src/network/constants.dart';
import 'package:mia/src/models/list_building_model.dart';


String get miaApiToken => dotenv.env['MIA_API_TOKEN'] ?? 'API TOKEN NOT FOUND';

Map<String, String> _header = <String, String>{
  "Authorization": "Token $miaApiToken"
};

class ApiService {
  Future<List<ListBuildingModel>> getBuildings() async {
    late Future<List<ListBuildingModel>> listBuildings = [] as Future<List<ListBuildingModel>>;
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.apiVersionPath + ApiConstants.buildingListEndpoint);
      var response = await http.get(
          url,
          headers: _header,
      );
      if (response.statusCode == 200) {
        log("BUILDING LIST API CALL MADE");
        var jsonResponse = json.decode(response.body);
        List<dynamic> data = jsonResponse["data"];
        return data.map((buildings) => ListBuildingModel.fromJson(buildings)).toList();
      }
    } catch (e) {
      log(e.toString());
    }
    return listBuildings;
  }

  Future<DetailBuildingModel> getBuildingDetails(int buildingId) async {
    late Future<DetailBuildingModel> building = {} as Future<DetailBuildingModel>;
    try {
      var url = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.apiVersionPath}${ApiConstants.buildingListEndpoint}$buildingId/");
      var response = await http.get(
        url,
        headers: _header,
      );
      if (response.statusCode == 200) {
        log("DETAIL API CALL MADE");
        Map<String, dynamic> buildingData = jsonDecode(response.body)["data"] as Map<String, dynamic>;
       return DetailBuildingModel.fromJson(buildingData);
      }
    } catch (e) {
      log(e.toString());
    }
    return building;
  }
}

final apiProvider = Provider<ApiService>((ref) => ApiService());