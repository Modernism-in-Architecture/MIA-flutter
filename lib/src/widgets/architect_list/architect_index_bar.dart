import 'package:flutter/material.dart';
import 'package:mia/src/models/list_architect_model.dart';


class ArchitectIndexBar extends StatefulWidget {
  const ArchitectIndexBar({Key? key, required this.resultArchitects, required this.scrollController, required this.itemSizeHeight})
      : super(key: key);

  final List<ListArchitectModel> resultArchitects;
  final ScrollController scrollController;
  final double itemSizeHeight;

  @override
  State<ArchitectIndexBar> createState() => _ArchitectIndexBarState();
}

class _ArchitectIndexBarState extends State<ArchitectIndexBar> {
  String _letter = "A";
  String _oldLetter = "A";
  int posSelected = 0;
  late List _alphabet;

  @override
  Widget build(BuildContext context) {
    _collectFirstLetters(widget.resultArchitects);
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [...List.generate(
              _alphabet.length, (index) =>
              _getAlphabetLetter(index, widget.resultArchitects))
          ],
        ),
      ),
    );
  }

  _collectFirstLetters(List resultArchitects) {
    Set firstLetters = {};

    for ( ListArchitectModel architect in resultArchitects ) {
      firstLetters.add(architect.lastName[0].toUpperCase());
    }

    _alphabet = firstLetters.toList();
  }

  _getAlphabetLetter(int index, List resultArchitects) {

    return Expanded(
        child: Container(
          width: 40,
          height: 20,
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: () {
              _letter = _alphabet[index];
              if (_letter != _oldLetter) {
                for (var i = 0; i < resultArchitects.length; i++) {
                  if (_letter
                      .toString()
                      .compareTo(resultArchitects[i].lastName.toString().toUpperCase()[0]) == 0) {
                    widget.scrollController.jumpTo(i * widget.itemSizeHeight);
                    setState(() {
                      posSelected = index;
                    });
                    break;
                  }
                }
                _oldLetter = _letter;
              }
            },
            child: Text(
              _alphabet[index],
              style: (index == posSelected)
                  ? const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)
                  : const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ),
        )
    );
  }
}