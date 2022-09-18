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

  @override
  Widget build(BuildContext context) {

    final listArchitects = ref.watch(architectsListDataProvider);

    return listArchitects.when(
        data: (listArchitects) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: listArchitects.length,
              itemBuilder: (BuildContext context, int index){
                return Container(
                    margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ArchitectDetailView(architectId: listArchitects[index].id),
                            ),
                          );
                        },
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
                    ));
              },
            );
      },
      error: (err, s) => Text(err.toString()),
      loading: () => const LoadingScreen(),
    );
  }
}