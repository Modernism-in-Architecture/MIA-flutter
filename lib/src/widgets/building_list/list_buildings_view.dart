import 'package:flutter/material.dart';
import 'package:mia/src/models/list_building_model.dart';

import 'building_list_card.dart';


class ListBuildingsView extends StatelessWidget{
  const ListBuildingsView({Key? key, required this.listBuildings}) : super(key: key);

  final List<ListBuildingModel> listBuildings;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return BuildingListCard(listBuilding: listBuildings[index]);
      },
      itemCount: listBuildings.length,
    );
  }
}
