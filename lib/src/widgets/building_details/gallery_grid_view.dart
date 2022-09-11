import 'package:flutter/material.dart';
import 'package:mia/src/widgets/building_details/gallery_carousel.dart';


class GalleryGridView extends StatelessWidget{
  const GalleryGridView({Key? key, required this.galleryImages}) : super(key: key);
  final List<String> galleryImages;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
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
          child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                galleryImages[index],
                fit: BoxFit.cover,
              ),
          )
        );
      },
    );
  }
}