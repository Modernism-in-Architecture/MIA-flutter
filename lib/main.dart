import 'package:flutter/material.dart';
import 'package:mia/src/models/list_architect_model.dart';
import 'package:mia/src/models/list_building_model.dart';
import 'package:mia/src/network/mia_api_client.dart';
import 'package:mia/src/views/architects_list_view.dart';
import 'package:mia/src/views/building_detail_view.dart';
import 'package:mia/src/views/buildings_list_view.dart';
import 'package:mia/src/views/home_view.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mia/src/widgets/custom_title_bar.dart';
import 'package:mia/src/views/map_view.dart';

List titles = ["Buildings", "Places", "Architects"];

class MapLocation {
  MapLocation({required this.longitude, required this.latitude});

  double? latitude;
  double? longitude;
}

final _defaultMapLocation = MapLocation(longitude: 12.3731, latitude: 51.3397);

final mapLocation = StateProvider<MapLocation>((ref) {
  return _defaultMapLocation;
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
  return const Icon(Icons.search);
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


Future<void> main() async {
  await dotenv.load();
  runApp(
      const ProviderScope(
        child: Mia()
      ),
  );
}


class Mia extends HookConsumerWidget {
  const Mia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const MaterialApp(
      title: 'Modernism in Architecture',
      home: HomeView(),
      // initialRoute: RoutesName.homePage,
      // onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
//
// class RoutesName {
//   static const String homePage = '/';
//   static const String mapPage = '/map';
//   static const String buildingListPage = '/buildings';
//   static const String buildingDetailPage = '/building_detail';
//   static const String architectListPage = '/architects';
// }
//
// class RouteGenerator {
//   static Route<dynamic> generateRoute(RouteSettings settings) {
//
//     final args = settings.arguments;
//
//     switch (settings.name) {
//       case RoutesName.homePage:
//         return _GeneratePageRoute(
//             widget: const HomeView(), routeName: settings.name!);
//       case RoutesName.buildingListPage:
//         return _GeneratePageRoute(
//             widget: const BuildingsListView(), routeName: settings.name!);
//       case RoutesName.buildingDetailPage:
//         return _GeneratePageRoute(
//             widget: BuildingDetailView(buildingId: args as int), routeName: settings.name!);
//       case RoutesName.mapPage:
//         return _GeneratePageRoute(
//             widget: const MapView(), routeName: settings.name!);
//       case RoutesName.architectListPage:
//         return _GeneratePageRoute(
//             widget: const ArchitectsListView(), routeName: settings.name!);
//       default:
//         return _GeneratePageRoute(
//             widget: const HomeView(), routeName: settings.name!);
//     }
//   }
// }
//
// class _GeneratePageRoute extends PageRouteBuilder {
//   final Widget widget;
//   final String routeName;
//
//   _GeneratePageRoute({required this.widget, required this.routeName})
//       : super(
//       settings: RouteSettings(name: routeName),
//       pageBuilder: (BuildContext context, Animation<double> animation,
//           Animation<double> secondaryAnimation) {
//         return widget;
//       },
//       transitionDuration: const Duration(milliseconds: 500),
//       transitionsBuilder: (BuildContext context,
//           Animation<double> animation,
//           Animation<double> secondaryAnimation,
//           Widget child) {
//         return SlideTransition(
//           textDirection: TextDirection.ltr,
//           position: Tween<Offset>(
//             begin: const Offset(1.0, 0.0),
//             end: Offset.zero,
//           ).animate(animation),
//           child: child,
//         );
//       });
// }
//
