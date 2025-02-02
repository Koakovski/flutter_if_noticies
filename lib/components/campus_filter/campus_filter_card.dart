import 'package:flutter/material.dart';
import 'package:if_noticies/components/campus_filter/campust_filter_item.dart';
import 'package:if_noticies/helpers.ts/get_color_by_campus.dart';

typedef OnCampusFilterItemSelectChange = void Function();

class CampusFilterCard extends StatefulWidget {
  final CampusFilterItem _campus;
  final OnCampusFilterItemSelectChange _onItemSelectChange;

  const CampusFilterCard({
    super.key,
    required CampusFilterItem campus,
    required OnCampusFilterItemSelectChange onItemSelectChange,
  })  : _campus = campus,
        _onItemSelectChange = onItemSelectChange;

  @override
  State<CampusFilterCard> createState() => _CampusFilterCardState();
}

class _CampusFilterCardState extends State<CampusFilterCard> {
  late Color _backGroundColor;
  late Color _textColor;

  @override
  void initState() {
    super.initState();
    _changeColors();
  }

  void _handleOnTap() {
    setState(() {
      widget._campus.invertSelection();
      _changeColors();
    });
    widget._onItemSelectChange();
  }

  void _changeColors() {
    Color colorByCampus = getColorByCampus(widget._campus.name);

    if (widget._campus.selected) {
      _backGroundColor = colorByCampus;
      _textColor = Colors.white;
    } else {
      _backGroundColor = Colors.transparent;
      _textColor = colorByCampus;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleOnTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: _backGroundColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: getColorByCampus(widget._campus.name),
            width: 1,
          ),
        ),
        child: Text(
          widget._campus.name,
          style: TextStyle(color: _textColor),
        ),
      ),
    );
  }
}
