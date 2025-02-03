import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:if_noticies/common/app_colors.dart';
import 'package:if_noticies/common/campus.dart';
import 'package:if_noticies/components/campus_filter/campust_filter.dart';
import 'package:if_noticies/components/campus_filter/campust_filter_item.dart';
import 'package:if_noticies/components/connectivity_icon.dart';
import 'package:if_noticies/components/notice_card/notice_card.dart';
import 'package:if_noticies/components/padding_loading_indicator.dart';
import 'package:if_noticies/entities/notice.dart';
import 'package:if_noticies/helpers.ts/has_internet_access.dart';
import 'package:if_noticies/services/notice_fetcher_service/notice_fetcher_service.dart';

class NoticesListScreen extends StatefulWidget {
  const NoticesListScreen({super.key});

  @override
  State<NoticesListScreen> createState() => _NoticesListScreenState();
}

class _NoticesListScreenState extends State<NoticesListScreen> {
  final NoticeFetcherService noticeFetcherService = NoticeFetcherService();
  final ScrollController scrollController = ScrollController();
  final List<CampusFilterItem> campusList = CampusFilterItem.buildList(campus);
  List<Notice> noticies = [];
  bool isLoading = false;
  bool hasMore = true;

  bool hasConnection = true;
  late Timer connectionTimer;

  @override
  void initState() {
    super.initState();
    fetchNoticies();
    updateConnectionStatus();

    scrollController.addListener(_onScroll);
    startMonitoringConnection();
  }

  void startMonitoringConnection() {
    connectionTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      updateConnectionStatus();
    });
  }

  Future<void> updateConnectionStatus() async {
    bool hasConnectionNow = await hasInternetAccess();
    if (hasConnectionNow == true && hasConnection == false) {
      hasMore = true;
    }

    setState(() {
      hasConnection = hasConnectionNow;
    });
  }

  Future<void> fetchNoticies({
    int? lastId,
    List<String> campusSelected = const [],
  }) async {
    if (isLoading || !hasMore) return;

    setState(() {
      isLoading = true;
    });

    try {
      List<Notice> fetchedNoticies = await noticeFetcherService.findAll(
        lastId: lastId,
        campus: campusSelected,
      );

      setState(() {
        if (fetchedNoticies.isEmpty) {
          hasMore = false;
        } else {
          noticies.addAll(fetchedNoticies);
        }
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  int? lastNoticeId() {
    return noticies.isNotEmpty ? noticies.last.idSite : null;
  }

  List<CampusFilterItem> campustSelected() {
    return campusList.where((campus) => campus.selected).toList();
  }

  List<String> campustSelectedNames() {
    return campustSelected().map((campus) => campus.name).toList();
  }

  void onCampustFilterChange() {
    setState(() {
      noticies = [];
    });
    hasMore = true;
    fetchNoticies(
      lastId: lastNoticeId(),
      campusSelected: campustSelectedNames(),
    );
  }

  void _onScroll() {
    bool isNextToBottom = scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 100;

    if (isNextToBottom && hasMore) {
      fetchNoticies(
        lastId: lastNoticeId(),
        campusSelected: campustSelectedNames(),
      );
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    connectionTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IF Noticias'),
        actions: [ConnectivityIcon(hasConnection: hasConnection)],
      ),
      body: Column(
        children: [
          CampusFilter(
            campusList: campusList,
            onCampustFilterChange: onCampustFilterChange,
          ),
          Expanded(
            child: isLoading == false && noticies.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Nenhuma notícia encontrada',
                        style: GoogleFonts.openSansCondensed(
                          color: AppColors.primary,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                : ListView.builder(
                    controller: scrollController,
                    itemBuilder: (context, position) {
                      Notice notice = noticies[position];
                      return NoticeCard(notice: notice);
                    },
                    itemCount: noticies.length,
                  ),
          ),
          if (isLoading) const PaddingLoadingIndicator(),
        ],
      ),
    );
  }
}
