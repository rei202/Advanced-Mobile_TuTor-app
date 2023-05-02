import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/models/Booking.dart';
import 'package:lettutor/screens/MeetingScreen/MeetingScreen.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    print(widget.upComingLession.scheduleDetailInfo?.startPeriodTimestamp);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (Container(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        height: 150,
        color: Colors.blueAccent,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Text(
            "Upcomming Lesson",
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
          Container(
              child: ElevatedButton(
                  onPressed: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MeetingScreen()));
                    // var options = JitsiMeetingOptions(
                    //     room:
                    //         "myroom") // room is Required, spaces will be trimmed
                    //   ..serverURL = "https://meet.lettutor.com"
                    //   ..subject = "Meeting with Gunschu"
                    //   ..userDisplayName = "My Name"
                    //   ..userEmail = "myemail@email.com"
                    //   ..audioOnly = true
                    //   ..audioMuted = true
                    //   ..token = "213213213213"
                    //   ..videoMuted = true;
                    //
                    // await JitsiMeet.joinMeeting(options);
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
                    "Enter lesson room",
                    style: TextStyle(color: Colors.blue),
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
