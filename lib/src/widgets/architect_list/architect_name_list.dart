import 'package:flutter/material.dart';
import 'package:mia/src/models/list_architect_model.dart';

import '../../views/architect_detail_view.dart';
import 'architect_list_card.dart';


class ArchitectNameList extends StatefulWidget {
  const ArchitectNameList({Key? key, required this.architectList, required this.scrollController, required this.itemSizeHeight})
      : super(key: key);

  final List<ListArchitectModel> architectList;
  final ScrollController scrollController;
  final double itemSizeHeight;

  @override
  State<ArchitectNameList> createState() => _ArchitectNameListState();
}

class _ArchitectNameListState extends State<ArchitectNameList> {

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.architectList.length,
        controller: widget.scrollController,
        itemExtent: widget.itemSizeHeight,
        itemBuilder: (context, architectIndex) {
          return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ArchitectDetailView(
                            architectId: widget.architectList[architectIndex].id
                        ),
                  ),
                );
              },
              child: ArchitectListCard(architectList: widget.architectList, architectIndex: architectIndex)
          );
        }
    );
  }
}