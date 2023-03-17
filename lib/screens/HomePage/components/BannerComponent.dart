import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/screens/MeetingScreen/MeetingScreen.dart';

class BannerComponent extends StatefulWidget {
  const BannerComponent({super.key});

  @override
  State<StatefulWidget> createState() => _BannerComponentState();
}

class _BannerComponentState extends State<BannerComponent> {
  // Default placeholder text.
  String schedule = 'Sat, 11 Mar 23 14:00 - 14:25';
  String totalTime = 'Total lesson time is 300 hours 25 minutes';

  void _updateText() {
    setState(() {
      // Update the text.
      schedule = 'Flutter is Awesome!';
    });
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
          Text(schedule,
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
              )),
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
          Text(totalTime,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              )),
        ])));
  }
}
