import 'package:flutter/material.dart';

import '../../models/list_architect_model.dart';


class ArchitectListCard extends StatelessWidget{
  const ArchitectListCard({Key? key, required this.architectList, required this.architectIndex}) : super(key: key);
  final List<ListArchitectModel> architectList;
  final int architectIndex;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 1,
        child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: (architectList[architectIndex].firstName != "") ?
                  Text(
                    "${architectList[architectIndex].lastName}, ${architectList[architectIndex].firstName}",
                    style: const TextStyle(fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ) : Text(
                    architectList[architectIndex].lastName,
                    style: const TextStyle(fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  )
            )
        )
    );
  }
}