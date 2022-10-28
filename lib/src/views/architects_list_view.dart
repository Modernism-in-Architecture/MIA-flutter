import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mia/main.dart';
import 'package:mia/src/models/list_architect_model.dart';

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
  static const itemSizeHeight = 65.0;

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
              ArchitectNameList(
                  architectList: resultArchitects,
                  scrollController: _controller,
                  itemSizeHeight: itemSizeHeight
              ),
              ArchitectIndexBar(
                  resultArchitects: resultArchitects,
                  scrollController: _controller,
                  itemSizeHeight: itemSizeHeight
              )
            ]
        );
      },
    );
  }
}