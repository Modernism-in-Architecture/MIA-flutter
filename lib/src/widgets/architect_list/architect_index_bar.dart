import 'package:flutter/material.dart';
import 'package:mia/src/models/list_architect_model.dart';

import '../../helpers.dart';


class ArchitectIndexBar extends StatefulWidget {

  final List<ListArchitectModel> resultArchitects;
  final ScrollController scrollController;
  final double itemSizeHeight;
  final int middleItemIndex;

  const ArchitectIndexBar({
        Key? key,
        required this.resultArchitects,
        required this.scrollController,
        required this.itemSizeHeight,
        required this.middleItemIndex
      }) : super(key: key);

  @override
  State<ArchitectIndexBar> createState() => _ArchitectIndexBarState();

}

class _ArchitectIndexBarState extends State<ArchitectIndexBar> {
  late List _alphabet;
  late int posSelected;
  String _letter = "A";
  String _oldLetter = "A";

  @override
  void initState() {
    _collectFirstLetters(widget.resultArchitects);
    String firstLetter = widget.resultArchitects[widget.middleItemIndex].lastName[0];
    posSelected = _alphabet.indexOf(firstLetter);
    super.initState();
  }

  @override
  void didUpdateWidget(ArchitectIndexBar oldWidget) {
    if (widget.middleItemIndex != oldWidget.middleItemIndex) {
      String firstLetter = widget.resultArchitects[widget.middleItemIndex].lastName[0];
      posSelected = _alphabet.indexOf(firstLetter);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [...List.generate(
              _alphabet.length, (index) =>
              _getAlphabetLetter(index, widget.resultArchitects))
          ],
        ),
    );
  }

  _collectFirstLetters(List resultArchitects) {
    Set firstLetters = {};

    for ( ListArchitectModel architect in resultArchitects ) {
      var firstLetter = removeDiacritics(architect.lastName[0]);
      firstLetters.add(firstLetter.toUpperCase());
    }

    _alphabet = firstLetters.toList();
  }

  _getAlphabetLetter(int letterIndex, List resultArchitects) {

    return Expanded(
        child: Container(
          width: 40,
          height: 20,
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: () {
              _letter = _alphabet[letterIndex];
              if (_letter != _oldLetter) {
                for (var i = 0; i < resultArchitects.length; i++) {
                  if (_letter.toString().compareTo(resultArchitects[i].lastName.toString().toUpperCase()[0]) == 0) {
                    widget.scrollController.animateTo(
                        i * widget.itemSizeHeight,
                        curve: Curves.linear,
                        duration: const Duration (milliseconds: 500)
                    );
                    setState(() {
                      posSelected = letterIndex;
                    });
                    break;
                  }
                }
                _oldLetter = _letter;
              }
            },
            child: Text(
              _alphabet[letterIndex],
              style: (letterIndex == posSelected)
                  ? const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)
                  : const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ),
        )
    );
  }

}