import 'dart:ui';

Color getColorByCampus(String campus) {
  final Map<String, Color> campusColors = {
    'Morrinhos': const Color(0xFFC90D0F),
    'Reitoria': const Color(0xFF2F9E41),
    'Urutaí': const Color(0xFF1E3A8A),
    'Campos Belos': const Color(0xFFD97706),
    'Catalão': const Color(0xFF9333EA),
    'Ceres': const Color(0xFF047857),
    'Cristalina': const Color(0xFFB91C1C),
    'Hidrolândia': const Color(0xFFF59E0B),
    'Ipameri': const Color(0xFF3B82F6),
    'Iporá': const Color(0xFF14B8A6),
    'Posse': const Color(0xFFBE185D),
    'Rio Verde': const Color(0xFF059669),
    'Trindade': const Color(0xFFDC2626),
    'Polo de Inovação': const Color(0xFF7C3AED),
    'Centro de Referência': const Color(0xFFEA580C),
  };

  return campusColors[campus] ?? const Color(0xFF333333);
}
