class CampusFilterItem {
  final String _name;
  bool _selected;

  CampusFilterItem({required String name, bool? selected})
      : _name = name,
        _selected = selected ?? false;

  String get name {
    return _name;
  }

  bool get selected {
    return _selected;
  }

  void invertSelection() {
    _selected = !_selected;
  }
}
