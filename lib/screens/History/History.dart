import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/screens/History/components/HistoryItem.dart';
import 'package:lettutor/screens/StudyingSchedule/components/BookedScheduleItem.dart';
import 'package:video_player/video_player.dart';

import '../../models/Booking.dart';
import '../../services/classService.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<StatefulWidget> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  // Default placeholder text.
  String textToShow = 'I Like Flutter';
  bool isLoading = false;
  late List<Booking> bookingList = [];
  int currentPage = 1;
  final ScrollController _scrollController = ScrollController();
  int perPage = 10;

  @override
  void initState() {
    super.initState();
    loadMoreStudyingScheduleList(1, perPage);
    _scrollController.addListener(() {
      if (_scrollController.offset ==
          _scrollController.position.maxScrollExtent) {
        loadMoreStudyingScheduleList(currentPage, perPage);
      }
    });
  }

  void initStudyingScheduleList(page, perPage) async {
    int timeStampNow = DateTime.now().millisecondsSinceEpoch;
    if (!isLoading) {
      var temp = await ClassService.getsortedBookingList(
          page, perPage, timeStampNow, "desc");
      setState(() {
        currentPage++;
        isLoading = true;
        bookingList.addAll(List.of(temp!));
      });
    }
  }

  void loadMoreStudyingScheduleList(page, perPage) async {
    setState(() {
      // isInProgress = true;
    });
    int timeStampNow = DateTime.now().millisecondsSinceEpoch;
    var temp = await ClassService.getsortedBookingList(
        page, perPage, timeStampNow, "desc");
    setState(() {
      currentPage++;
      bookingList.addAll(temp!);
      // isInProgress = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("History"),
        ),
        body: Container(
            padding: EdgeInsets.only(top: 30, left: 10, right: 10),
            child: ListView.builder(
                controller: _scrollController,
                itemCount: bookingList.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index < bookingList.length)
                    return HistoryItem(booking: bookingList[index],);
                  else
                    return Padding(
                        padding: EdgeInsets.symmetric(vertical: 32),
                        child: Center(child: CircularProgressIndicator()));
                })));
  }
}
