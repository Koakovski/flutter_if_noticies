import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:if_noticies/common/app_colors.dart';
import 'package:if_noticies/components/notice_card/notice_card_campus_badge.dart';
import 'package:if_noticies/components/notice_card/notice_card_subtitle.dart';
import 'package:if_noticies/components/notice_card/notice_card_title.dart';
import 'package:if_noticies/entities/notice.dart';
import 'package:url_launcher/url_launcher.dart';

class NoticeCard extends StatelessWidget {
  final Notice _notice;

  const NoticeCard({required Notice notice, super.key}) : _notice = notice;

  Future<void> redirectToUrl(String url) async {
    Uri uri = Uri.parse(url);

    if (!(await canLaunchUrl(uri))) return;

    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        redirectToUrl(_notice.url);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          color: AppColors.backgroundMuted,
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
                  style: GoogleFonts.openSansCondensed(
                    color: AppColors.textPrimary,
                    fontSize: 10,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                NoticeCardCampusBadge(_notice.campus),
              ],
            )
          ],
        ),
      ),
    );
  }
}
