import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoticeCardSubtitle extends StatelessWidget {
  final String _subtitle;

  const NoticeCardSubtitle(String subtitle, {super.key}) : _subtitle = subtitle;

  @override
  Widget build(BuildContext context) {
    return _subtitle.isNotEmpty
        ? Column(
            children: [
              Text(
                _subtitle,
                textAlign: TextAlign.justify,
                style: GoogleFonts.openSansCondensed(
                  color: const Color(0xFF333333),
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 10),
            ],
          )
        : const SizedBox.shrink();
  }
}
