import 'package:flutter/material.dart';


class ArchitectListSectionHeader extends StatefulWidget {
  const ArchitectListSectionHeader({
    super.key,
    required this.currentInitialLetter,
    required this.letterSectionItemHeight,
    });

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
              padding: const EdgeInsets.fromLTRB(20, 25, 0, 0),
              child: Text(
                  widget.currentInitialLetter.toUpperCase(),
                  style: const TextStyle(fontSize: 12)
              )
          )),
    );

  }
}