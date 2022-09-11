import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mia/src/widgets/building_details/gallery_grid_view.dart';
import 'package:mia/src/widgets/building_details/header_image.dart';
import 'package:mia/src/widgets/building_details/section_text_content.dart';
import 'package:mia/src/widgets/loading_screen.dart';
import '../models/detail_building_model.dart';
import '../network/api_client.dart';
import '../widgets/building_details/section_header.dart';
import 'package:html/parser.dart' show parse;

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

    return FutureBuilder<DetailBuildingModel>(
        future: building,
        builder: (context, snapshot) {
          if (snapshot.hasData) {

            final locationSection = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  SectionHeader(title: "LOCATION"),
                ]
            );

            final impressionsSection = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionHeader(title: "IMPRESSIONS"),
                  GalleryGridView(galleryImages: snapshot.data!.galleryImages)
                ]
            );

            final descriptionSection = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionHeader(title: "DESCRIPTION"),
                  SectionTextContent(content: parse(snapshot.data!.description).body!.text),
                ]
            );

            final historySection = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionHeader(title: "HISTORY"),
                  SectionTextContent(content: parse(snapshot.data!.history).body!.text),
                ]
            );

            final architectsSection = Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SectionHeader(title: "ARCHITECTS"),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Column(
                          children: [
                            for ( var architect in snapshot.data!.architects) Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    architect.firstName,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const Text(" "),
                                  Text(
                                    architect.lastName,
                                    style: const TextStyle(fontSize: 16),
                                  )
                                ]
                            )
                          ]
                      )
                    ),
                  ]
              );

            final detailSection = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionHeader(title: "BUILDING"),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Text(snapshot.data!.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                  child: Text(snapshot.data!.buildingType, style: const TextStyle(fontSize: 16)),
                ),
                Text(
                  snapshot.data!.address,
                  style: const TextStyle(fontSize: 16),
                ),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        snapshot.data!.city,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const Text(
                          ", ",
                          style: TextStyle(fontSize: 16)
                      ),
                      Text(
                        snapshot.data!.country,
                        style: const TextStyle(fontSize: 16),
                      )
                    ]
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                  child: Row(
                    children: [
                      const Text("Today's use: ", style: TextStyle(fontSize: 16)),
                      Expanded(child: Text(snapshot.data!.todaysUse, style: const TextStyle(fontSize: 16))),
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Year of construction: ", style: TextStyle(fontSize: 16)),
                    Text(snapshot.data!.yearOfConstruction, style: const TextStyle(fontSize: 16)),
                  ],
                )
          ]);

            final headerImage = HeaderImage(feedImage: snapshot.data!.galleryImages[0]);

            final buildingContent = Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 15),
              child: Column(
                  children: <Widget>[
                    detailSection,
                    if (snapshot.data!.architects.isNotEmpty) architectsSection,
                    if (snapshot.data!.history.isNotEmpty) historySection,
                    if (snapshot.data!.description.isNotEmpty) descriptionSection,
                    locationSection,
                    impressionsSection,
                  ],
              )
            );

            return Scaffold(
              body: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: <Widget>[
                  headerImage, buildingContent
                ],
              ),
              appBar: AppBar(title: Text(snapshot.data!.name), backgroundColor: Colors.black,),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const LoadingScreen();
        },
      );
  }
}