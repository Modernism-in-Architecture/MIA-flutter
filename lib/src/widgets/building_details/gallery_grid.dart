import 'package:flutter/material.dart';
import 'package:mia/src/widgets/building_details/gallery_carousel.dart';

import '../loading_screen.dart';


class GalleryGrid extends StatelessWidget{
  const GalleryGrid({Key? key, required this.galleryImages}) : super(key: key);
  final List<String> galleryImages;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
            crossAxisCount: 2,
          ),
          // scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemCount: galleryImages.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GalleryCarousel(imageIndex: index, galleryImages: galleryImages),
                  ),
                );
              },
              child: Card(
                elevation: 3,
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      galleryImages[index],
                      fit: BoxFit.cover,
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
                )
              )
            );
          },
        )
    );
  }
}