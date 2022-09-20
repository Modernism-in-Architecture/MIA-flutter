import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mia/main.dart';

import '../widgets/loading_screen.dart';
import 'architect_detail_view.dart';

class ArchitectsListView extends ConsumerStatefulWidget {
  const ArchitectsListView({Key? key}) : super(key: key);

  @override
  ArchitectsListViewState createState() => ArchitectsListViewState();
}

class ArchitectsListViewState extends ConsumerState<ArchitectsListView> {
  String _letter = "A";
  String _oldLetter = "A";
  late List listArchitects;
  final ScrollController _controller = ScrollController();
  final _itemSizeHeight = 65.0;
  int posSelected = 0;
  final List _alphabet = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z'
  ];

  @override
  void initState() {
    _controller.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final listArchitects = ref.watch(architectsListDataProvider);

    return listArchitects.when(
        data: (listArchitects) {
            return LayoutBuilder(
                builder: (context, constraints) {
                    return Stack(
                        children: [
                            ListView.builder(
                                itemCount: listArchitects.length,
                                controller: _controller,
                                itemExtent: _itemSizeHeight,
                                itemBuilder: (context, index) {
                                    return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => ArchitectDetailView(architectId: listArchitects[index].id),
                                            ),
                                          );
                                         },
                                        child:Card(
                                            child: Padding(
                                                padding: const EdgeInsets.all(16.0),
                                                child: Column (
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(listArchitects[index].lastName, style: const TextStyle(fontSize: 16)),
                                                          if (listArchitects[index].firstName != "") const Text(", "),
                                                          Text(listArchitects[index].firstName, style: const TextStyle(fontSize: 16))
                                                        ]
                                                      )
                                                    ]
                                                )
                                            )
                                        )
                                    );
                                }
                            ),
                            Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  color: Colors.transparent,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [...List.generate(_alphabet.length, (index) => _getAlphabetLetter(index, listArchitects))],
                                  ),
                                ),
                              ),
                        ]
                    );
                },
            );
      },
      error: (err, s) => Text(err.toString()),
      loading: () => const LoadingScreen(),
    );
  }

  _getAlphabetLetter(int index, List listArchitects) {
      return Expanded(
          child: Container(
              width: 40,
              height: 20,
              alignment: Alignment.center,
              child: GestureDetector(
                  onTap: () {
                    _letter = _alphabet[index];
                    if (_letter != _oldLetter) {
                      for (var i = 0; i < listArchitects.length; i++) {
                        if (_letter
                            .toString()
                            .compareTo(listArchitects[i].lastName.toString().toUpperCase()[0]) == 0) {
                                _controller.jumpTo(i * _itemSizeHeight);
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

  _scrollListener() {
    if ((_controller.offset) >= (_controller.position.maxScrollExtent)) {

        if (kDebugMode) {
          print("reached bottom");
        }

    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {

        if (kDebugMode) {
          print("reached top");
        }

    }
  }
}