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
      child: Image.network(
        feedImage,
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
    );
  }
}