import 'package:flutter/material.dart';

import '../../models/list_architect_model.dart';


class ArchitectListCard extends StatelessWidget{
  const ArchitectListCard({Key? key, required this.architectList, required this.architectIndex}) : super(key: key);
  final List<ListArchitectModel> architectList;
  final int architectIndex;

  @override
  Widget build(BuildContext context) {

    bool firstNameExists = architectList[architectIndex].firstName != "";

    return Card(
        elevation: 1,
        child: Padding(
            padding: const EdgeInsets.only(left: 10), //apply padding to all four sides
            child: Align(
                alignment: Alignment.centerLeft,
                child: firstNameExists ?
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