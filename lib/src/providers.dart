import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hooks_riverpod/legacy.dart';
import 'models/list_architect_model.dart';
import 'models/list_building_model.dart';
import 'network/mia_api_client.dart';
import 'package:path_provider/path_provider.dart';

final List<String> titles = ["Buildings", "Places", "Architects", "Bookmarks"];

class MapLocation {
  MapLocation({required this.longitude, required this.latitude});
  double? latitude;
  double? longitude;
}

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/bookmarks.json');
}

class BookmarksNotifier extends AsyncNotifier<List<int>> {
  @override
  Future<List<int>> build() async {
    try {
      final file = await _localFile;
      if (await file.exists()) {
        final jsonString = await file.readAsString();
        final data = (jsonDecode(jsonString) as List).whereType<int>().toList();
        return data;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Bookmarks load error: $e');
      }
    }
    return <int>[];
  }

  Future<void> _save(List<int> list) async {
    try {
      final file = await _localFile;
      await file.writeAsString(jsonEncode(list));
    } catch (e) {
      if (kDebugMode) {
        print('Bookmarks save error: $e');
      }
    }
  }

  Future<void> add(int id) async {
    final current = List<int>.from(state.value ?? const <int>[]);
    if (!current.contains(id)) {
      current.add(id);
      state = AsyncData(current);
      await _save(current);
    }
  }

  Future<void> remove(int id) async {
    final current = List<int>.from(state.value ?? const <int>[]);
    if (current.remove(id)) {
      state = AsyncData(current);
      await _save(current);
    }
  }
}

final bookmarksProvider = AsyncNotifierProvider<BookmarksNotifier, List<int>>(
  () => BookmarksNotifier(),
);

final locationPermissionGrantedByUser = StateProvider<bool>((ref) => false);

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

final scaffoldHomeViewKey = Provider<GlobalKey<ScaffoldState>>((ref) {
  return GlobalKey<ScaffoldState>();
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

enum AppBarMode { title, search }

final appBarMode = StateProvider<AppBarMode>((ref) => AppBarMode.title);

final appBarIcon = Provider<IconData>((ref) {
  return ref.watch(appBarMode) == AppBarMode.title
      ? CupertinoIcons.search
      : CupertinoIcons.xmark_circle;
});

final buildingsListDataProvider =
FutureProvider.autoDispose<List<ListBuildingModel>>((ref) async {
  final link = ref.keepAlive();
  ref.onDispose(link.close);

  dev.log('START buildingsListDataProvider', name: 'MIA.PROV');
  ref.onDispose(() => dev.log('DISPOSE buildingsListDataProvider', name: 'MIA.PROV'));
  ref.onCancel(() => dev.log('CANCEL buildingsListDataProvider', name: 'MIA.PROV'));

  final api = ref.read(miaApiProvider);
  final data = await api.getBuildings();

  dev.log('DONE buildingsListDataProvider count=${data.length}', name: 'MIA.PROV');
  return data;
});

final architectsListDataProvider =
FutureProvider.autoDispose<List<ListArchitectModel>>((ref) async {
  final link = ref.keepAlive();
  ref.onDispose(link.close);

  dev.log('START architectsListDataProvider', name: 'MIA.PROV');
  ref.onDispose(() => dev.log('DISPOSE architectsListDataProvider', name: 'MIA.PROV'));
  ref.onCancel(() => dev.log('CANCEL architectsListDataProvider', name: 'MIA.PROV'));

  final api = ref.read(miaApiProvider);
  final data = await api.getArchitects();

  dev.log('DONE architectsListDataProvider count=${data.length}', name: 'MIA.PROV');
  return data;
});
