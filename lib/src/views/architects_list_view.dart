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
  static const itemSizeHeight = 36.0;
  static const letterSectionItemHeight = 50.0;

  List _alphabet = [];
  List<List<ListArchitectModel>> groupedArchitectsList = [];
  List<ListArchitectModel> filteredArchitectList = [];

  @override
  Widget build(BuildContext context) {
    final listArchitects = ref.watch(architectsListDataProvider);
    final searchQuery = ref.watch(searchQueryProvider);

    if (listArchitects.isLoading) {
        return const LoadingScreen();
    }

    // Handle search query
    List<ListArchitectModel> filteredArchitects = [];

    listArchitects.whenData((architects) => {
        for (var architectIndex = 0; architectIndex < architects.length; architectIndex++) {
            if (searchQuery.isEmpty ||
                removeDiacritics(architects[architectIndex].lastName.toLowerCase()).startsWith(removeDiacritics(searchQuery.toLowerCase())) ||
                removeDiacritics(architects[architectIndex].firstName).toLowerCase().startsWith(removeDiacritics(searchQuery.toLowerCase()))
            ) {
                filteredArchitects.add(architects[architectIndex]),
            }
        },

        filteredArchitectList = filteredArchitects
    });

    // Build alphabetically grouped architect list
    Map<String, List<ListArchitectModel>> groupedArchitects = {};

    for (var architect in filteredArchitectList) {
      String firstLetter = removeDiacritics(architect.lastName[0].toUpperCase());
      if (!groupedArchitects.containsKey(firstLetter)) {
        groupedArchitects[firstLetter] = [];
      }
      groupedArchitects[firstLetter]?.add(architect);
    }

    groupedArchitectsList = groupedArchitects.values.toList();


    if (groupedArchitectsList.isEmpty) {
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
              Expanded(
                  flex: 10,
                  child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: ArchitectNameList(
                          architectList: groupedArchitectsList,
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
                            resultArchitects: filteredArchitectList,
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

    for ( ListArchitectModel architect in filteredArchitectList ) {
      var firstLetter = removeDiacritics(architect.lastName[0]);
      firstLetters.add(firstLetter.toUpperCase());
    }

    setState(() {
      _alphabet = firstLetters.toList();
    });
  }

  void _jumpToSelectedLetter(String selectedLetter) {
      var letterIndex = _alphabet.indexOf(selectedLetter);

      var architectsCount = 0;
      for (var idx = 0; idx < letterIndex; idx++) {
        architectsCount += groupedArchitectsList[idx].length;
      }

      var sectionHeights = letterSectionItemHeight.toInt() * letterIndex;
      var borderOfGroups = 18 * letterIndex;
      var sumItemSizeHeight = itemSizeHeight * architectsCount;

      var itemOffset = sectionHeights + borderOfGroups + sumItemSizeHeight;

      _listController.animateTo(
            itemOffset,
            curve: Curves.linear,
            duration: const Duration (milliseconds: 500)
      );
  }

}