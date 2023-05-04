import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';
import 'package:lettutor/constrants/colors/MyPurple.dart';
import 'package:lettutor/models/Booking.dart';
import 'package:lettutor/screens/MeetingScreen/MeetingScreen.dart';
import 'package:lettutor/screens/Widget/CountdownTimeText.dart';
import 'package:lettutor/utils/OverlayWidget.dart';
import 'package:lettutor/utils/Time.dart';

class BannerComponent extends StatefulWidget {
  const BannerComponent(
      {super.key,
      required this.totalLessonTime,
      required this.upComingLession});

  final int totalLessonTime;
  final Booking upComingLession;

  @override
  State<StatefulWidget> createState() => _BannerComponentState();
}

class _BannerComponentState extends State<BannerComponent> {
  // Default placeholder text.
  String schedule = 'Sat, 11 Mar 23 14:00 - 14:25';
  String totalTime = 'Total lesson time is 300 hours 25 minutes';
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 30;
  bool isLessonEnding = false;
  @override
  void initState() {
    // TODO: implement initState
    print(widget.upComingLession.scheduleDetailInfo?.startPeriodTimestamp);
    // endTime = widget.upComingLession.scheduleDetailInfo!.startPeriodTimestamp;
    super.initState();
  }

  void onEnd() {
    print('onEnd');
    setState(() {
        isLessonEnding = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return (Container(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        height: 200,
        color: myPurple,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Text(
            "Upcomming Lesson".tr(),
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          Text(
            DateFormat('EEE, dd MMM yy HH:mm').format(
                    DateTime.fromMillisecondsSinceEpoch(widget.upComingLession
                            .scheduleDetailInfo?.startPeriodTimestamp ??
                        0)) +
                ' - ' +
                DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(
                    widget.upComingLession.scheduleDetailInfo
                            ?.endPeriodTimestamp ??
                        0)),
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.w500
            ),
          ),
              // Row( mainAxisAlignment: MainAxisAlignment.center,children: [
              //   !isLessonEnding ? Text("Starts in ", style: TextStyle(color: Colors.white),) : Container(),
              //   CountdownTimerText(timestamp: widget.upComingLession.scheduleDetailInfo!.startPeriodTimestamp)
              //   // CountdownTimer(
              //   //   endTime: endTime,
              //   //   onEnd: onEnd,
              //   //   textStyle: TextStyle(color: Colors.white),
              //   //
              //   //   endWidget: Text("The lesson has expired", style: TextStyle(color: Colors.white),),
              //   //
              //   // ),
              // ],),

          Container(
              child: ElevatedButton(
                  onPressed: () async {

                    JitsiMeetingOptions options = JitsiMeetingOptions(roomNameOrUrl:'${widget.upComingLession.userId}-${widget.upComingLession.scheduleDetailInfo!.scheduleInfo!.tutorInfo!.userId}', serverUrl: "https://meet.lettutor.com/", token: widget.upComingLession.studentMeetingLink.split('token=')[1]);
                    await JitsiMeetWrapper.joinMeeting( options: options);

                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: BorderSide(width: 1, color: Colors.black),
                      ),
                    ),
                  ),
                  child: Text(
                    "Enter lesson room".tr(),
                    style: TextStyle(color: myPurple),
                  ))),
          Text(
              "Total lesson time is ${TimeUtil.formatMinuteToHourCount(widget.totalLessonTime)}",
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              )),
        ])));
  }
}
