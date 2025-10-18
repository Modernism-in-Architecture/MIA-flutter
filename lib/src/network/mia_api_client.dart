import 'dart:convert';
import 'dart:developer' as dev;

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

import 'package:mia/src/models/list_building_model.dart';
import 'package:mia/src/models/list_architect_model.dart';
import 'package:mia/src/models/detail_building_model.dart';
import 'package:mia/src/models/detail_architect_model.dart';
import 'package:mia/src/network/constants.dart';

class MiaApiService {
  MiaApiService({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  Map<String, String> get _headers {
    final token = dotenv.env['MIA_API_TOKEN'];
    if (token == null || token.isEmpty) {
      throw StateError('MIA_API_TOKEN is missing in .env');
    }
    return <String, String>{
      'Authorization': 'Token $token',
      'Accept': 'application/json',
    };
  }

  Uri _uri(String path) {
    final base = ApiConstants.baseUrl;
    final ver = ApiConstants.apiVersionPath;
    return Uri.parse('$base$ver$path');
  }

  dynamic _decodeJsonBytes(List<int> bytes) {
    try {
      return jsonDecode(utf8.decode(bytes));
    } on FormatException {
      return jsonDecode(latin1.decode(bytes));
    }
  }

  Future<List<ListBuildingModel>> getBuildings() async {
    final url = _uri(ApiConstants.buildingListEndpoint);
    final res = await _client.get(url, headers: _headers);
    dev.log('GET $url', name: 'MIA.NET');

    if (res.statusCode != 200) {
      dev.log('getBuildings failed: ${res.statusCode} ${res.reasonPhrase}',
          name: 'MIA.NET');
      throw Exception('Buildings request failed (${res.statusCode})');
    }

    final decoded = _decodeJsonBytes(res.bodyBytes);
    // expecting {"data": [ ... ]}
    final data = (decoded['data'] as List<dynamic>);

    return data
        .map((e) => ListBuildingModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<ListArchitectModel>> getArchitects() async {
    final url = _uri(ApiConstants.architectListEndpoint);
    final res = await _client.get(url, headers: _headers);

    if (res.statusCode != 200) {
      dev.log('getArchitects failed: ${res.statusCode} ${res.reasonPhrase}',
          name: 'MIA.NET');
      throw Exception('Architects request failed (${res.statusCode})');
    }

    final decoded = _decodeJsonBytes(res.bodyBytes);
    final data = (decoded['data'] as List<dynamic>);
    return data
        .map((e) => ListArchitectModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<DetailBuildingModel> getBuildingDetails(int buildingId) async {
    final url = Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.apiVersionPath}${ApiConstants.buildingListEndpoint}$buildingId/');
    final res = await _client.get(url, headers: _headers);

    if (res.statusCode != 200) {
      dev.log('getBuildingDetails($buildingId) failed: '
          '${res.statusCode} ${res.reasonPhrase}', name: 'MIA.NET');
      throw Exception('Building detail request failed (${res.statusCode})');
    }

    final decoded = _decodeJsonBytes(res.bodyBytes);
    final map = decoded['data'] as Map<String, dynamic>;
    return DetailBuildingModel.fromJson(map);
  }

  Future<DetailArchitectModel> getArchitectDetails(int architectId) async {
    final url = Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.apiVersionPath}${ApiConstants.architectListEndpoint}$architectId/');
    final res = await _client.get(url, headers: _headers);

    if (res.statusCode != 200) {
      dev.log('getArchitectDetails($architectId) failed: '
          '${res.statusCode} ${res.reasonPhrase}', name: 'MIA.NET');
      throw Exception('Architect detail request failed (${res.statusCode})');
    }

    final decoded = _decodeJsonBytes(res.bodyBytes);
    final map = decoded['data'] as Map<String, dynamic>;
    return DetailArchitectModel.fromJson(map);
  }
}

final miaApiProvider = Provider<MiaApiService>((ref) => MiaApiService());