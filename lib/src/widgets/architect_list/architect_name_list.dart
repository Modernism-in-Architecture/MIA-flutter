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

  final List<List<ListArchitectModel>> architectList;
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
      controller: widget.scrollController,
      itemCount: widget.architectList.length,
      itemBuilder: (context, index) {
        return Column(
            children: [
                ArchitectListSectionHeader(
                    currentInitialLetter: removeDiacritics(widget.architectList[index][0].lastName[0]),
                    letterSectionItemHeight: widget.letterSectionItemHeight
                ),
                _renderArchitectGroup(widget.architectList[index])
            ],
        );
      },
    );
  }

  _renderArchitectGroup(List architectGroup) {
      return Container(
          margin: const EdgeInsets.only(left: 16.0, right: 8.0),
          padding: const EdgeInsets.only(top: 16.0),
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade400,
                    spreadRadius: 0.1,
                    blurRadius: 0.1,
                    offset: const Offset(0.2, 0.2),
                  ),
              ],
          ),
          child: Column(
              children: architectGroup.map((architect) =>
                ArchitectListCard(
                    architect: architect,
                    itemSizeHeight: widget.itemSizeHeight,
                    isLastOfGroup: architectGroup.indexOf(architect) == architectGroup.length-1,
                )
              ).toList()
          ));
  }
}