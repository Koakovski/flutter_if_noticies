import 'dart:ui';

Color getColorByCampus(String campus) {
  switch (campus) {
    case 'Morrinhos':
      return const Color(0xFFAEDFF7);
    case 'Reitoria':
      return const Color(0xFFC8E6C9);
    case 'Urutaí':
      return const Color(0xFFF4CCCC);
    case 'Campos Belos':
      return const Color(0xFFFFE0B2);
    case 'Catalão':
      return const Color(0xFFE1BEE7);
    case 'Ceres':
      return const Color(0xFFB2EBF2);
    case 'Cristalina':
      return const Color(0xFFB2DFDB);
    case 'Hidrolândia':
      return const Color(0xFFF8BBD0);
    case 'Ipameri':
      return const Color(0xFFFFF9C4);
    case 'Iporá':
      return const Color(0xFFD7CCC8);
    case 'Posse':
      return const Color(0xFFC5CAE9);
    case 'Rio Verde':
      return const Color(0xFFF0F4C3);
    case 'Trindade':
      return const Color(0xFFFFFF8D);
    case 'Polo de Inovação':
      return const Color(0xFFFFCCBC);
    case 'Centro de Referência':
      return const Color(0xFFD1C4E9);
    default:
      return const Color(0xFFF5F5F5);
  }
}
