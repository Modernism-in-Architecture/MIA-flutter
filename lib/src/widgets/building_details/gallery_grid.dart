import 'package:flutter/material.dart';
import 'package:mia/src/widgets/building_details/gallery_carousel.dart';


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
                    ),
                )
              )
            );
          },
        )
    );
  }
}