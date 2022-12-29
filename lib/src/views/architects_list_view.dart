import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mia/src/models/list_architect_model.dart';

import '../helpers.dart';
import '../providers.dart';
import '../widgets/architect_list/architect_index_bar.dart';
import '../widgets/architect_list/architect_name_list.dart';
import '../widgets/loading_screen.dart';


class ArchitectsListView extends ConsumerStatefulWidget {
  const ArchitectsListView({Key? key}) : super(key: key);

  @override
  ArchitectsListViewState createState() => ArchitectsListViewState();
}


class ArchitectsListViewState extends ConsumerState<ArchitectsListView> {
  final ScrollController _listController = ScrollController();
  static const itemSizeHeight = 63.0;
  static const letterSectionItemHeight = 50.0;

  List _alphabet = [];
  List<ListArchitectModel> resultArchitects = [];

  @override
  Widget build(BuildContext context) {
    final listArchitects = ref.watch(architectsListDataProvider);
    final searchQuery = ref.watch(searchQueryProvider);

    if (listArchitects.isLoading) {
      return const LoadingScreen();
    }

    List<ListArchitectModel> resultList = [];

    listArchitects.whenData((architects) => {
      for (var architect in architects) {
        if (searchQuery.isEmpty ||
            architect.lastName.toLowerCase().startsWith(searchQuery.toLowerCase()) ||
            architect.firstName.toLowerCase().startsWith(searchQuery.toLowerCase())
        ) {
          resultList.add(architect)
        }
      },
      resultArchitects = resultList
    });

    if (resultArchitects.isEmpty) {
      return const Center(
          child: Text("Sorry, no results")
      );
    } else {
      _collectFirstLetters();
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          children: [
            Expanded (
              flex: 10,
              child:
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ArchitectNameList(
                    architectList: resultArchitects,
                    scrollController: _listController,
                    itemSizeHeight: itemSizeHeight,
                    letterSectionItemHeight: letterSectionItemHeight,
                  )
                )
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ArchitectIndexBar(
                    alphabet: _alphabet,
                    resultArchitects: resultArchitects,
                    itemSizeHeight: itemSizeHeight,
                    jumpToPosition: _jumpToSelectedLetter
                  )
                ]
              ),
            )
          ],
        );
      },
    );
  }

  void _collectFirstLetters() {
    Set firstLetters = {};

    for ( ListArchitectModel architect in resultArchitects ) {
      var firstLetter = removeDiacritics(architect.lastName[0]);
      firstLetters.add(firstLetter.toUpperCase());
    }

    setState(() {
      _alphabet = firstLetters.toList();
    });
  }

  void _jumpToSelectedLetter(String selectedLetter) {
    var letterIndex = _alphabet.indexOf(selectedLetter);

    for (var i = 0; i < resultArchitects.length; i++) {
      if (selectedLetter.compareTo(removeDiacritics(resultArchitects[i].lastName[0]).toUpperCase()) == 0) {
        var itemOffset = i * itemSizeHeight + letterIndex * letterSectionItemHeight;
        _listController.animateTo(
            itemOffset,
            curve: Curves.linear,
            duration: const Duration (milliseconds: 500)
        );
        break;
      }
    }
  }

}