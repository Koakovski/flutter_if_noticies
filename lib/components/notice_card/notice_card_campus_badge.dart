import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:if_noticies/helpers.ts/get_color_by_campus.dart';

class NoticeCardCampusBadge extends StatelessWidget {
  final String _campus;
  const NoticeCardCampusBadge(String campus, {super.key}) : _campus = campus;

  @override
  Widget build(BuildContext context) {
    return Text(
      _campus,
      style: GoogleFonts.openSansCondensed(
        fontSize: 10,
        fontWeight: FontWeight.bold,
        color: getColorByCampus(_campus),
      ),
    );
  }
}
