import 'package:flutter/material.dart';

class ExpandedText extends StatefulWidget {
  const ExpandedText({Key? key, required this.content}) : super(key: key);
  final String content;

  @override
  _ExpandedTextState createState() => _ExpandedTextState();
}

class _ExpandedTextState extends State<ExpandedText> {
  late String firstPart;
  late String secondPart;
  bool collapsed = true;

  @override
  void initState() {
    super.initState();
    if (widget.content.length > 150) {
      firstPart = widget.content.substring(0, 150);
      secondPart = widget.content.substring(151, widget.content.length);
    } else {
      firstPart = widget.content;
      secondPart = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          collapsed = !collapsed;
          });
      },
      child: secondPart.isNotEmpty ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [collapsed ? Text(firstPart, style: const TextStyle(fontSize: 16)) : Text(widget.content, style: const TextStyle(fontSize: 16)),
        ]
      ) : Text(widget.content, style: const TextStyle(fontSize: 16))

    );
  }

}