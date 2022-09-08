import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/list_building_model.dart';
import '../network/api_client.dart';
import '../widgets/building_list/building_list_card.dart';


class BuildingsListView extends ConsumerStatefulWidget {
  const BuildingsListView({Key? key}) : super(key: key);

  @override
  BuildingsListViewState createState() => BuildingsListViewState();
}

class BuildingsListViewState extends ConsumerState<BuildingsListView> {
  late Future<List<ListBuildingModel>> _listBuildings;

  Future<List<ListBuildingModel>> _getListBuildingsData() async {
    List<ListBuildingModel> buildings = (await ApiService().getBuildings());
    await Future.delayed(const Duration(milliseconds: 500));
    return Future.value(buildings);
  }

  @override
  void initState() {
    super.initState();
    _listBuildings = _getListBuildingsData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ListBuildingModel>>(
      future: _listBuildings,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var buildings = snapshot.data!;
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return _buildListView(buildings);
            default:
              return _buildLoadingScreen();
          }
        } else {
          return _buildLoadingScreen();
        }
      },
    );
  }

  Widget _buildListView(List<ListBuildingModel> buildings) {
      return ListView.builder(
        itemBuilder: (context, index) {
          return BuildingListCard(listBuilding: buildings[index]);
        },
        itemCount: buildings.length,
      );
    }

    Widget _buildLoadingScreen() {
      return const Center(
        child: SizedBox(
          width: 50,
          height: 50,
          child: CircularProgressIndicator(),
        ),
      );
    }
}
