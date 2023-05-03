import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/constrants/colors/MyPurple.dart';
import 'package:lettutor/screens/StudyingSchedule/components/BookedScheduleItem.dart';
import 'package:lettutor/services/classService.dart';
import 'package:lettutor/utils/Schedule.dart';
import 'package:video_player/video_player.dart';

import '../../models/Booking.dart';
import '../../services/callService.dart';
import '../../utils/Time.dart';

class StudyingSchedule extends StatefulWidget {
  const StudyingSchedule({super.key});

  @override
  State<StatefulWidget> createState() => _StudyingScheduleState();
}

class _StudyingScheduleState extends State<StudyingSchedule> {
  // Default placeholder text.
  String textToShow = 'I Like Flutter';
  late VideoPlayerController _controller;
  bool isLoading = false;
  late List<List<Booking>> bookingList = [];
  int currentPage = 1;
  final ScrollController _scrollController = ScrollController();
  int perPage = 10;
  int totalLessonTime = 0;
  // bool isInProgress = false;

  @override
  void initState() {
    super.initState();
    getTotalLessonTime();
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
      var temp =
          await ClassService.getsortedBookingList(page, perPage, timeStampNow, "asc");
      setState(() {
        currentPage++;
        isLoading = true;
        bookingList.addAll(List.of(ScheduleUtils.groupScheduleItems(temp!)));
      });
    }
  }

  void loadMoreStudyingScheduleList(page, perPage) async {
    setState(() {
      // isInProgress = true;
    });
    int timeStampNow = DateTime.now().millisecondsSinceEpoch;
    var temp =
        await ClassService.getsortedBookingList(page, perPage, timeStampNow, "asc");
    setState(() {
      currentPage++;
      bookingList.addAll(ScheduleUtils.groupScheduleItems(temp!));
      // isInProgress = false;
    });
  }

  Future<void> getTotalLessonTime() async {
    int time = await CallService.getTotalTimeLesson();
    setState(() {
      totalLessonTime = time;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Schedule", style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        body: Container(
            padding: EdgeInsets.only(top: 30, left: 10, right: 10),
            child: ListView.builder(
                controller: _scrollController,
                itemCount: bookingList.length + 2,
                itemBuilder: (BuildContext context, int index) {
                  if(index == 0)
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      margin: EdgeInsets.only(bottom: 10),
                      alignment: Alignment.center,
                      color: myPurple,
                      child: Text(
                        'Total time lesson: ${TimeUtil.formatMinuteToHourCount(totalLessonTime)}',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                    );
                  else if (index <= bookingList.length)
                    return BookedScheduleItem(
                        groupBookingItem: bookingList[index - 1]);
                  else
                    return Padding(
                        padding: EdgeInsets.symmetric(vertical: 32),
                        child: Center(child: CircularProgressIndicator()));
                })));
  }
}
