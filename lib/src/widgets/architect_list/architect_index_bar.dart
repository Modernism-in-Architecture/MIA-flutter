import 'package:flutter/material.dart';
import 'package:mia/src/models/list_architect_model.dart';


class ArchitectIndexBar extends StatefulWidget {

  final List<ListArchitectModel> resultArchitects;
  final double itemSizeHeight;
  final List alphabet;
  final Function jumpToPosition;

  const ArchitectIndexBar({
        super.key,
        required this.alphabet,
        required this.resultArchitects,
        required this.itemSizeHeight,
        required this.jumpToPosition,
      });

  @override
  State<ArchitectIndexBar> createState() => _ArchitectIndexBarState();
}

class _ArchitectIndexBarState extends State<ArchitectIndexBar> {

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.alphabet.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return  GestureDetector(
              onTap: () {
                widget.jumpToPosition(widget.alphabet[index]);
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Text(
                    widget.alphabet[index],
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400)
                ),
              )
          );
        }
    );
  }
}
