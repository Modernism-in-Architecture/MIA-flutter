import 'package:flutter/material.dart';

class ArchitectsListView extends StatefulWidget {
  const ArchitectsListView({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<ArchitectsListView> createState() => _ArchitectsListState();
}

class _ArchitectsListState extends State<ArchitectsListView> {
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