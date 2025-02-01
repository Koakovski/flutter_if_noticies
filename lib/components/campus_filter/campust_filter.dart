import 'package:flutter/material.dart';
import 'package:if_noticies/components/campus_filter/campus_filter_card.dart';
import 'package:if_noticies/components/campus_filter/campust_filter_item.dart';

typedef OnCampustFilterChange = void Function(List<String>);

class CampusFilter extends StatefulWidget {
  final OnCampustFilterChange _onCampustFilterChange;

  const CampusFilter({super.key, onCampustFilterChange})
      : _onCampustFilterChange = onCampustFilterChange;

  @override
  State<CampusFilter> createState() => _CampusFilterState();
}

class _CampusFilterState extends State<CampusFilter> {
  final List<CampusFilterItem> _campusList = [
    CampusFilterItem(name: 'Morrinhos'),
    CampusFilterItem(name: 'Reitoria'),
    CampusFilterItem(name: 'Urutaí'),
    CampusFilterItem(name: 'Campos Belos'),
    CampusFilterItem(name: 'Catalão'),
    CampusFilterItem(name: 'Ceres'),
    CampusFilterItem(name: 'Cristalina'),
    CampusFilterItem(name: 'Hidrolândia'),
    CampusFilterItem(name: 'Ipameri'),
    CampusFilterItem(name: 'Iporá'),
    CampusFilterItem(name: 'Posse'),
    CampusFilterItem(name: 'Rio Verde'),
    CampusFilterItem(name: 'Trindade'),
    CampusFilterItem(name: 'Polo de Inovação'),
    CampusFilterItem(name: 'Centro de Referência'),
  ];

  void onItemSelectChange() {
    List<String> selectedCampus = _campusList
        .where((campus) => campus.selected)
        .map((campus) => campus.name)
        .toList();

    widget._onCampustFilterChange(selectedCampus);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 40,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _campusList.length,
              itemBuilder: (context, position) {
                CampusFilterItem campus = _campusList[position];
                return CampusFilterCard(
                  campus: campus,
                  onItemSelectChange: onItemSelectChange,
                );
              }),
        ));
  }
}
