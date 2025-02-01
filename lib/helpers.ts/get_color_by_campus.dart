import 'dart:ui';

Color getColorByCampus(String campus) {
  final Map<String, Color> campusColors = {
    'Morrinhos': const Color(0xFFAEDFF7),
    'Reitoria': const Color(0xFFC8E6C9),
    'Urutaí': const Color(0xFFF4CCCC),
    'Campos Belos': const Color(0xFFFFE0B2),
    'Catalão': const Color(0xFFE1BEE7),
    'Ceres': const Color(0xFFB2EBF2),
    'Cristalina': const Color(0xFFB2DFDB),
    'Hidrolândia': const Color(0xFFF8BBD0),
    'Ipameri': const Color(0xFFFFF9C4),
    'Iporá': const Color(0xFFD7CCC8),
    'Posse': const Color(0xFFC5CAE9),
    'Rio Verde': const Color(0xFFF0F4C3),
    'Trindade': const Color(0xFFFFFF8D),
    'Polo de Inovação': const Color(0xFFFFCCBC),
    'Centro de Referência': const Color(0xFFD1C4E9),
  };

  return campusColors[campus] ?? const Color(0xFFF5F5F5);
}
