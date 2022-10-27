import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../main.dart';
import '../models/list_building_model.dart';
import '../widgets/building_list/list_buildings_view.dart';
import '../widgets/loading_screen.dart';


class BuildingsListView extends ConsumerStatefulWidget {
  const BuildingsListView({Key? key}) : super(key: key);

  @override
  BuildingsListViewState createState() => BuildingsListViewState();
}

class BuildingsListViewState extends ConsumerState<BuildingsListView> {

  @override
  Widget build(BuildContext context) {
    final listBuildings = ref.watch(buildingsListDataProvider);
    final searchQuery = ref.watch(searchQueryProvider);
    List<ListBuildingModel> resultBuildings = [];

    if (listBuildings.isLoading) {
      return const LoadingScreen();
    }

    // ToDo: Add error handling

    listBuildings.whenData((buildings) => {
        for (var building in buildings) {
          if (
            searchQuery.isEmpty ||
            building.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
            building.city.toLowerCase().startsWith(searchQuery.toLowerCase()) ||
            building.country.toLowerCase().startsWith(searchQuery.toLowerCase())
          ){
            resultBuildings.add(building)
          }
        }
    });

    if (resultBuildings.isEmpty) {
        return const Center(
            child: Text("Sorry, no results")
        );
    }

    return ListBuildingsView(listBuildings: resultBuildings);

  }
}
