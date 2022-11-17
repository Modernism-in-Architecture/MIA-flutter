import 'package:flutter/material.dart';


class ArchitectLifeInfo extends StatefulWidget {
  const ArchitectLifeInfo({Key? key, this.date="", this.place="", this.country=""})
      : super(key: key);

  final String date;
  final String place;
  final String country;

  @override
  State<ArchitectLifeInfo> createState() => _ArchitectLifeInfoState();
}

class _ArchitectLifeInfoState extends State<ArchitectLifeInfo> {

  @override
  Widget build(BuildContext context) {

    String lifeInfo = "";
    if (widget.date.isNotEmpty) {
      lifeInfo = "${widget.date} ";
    }

    if (widget.place.isNotEmpty || widget.country.isNotEmpty) {
      lifeInfo = "$lifeInfo in ";
    }

    if (widget.place.isNotEmpty) {
      lifeInfo = "$lifeInfo ${widget.place}";
    }

    if (widget.country.isNotEmpty) {
      lifeInfo = "$lifeInfo, ${widget.country}";
    }

    return Expanded(child: Text(lifeInfo, style: const TextStyle(fontSize: 16), overflow: TextOverflow.ellipsis));
  }
  }