import 'package:flutter/material.dart';

import '../../models/list_architect_model.dart';


class ArchitectListCard extends StatelessWidget{
  const ArchitectListCard({Key? key, required this.architectList, required this.architectIndex}) : super(key: key);
  final List<ListArchitectModel> architectList;
  final int architectIndex;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                children: [
                  Row(
                      children: [
                        Text(architectList[architectIndex].lastName, style: const TextStyle(fontSize: 16)),
                        if (architectList[architectIndex].firstName != "") const Text(", "),
                        Text(architectList[architectIndex].firstName, style: const TextStyle(fontSize: 16))
                      ]
                  )
                ]
            )
        )
    );
  }

}