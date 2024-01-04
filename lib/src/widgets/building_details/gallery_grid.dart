import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mia/src/widgets/building_details/gallery_carousel.dart';

import '../loading_screen.dart';


class GalleryGrid extends StatelessWidget{
  const GalleryGrid({super.key, required this.galleryImages});
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
                    child: CachedNetworkImage(
                      imageUrl: galleryImages[index],
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Center(child: LoadingScreen()),
                      errorWidget: (context, url, error) => Center(
                        child: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Image.asset("lib/assets/images/mia-logo.png"),
                        ),
                      ),
                    ),
                )
              )
            );
          },
        )
    );
  }
}