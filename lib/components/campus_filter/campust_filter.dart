import 'package:flutter/material.dart';
import 'package:if_noticies/common/app_colors.dart';
import 'package:if_noticies/components/campus_filter/campus_filter_card.dart';
import 'package:if_noticies/components/campus_filter/campust_filter_item.dart';

typedef OnCampustFilterChange = void Function();

class CampusFilter extends StatefulWidget {
  final List<CampusFilterItem> _campusList;
  final OnCampustFilterChange _onCampustFilterChange;

  const CampusFilter({
    super.key,
    required List<CampusFilterItem> campusList,
    required OnCampustFilterChange onCampustFilterChange,
  })  : _campusList = campusList,
        _onCampustFilterChange = onCampustFilterChange;

  @override
  State<CampusFilter> createState() => _CampusFilterState();
}

class _CampusFilterState extends State<CampusFilter> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40,
        color: AppColors.backgroundMuted,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget._campusList.length,
              itemBuilder: (context, position) {
                CampusFilterItem campus = widget._campusList[position];
                return CampusFilterCard(
                  campus: campus,
                  onItemSelectChange: () {
                    widget._onCampustFilterChange();
                  },
                );
              }),
        ));
  }
}
