import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mia/main.dart';
import 'package:mia/src/models/list_architect_model.dart';

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
  int posSelected = 0;
  late List listArchitects;
  late List _alphabet;
  final ScrollController _controller = ScrollController();
  final _itemSizeHeight = 65.0;

  @override
  void initState() {
    _controller.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final listArchitects = ref.watch(architectsListDataProvider);
    final searchQuery = ref.watch(searchQueryProvider);
    List<ListArchitectModel> resultArchitects = [];

    if (searchQuery.isNotEmpty) {
      listArchitects.whenData((architects) => {
        for (var architect in architects) {
          if (
            architect.lastName.toLowerCase().startsWith(searchQuery.toLowerCase()) ||
                architect.firstName.toLowerCase().startsWith(searchQuery.toLowerCase())
             ){
            resultArchitects.add(architect)
          }
        }
      });
      if (resultArchitects.isNotEmpty) {
        return ListView.builder(
            itemCount: resultArchitects.length,
            controller: _controller,
            itemExtent: _itemSizeHeight,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ArchitectDetailView(
                                architectId: resultArchitects[index]
                                    .id),
                      ),
                    );
                  },
                  child: Card(
                      child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                              children: [
                                Row(
                                    children: [
                                      Text(resultArchitects[index]
                                          .lastName,
                                          style: const TextStyle(
                                              fontSize: 16)),
                                      if (resultArchitects[index]
                                          .firstName !=
                                          "") const Text(", "),
                                      Text(resultArchitects[index]
                                          .firstName,
                                          style: const TextStyle(
                                              fontSize: 16))
                                    ]
                                )
                              ]
                          )
                      )
                  )
              );
            }
        );
      } else {
        return const Center(
            child: Text("Sorry, no results")
        );
      }
    } else {
      return listArchitects.when(
        data: (listArchitects) {
          _collectFirstLetters(listArchitects);
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
                                    builder: (context) =>
                                        ArchitectDetailView(
                                            architectId: listArchitects[index]
                                                .id),
                                  ),
                                );
                              },
                              child: Card(
                                  child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                          children: [
                                            Row(
                                                children: [
                                                  Text(listArchitects[index]
                                                      .lastName,
                                                      style: const TextStyle(
                                                          fontSize: 16)),
                                                  if (listArchitects[index]
                                                      .firstName !=
                                                      "") const Text(", "),
                                                  Text(listArchitects[index]
                                                      .firstName,
                                                      style: const TextStyle(
                                                          fontSize: 16))
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
                          children: [...List.generate(
                              _alphabet.length, (index) =>
                              _getAlphabetLetter(index, listArchitects))
                          ],
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

  _collectFirstLetters(List listArchitects) {
    Set firstLetters = {};

    for ( ListArchitectModel architect in listArchitects ) {
      firstLetters.add(architect.lastName[0].toUpperCase());
    }

    _alphabet = firstLetters.toList();
  }
}