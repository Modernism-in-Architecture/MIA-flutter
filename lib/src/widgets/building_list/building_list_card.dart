import 'package:flutter/material.dart';
import 'package:mia/main.dart';
import '../../models/list_building_model.dart';
import '../../views/building_detail_view.dart';

class BuildingListCard extends StatelessWidget{
  const BuildingListCard({Key? key, this.listBuilding}) : super(key: key);
  final ListBuildingModel? listBuilding;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BuildingDetailView(buildingId: listBuilding!.id),
                  )
                );
              },
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 370,
                  child: Card(
                    elevation: 5,
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 300,
                          child: Image.network(
                            listBuilding!.feedImage,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:[
                                Text(
                                  listBuilding!.name,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        listBuilding!.city,
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                      const Text(
                                          ", ",
                                          style: TextStyle(fontSize: 12)
                                      ),
                                      Text(
                                        listBuilding!.country,
                                        style: const TextStyle(fontSize: 12),
                                      )
                                    ]
                                )
                              ]
                          ),
                        )
                      ],
                    ),
                  )
              )
          )
        ]);
  }

}