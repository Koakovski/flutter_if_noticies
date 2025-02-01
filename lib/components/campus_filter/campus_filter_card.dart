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
  late Color _primaryColor;
  late Color _secondaryColor;

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
    Color black = Colors.black;
    Color mainColor = getColorByCampus(widget._campus.name);

    if (widget._campus.selected) {
      _primaryColor = mainColor;
      _secondaryColor = black;
    } else {
      _primaryColor = black;
      _secondaryColor = mainColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _handleOnTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: _primaryColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _secondaryColor,
            width: 1,
          ),
        ),
        child: Text(
          widget._campus.name,
          style: TextStyle(color: _secondaryColor),
        ),
      ),
    );
  }
}
