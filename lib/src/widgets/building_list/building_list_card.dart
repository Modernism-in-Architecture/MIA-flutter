import 'package:flutter/material.dart';
import '../../models/list_building_model.dart';
import '../../views/building_detail_view.dart';
import '../loading_screen.dart';

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
                      height: 395,
                      child: Card(
                          elevation: 1,
                          margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                              children: [
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height: 310,
                                      child: Image.network(
                                          listBuilding!.feedImage,
                                          fit: BoxFit.fill,
                                          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                              if (loadingProgress == null) {
                                                  return child;
                                              }
                                              return const Center(
                                                  child: LoadingScreen()
                                              );
                                          },
                                          errorBuilder: (context, error, stackTrace) {
                                              return Center(
                                                  child:
                                                      Padding(
                                                          padding: const EdgeInsets.all(40.0),
                                                          child: Image.asset("lib/assets/images/mia-logo.png")
                                                      )
                                              );
                                          },
                                      ),
                                  ),
                                  Expanded(
                                      child: Padding(
                                          padding: const EdgeInsets.all(14.0),
                                          child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children:[
                                                  Text(
                                                      listBuilding!.name,
                                                      style: const TextStyle(fontSize: 16),
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                  ),
                                                  Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                          Expanded(
                                                              child: Text(
                                                                  "${listBuilding!.city}, ${listBuilding!.country}",
                                                                  style: const TextStyle(fontSize: 12),
                                                              ),
                                                          )
                                                      ]
                                                  )
                                              ]
                                          ),
                                      )
                                  )
                              ],
                          ),
                      )
                  )
              )
          ]
      );
  }
}
