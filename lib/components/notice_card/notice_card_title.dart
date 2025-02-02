import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:if_noticies/common/app_colors.dart';

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
              color: AppColors.textPrimary,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            )),
        const Divider(color: AppColors.textPrimary),
      ],
    );
  }
}
