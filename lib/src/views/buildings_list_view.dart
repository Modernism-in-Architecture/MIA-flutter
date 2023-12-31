import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../helpers.dart';
import '../models/list_building_model.dart';
import '../providers.dart';
import '../widgets/building_list/list_buildings_view.dart';
import '../widgets/loading_screen.dart';


class BuildingsListView extends ConsumerStatefulWidget {
  const BuildingsListView({super.key});

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
            removeDiacritics(building.name).toLowerCase().contains(removeDiacritics(searchQuery.toLowerCase())) ||
            removeDiacritics(building.city).toLowerCase().startsWith(removeDiacritics(searchQuery.toLowerCase())) ||
            removeDiacritics(building.country).toLowerCase().startsWith(removeDiacritics(searchQuery.toLowerCase()))
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
