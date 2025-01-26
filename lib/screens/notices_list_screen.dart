import 'package:flutter/material.dart';
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

  Future<void> fetchNoticies({int? lastId}) async {
    if (isLoading || !hasMore) return;

    setState(() {
      isLoading = true;
    });

    try {
      List<Notice> fetchedNoticies =
          await iFNoticeApiService.findAll(lastId: lastId);

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
          title: const Text('Notices'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemBuilder: (context, position) {
                  Notice notice = noticies[position];
                  return ListTile(
                    title: Text(notice.title),
                  );
                },
                itemCount: noticies.length,
              ),
            ),
            if (isLoading) const PaddingLoadingIndicator(),
          ],
        ));
  }
}
