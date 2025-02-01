import 'package:flutter/material.dart';
import 'package:if_noticies/components/campus_filter/campust_filter.dart';
import 'package:if_noticies/components/notice_card/notice_card.dart';
import 'package:if_noticies/components/padding_loading_indicator.dart';
import 'package:if_noticies/entities/notice.dart';
import 'package:if_noticies/services/if_notice_api_service/service.dart';

class NoticesListScreen extends StatefulWidget {
  const NoticesListScreen({super.key});

  @override
  State<NoticesListScreen> createState() => _NoticesListScreenState();
}

class _NoticesListScreenState extends State<NoticesListScreen> {
  final IFNoticeApiService iFNoticeApiService = IFNoticeApiService();
  final ScrollController _scrollController = ScrollController();
  List<Notice> noticies = [];
  bool isLoading = false;
  bool hasMore = true;

  @override
  void initState() {
    super.initState();
    fetchNoticies();
    _scrollController.addListener(_onScroll);
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
      List<Notice> fetchedNoticies = await iFNoticeApiService.findAll(
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

  Future<void> onCampustFilterChange(List<String> campusSelected) async {
    setState(() {
      noticies = [];
    });
    fetchNoticies(campusSelected: campusSelected);
  }

  void _onScroll() {
    bool isNextToBottom = _scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100;

    if (isNextToBottom && hasMore) {
      fetchNoticies(lastId: noticies.isNotEmpty ? noticies.last.idSite : null);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IF Noticias'),
      ),
      body: Column(
        children: [
          CampusFilter(
            onCampustFilterChange: onCampustFilterChange,
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
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
