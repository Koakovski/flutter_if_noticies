import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:if_noticies/components/notice_card/notice_card_campus_badge.dart';
import 'package:if_noticies/components/notice_card/notice_card_subtitle.dart';
import 'package:if_noticies/components/notice_card/notice_card_title.dart';
import 'package:if_noticies/entities/notice.dart';

class NoticeCard extends StatelessWidget {
  final Notice _notice;

  const NoticeCard({required Notice notice, super.key}) : _notice = notice;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          color: const Color(0xFF1C1E1F),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            NoticeCardTitle(_notice.title),
            NoticeCardSubtitle(_notice.subtitle),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _notice.publicationDateString,
                  style: GoogleFonts.hankenGrotesk(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
                NoticeCardCampusBadge(_notice.campus),
              ],
            )
          ],
        ));
  }
}
