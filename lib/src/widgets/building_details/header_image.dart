import 'package:flutter/material.dart';

class HeaderImage extends StatelessWidget{
  const HeaderImage({Key? key, required this.feedImage}) : super(key: key);
  final String feedImage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 300,
      child: Image.network(
        feedImage,
        fit: BoxFit.cover,
      ),
    );
  }
}