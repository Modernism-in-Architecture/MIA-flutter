import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mia/src/widgets/custom_title_bar.dart';

import 'models/list_architect_model.dart';
import 'models/list_building_model.dart';
import 'network/mia_api_client.dart';
import 'package:path_provider/path_provider.dart';

List titles = ["Buildings", "Places", "Architects", "Bookmarks"];

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

class Bookmarks<StateProvider> {
  List<int> _bookmarks = [];
  List<int> get bookmarks => _bookmarks;

  Future<void> loadBookmarks() async {
    try {
      final file = await _localFile;
      String jsonString = await file.readAsString();
      List<dynamic> jsonData = jsonDecode(jsonString);
      _bookmarks = jsonData.whereType<int>().map((e) => e).toList();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> saveBookmarks() async {
    try {
      final file = await _localFile;
      String jsonString = jsonEncode(_bookmarks);
      await file.writeAsString(jsonString);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void addBookmark(int bookmark) {
    _bookmarks.add(bookmark);
    saveBookmarks();
  }

  void removeBookmark(int bookmark) {
    _bookmarks.remove(bookmark);
    saveBookmarks();
  }
}

final locationPermissionGrantedByUser = StateProvider<bool>((ref) {
  return false;
});

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

GlobalKey globalKey = GlobalKey();
final scaffoldHomeViewKey = Provider<GlobalKey>((ref) {
  return globalKey;
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

final appBarIcon = StateProvider<Icon>((ref) {
  return const Icon(CupertinoIcons.search);
});

final appBarType = StateProvider<Widget>((ref) {
  return const CustomTitleBar();
});

final buildingsListDataProvider = FutureProvider<List<ListBuildingModel>>((ref) async {
  return ref.read(miaApiProvider).getBuildings();
});

final architectsListDataProvider = FutureProvider<List<ListArchitectModel>>((ref) async {
  return ref.read(miaApiProvider).getArchitects();
});

final bookmarksProvider = StateProvider<Bookmarks>((ref) {
  return Bookmarks();
});
