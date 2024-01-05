import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../loading_screen.dart';

class HeaderImage extends StatelessWidget{
  const HeaderImage({super.key, required this.feedImage});
  final String feedImage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 300,
      child: CachedNetworkImage(
        imageUrl: feedImage,
        fit: BoxFit.cover,
        placeholder: (context, url) => const Center(child: LoadingScreen()),
        errorWidget: (context, url, error) => Center(
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: Image.asset("lib/assets/images/mia-logo.png"),
          ),
        ),
      ),
    );
  }
}