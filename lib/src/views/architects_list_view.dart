import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mia/src/models/list_architect_model.dart';

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
  final ScrollController _controller = ScrollController();
  static const itemSizeHeight = 62.0;

  @override
  Widget build(BuildContext context) {
    final listArchitects = ref.watch(architectsListDataProvider);
    final searchQuery = ref.watch(searchQueryProvider);
    List<ListArchitectModel> resultArchitects = [];

    if (listArchitects.isLoading) {
      return const LoadingScreen();
    }

    // ToDo: Add error handling

    listArchitects.whenData((architects) => {
        for (var architect in architects) {
          if (
            searchQuery.isEmpty ||
            architect.lastName.toLowerCase().startsWith(searchQuery.toLowerCase()) ||
            architect.firstName.toLowerCase().startsWith(searchQuery.toLowerCase())
          ) {
            resultArchitects.add(architect)
          }
        }
      });

    if (resultArchitects.isEmpty) {
      return const Center(
          child: Text("Sorry, no results")
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
            children: [
                Container(
                  margin: const EdgeInsets.only(top: 10, left: 10, right: 45),
                  child: ArchitectNameList(
                    architectList: resultArchitects,
                    scrollController: _controller,
                  )
                ),
                Container(
                  margin: const EdgeInsets.only(right: 5, top: 10, bottom: 5),
                  child: ArchitectIndexBar(
                    resultArchitects: resultArchitects,
                    scrollController: _controller,
                    itemSizeHeight: itemSizeHeight
                  )
                )
            ]
        );
      },
    );
  }
}