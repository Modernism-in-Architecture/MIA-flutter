import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:html/parser.dart';
import 'package:mia/src/models/list_building_model.dart';
import 'package:mia/src/widgets/loading_screen.dart';
import '../../main.dart';
import '../models/detail_architect_model.dart';
import '../network/mia_api_client.dart';
import '../widgets/building_details/section_header.dart';
import '../widgets/building_details/section_text_content.dart';
import '../widgets/building_list/building_list_card.dart';


class ArchitectDetailView extends ConsumerStatefulWidget {
  const ArchitectDetailView({Key? key, required this.architectId}) : super(key: key);
  final int architectId;

  @override
  ArchitectDetailViewState createState() => ArchitectDetailViewState();

}

class ArchitectDetailViewState extends ConsumerState<ArchitectDetailView> {

  late Future<DetailArchitectModel> architect;

  Future<DetailArchitectModel> _getArchitectDetails(architectId) async{
    return ref.read(miaApiProvider).getArchitectDetails(architectId);
  }

  @override
  void initState() {
    super.initState();
    architect = _getArchitectDetails(widget.architectId);
  }

  @override
  Widget build(BuildContext context) {
    final listBuildings = ref.watch(buildingsListDataProvider);

    ListBuildingModel? _getBuildingById(buildingId) {
      ListBuildingModel? listBuilding;
      listBuildings.whenData((buildings) => {
        for (var building in buildings) {
          if (building.id == buildingId) {
            listBuilding = building
          }
        }
      });
      return listBuilding;
    }

    return FutureBuilder<DetailArchitectModel>(
      future: architect,
      builder: (context, snapshot) {
        if (snapshot.hasData) {

          final detailSection = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionHeader(title: "ARCHITECT"),
                Row(
                    children: [
                      Text(snapshot.data!.firstName, style: const TextStyle(fontSize: 18)),
                      if (snapshot.data!.firstName != "") const Text(" "),
                      Text(snapshot.data!.lastName, style: const TextStyle(fontSize: 18)),
                    ]
                ),
                const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0),),
                Row(
                    children: [
                      if (snapshot.data!.birthDay.isNotEmpty) const Icon(
                        CupertinoIcons.heart_circle,
                        color: Colors.black,
                        size: 20,
                      ),
                      const Text(" "),
                      if (snapshot.data!.birthDay.isNotEmpty) Text(snapshot.data!.birthDay, style: const TextStyle(fontSize: 16)),
                      if (snapshot.data!.birthPlace.isNotEmpty || snapshot.data!.birthCountry.isNotEmpty) const Text(" in ", style: TextStyle(fontSize: 16)),
                      if (snapshot.data!.birthPlace.isNotEmpty) Text(snapshot.data!.birthPlace, style: const TextStyle(fontSize: 16)),
                      if (snapshot.data!.birthCountry.isNotEmpty) const Text(", "),
                      if (snapshot.data!.birthCountry.isNotEmpty) Text(snapshot.data!.birthCountry, style: const TextStyle(fontSize: 16)),
                    ]
                ),
                Row(
                    children: [
                      if (snapshot.data!.birthDay.isNotEmpty) const Icon(
                        CupertinoIcons.heart_slash_circle,
                        color: Colors.black,
                        size: 20,
                      ),
                      const Text(" "),
                      if (snapshot.data!.deathDay.isNotEmpty) Text(snapshot.data!.deathDay, style: const TextStyle(fontSize: 16)),
                      if (snapshot.data!.deathPlace.isNotEmpty || snapshot.data!.deathCountry.isNotEmpty) const Text(" in ", style: TextStyle(fontSize: 16)),
                      if (snapshot.data!.deathPlace.isNotEmpty) Text(snapshot.data!.deathPlace, style: const TextStyle(fontSize: 16)),
                      if (snapshot.data!.deathCountry.isNotEmpty) const Text(", "),
                      if (snapshot.data!.deathCountry.isNotEmpty) Text(snapshot.data!.deathCountry, style: const TextStyle(fontSize: 16)),
                    ]
                )

              ]
          );

          final descriptionSection = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionHeader(title: "DESCRIPTION"),
                SectionTextContent(content: parse(snapshot.data!.description).body!.text),
              ]
          );

          final relatedBuildingsSection = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionHeader(title: "RELATED BUILDINGS"),
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemBuilder: (context, index) {
                        return BuildingListCard(
                            listBuilding: _getBuildingById(snapshot.data!.relatedBuildings[index].id)
                        );
                      },
                      itemCount: snapshot.data!.relatedBuildings.length,
                    )
                )
              ]
          );

          final architectContent = Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 15),
              child: Column(
                children: <Widget>[
                  detailSection,
                  if (snapshot.data!.description.isNotEmpty) descriptionSection,
                  if (snapshot.data!.relatedBuildings.isNotEmpty) relatedBuildingsSection,
                ],
              )
          );

          return Scaffold(
            body: ListView(
              children: <Widget>[
                architectContent
              ],
            ),
            appBar: AppBar(
              title: Row(
                  children: [
                    Text(snapshot.data!.firstName),
                    if (snapshot.data!.firstName != "") const Text(" "),
                    Text(snapshot.data!.lastName),
                  ]
              ),
              backgroundColor: Colors.black,),
          );
        } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
        }
        return const LoadingScreen();
      },
    );
  }
}