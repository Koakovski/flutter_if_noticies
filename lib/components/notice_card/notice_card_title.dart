import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoticeCardTitle extends StatelessWidget {
  final String _title;

  const NoticeCardTitle(String title, {super.key}) : _title = title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(_title,
            textAlign: TextAlign.left,
            style: GoogleFonts.openSansCondensed(
              color: const Color(0xFF333333),
              fontSize: 15,
              fontWeight: FontWeight.bold,
            )),
        const Divider(color: Color(0xFF333333)),
      ],
    );
  }
}
