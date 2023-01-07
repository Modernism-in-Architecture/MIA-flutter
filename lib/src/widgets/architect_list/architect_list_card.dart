import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/list_architect_model.dart';
import '../../views/architect_detail_view.dart';


class ArchitectListCard extends StatelessWidget{
  const ArchitectListCard({
    Key? key,
    required this.architect,
    required this.itemSizeHeight,
    required this.isLastOfGroup,
  }) : super(key: key);

  final ListArchitectModel architect;
  final double itemSizeHeight;
  final bool isLastOfGroup;

  @override
  Widget build(BuildContext context) {

    bool firstNameExists = architect.firstName != "";

    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ArchitectDetailView(
                      architectId: architect.id
                  ),
            ),
          );
        },
        child: Container(
            height: itemSizeHeight,
            padding: const EdgeInsets.only(left: 16.0),
            child: Column(
                children: [
                    Row(
                      children: [
                          Expanded(
                              flex: 10,
                              child: firstNameExists ? Text(
                                  "${architect.lastName}, ${architect.firstName}",
                                  style: const TextStyle(fontSize: 16),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                              ) : Text(
                                  architect.lastName,
                                  style: const TextStyle(fontSize: 16),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                              )
                          ),
                          const Expanded(
                              flex: 2,
                              child: Icon(
                                CupertinoIcons.right_chevron,
                                size: 8
                              )
                          )
                      ]
                    ),
                    if (!isLastOfGroup) const Divider(endIndent: 16)
                ]
            )
        )
    );
  }
}