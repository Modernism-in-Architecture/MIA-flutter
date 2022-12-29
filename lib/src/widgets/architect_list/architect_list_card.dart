import 'package:flutter/material.dart';

import '../../models/list_architect_model.dart';
import '../../views/architect_detail_view.dart';


class ArchitectListCard extends StatelessWidget{
  const ArchitectListCard({
    Key? key,
    required this.architectList,
    required this.architectIndex,
    required this.itemSizeHeight,
  }) : super(key: key);

  final List<ListArchitectModel> architectList;
  final int architectIndex;
  final double itemSizeHeight;

  @override
  Widget build(BuildContext context) {

    bool firstNameExists = architectList[architectIndex].firstName != "";

    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ArchitectDetailView(
                      architectId: architectList[architectIndex].id
                  ),
            ),
          );
        },
        child: SizedBox(
            height: itemSizeHeight,
            child: Card(
                elevation: 1,
                child: Padding(
                    padding: const EdgeInsets.only(left: 10),
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
            )
        )
    );
  }
}