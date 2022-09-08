import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../main.dart';
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
    return listBuildings.when(
        data: (listBuildings) {
          return ListBuildingsView(listBuildings: listBuildings);
        },
        error: (err, s) => Text(err.toString()),
        loading: () => const LoadingScreen(),
    );
  }
}
