import 'package:flutter/material.dart';
import 'package:mia/src/models/list_building_model.dart';

import 'building_list_card.dart';


class ListBuildingsView extends StatelessWidget{
  const ListBuildingsView({super.key, required this.listBuildings});

  final List<ListBuildingModel> listBuildings;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(14, 7, 14, 7),
      itemBuilder: (context, index) {
        return BuildingListCard(listBuilding: listBuildings[index]);
      },
      itemCount: listBuildings.length,
    );
  }
}
