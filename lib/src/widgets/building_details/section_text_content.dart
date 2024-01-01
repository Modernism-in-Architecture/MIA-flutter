import 'package:flutter/material.dart';
import 'package:mia/src/widgets/expanded_text.dart';

class SectionTextContent extends StatelessWidget{
  const SectionTextContent({super.key, required this.content});
  final String content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: ExpandedText(
          content: content,
      ),
    );
  }
}