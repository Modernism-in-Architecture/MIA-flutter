import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ArchitectsListView extends ConsumerStatefulWidget {
  const ArchitectsListView({Key? key}) : super(key: key);

  @override
  ArchitectsListViewState createState() => ArchitectsListViewState();
}

class ArchitectsListViewState extends ConsumerState<ArchitectsListView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Center(
          child: Text("This the Architects Screen", style: TextStyle(fontSize: 24),),
        )
      ],
    );
  }
}