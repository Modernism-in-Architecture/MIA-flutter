import 'package:flutter/material.dart';
import 'package:mia/src/models/list_architect_model.dart';

import '../../helpers.dart';
import 'architect_list_card.dart';
import 'architect_list_section_header.dart';


class ArchitectNameList extends StatefulWidget {
  const ArchitectNameList({
    Key? key,
    required this.architectList,
    required this.scrollController,
    required this.itemSizeHeight,
    required this.letterSectionItemHeight,
  }) : super(key: key);

  final List<ListArchitectModel> architectList;
  final ScrollController scrollController;
  final double itemSizeHeight;
  final double letterSectionItemHeight;

  @override
  State<ArchitectNameList> createState() => _ArchitectNameListState();
}

class _ArchitectNameListState extends State<ArchitectNameList> {

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
        itemCount: widget.architectList.length,
        controller: widget.scrollController,

        itemBuilder: (context, architectIndex) {

          String currentInitialLetter = removeDiacritics(widget.architectList[architectIndex].lastName[0]);
          String predecessorInitialLetter = "-";

          if (architectIndex > 0) {
            predecessorInitialLetter = removeDiacritics(widget.architectList[architectIndex-1].lastName[0]);
          }

          bool isNewLetterSection = predecessorInitialLetter.toLowerCase() != currentInitialLetter.toLowerCase();

          return Wrap(
              children: [
                  if (isNewLetterSection)
                      ...[ArchitectListSectionHeader(
                            currentInitialLetter: currentInitialLetter,
                            letterSectionItemHeight: widget.letterSectionItemHeight
                          )],
                  ArchitectListCard(
                      architectList: widget.architectList,
                      architectIndex: architectIndex,
                      itemSizeHeight: widget.itemSizeHeight,
                  )
              ]
          ) ;
        }
    );
  }
}