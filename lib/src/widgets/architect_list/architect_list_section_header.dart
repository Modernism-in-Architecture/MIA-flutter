import 'package:flutter/material.dart';


class ArchitectListSectionHeader extends StatefulWidget {
  const ArchitectListSectionHeader({
    Key? key,
    required this.currentInitialLetter,
    required this.letterSectionItemHeight,
    })
      : super(key: key);

  final String currentInitialLetter;
  final double letterSectionItemHeight;


  @override
  State<ArchitectListSectionHeader> createState() => _ArchitectListSectionHeaderState();
}

class _ArchitectListSectionHeaderState extends State<ArchitectListSectionHeader> {

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
          height: widget.letterSectionItemHeight,
          child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 25, 0, 0),
              child: Text(
                  widget.currentInitialLetter,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
              )
          )),
    );

  }
}