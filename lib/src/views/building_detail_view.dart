import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mia/src/widgets/loading_screen.dart';

import '../models/detail_building_model.dart';
import '../network/api_client.dart';


class BuildingDetailView extends ConsumerStatefulWidget {
  const BuildingDetailView({Key? key, required this.buildingId}) : super(key: key);
  final int buildingId;

  @override
  BuildingDetailViewState createState() => BuildingDetailViewState();

}

class BuildingDetailViewState extends ConsumerState<BuildingDetailView> {

  late Future<DetailBuildingModel> building;

  Future<DetailBuildingModel> _getBuildingDetails(buildingId) async{
    return ref.read(apiProvider).getBuildingDetails(buildingId);
  }

  @override
  void initState() {
    super.initState();
    building = _getBuildingDetails(widget.buildingId);
  }

  @override
  Widget build(BuildContext context) {

    return Center(
      child: FutureBuilder<DetailBuildingModel>(
        future: building,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              body: Center(child: Text(snapshot.data!.name)),
              appBar: AppBar(title: Text(snapshot.data!.name), backgroundColor: Colors.black,),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const LoadingScreen();
        },
      ),
    );
  }
}