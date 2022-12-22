import 'package:flutter/material.dart';
import 'package:mia/src/models/list_architect_model.dart';

import '../../helpers.dart';
import '../../views/architect_detail_view.dart';
import 'architect_list_card.dart';


class ArchitectNameList extends StatefulWidget {
  const ArchitectNameList({Key? key, required this.architectList, required this.scrollController})
      : super(key: key);

  final List<ListArchitectModel> architectList;
  final ScrollController scrollController;

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
                child: isNewLetterSection ?
                  Wrap(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                    currentInitialLetter,
                                    style: const TextStyle(fontSize: 16)
                                )
                            ),
                          ),
                          SizedBox(
                            height: 60,
                            child:
                              ArchitectListCard(
                                  architectList: widget.architectList,
                                  architectIndex: architectIndex
                              )
                          )
                        ]
                    ) : Wrap(
                          children: [
                              SizedBox(
                                height: 60,
                                child: ArchitectListCard(
                                    architectList: widget.architectList,
                                    architectIndex: architectIndex
                                )
                              )
                          ]
                    )
          );
        }
    );
  }
}