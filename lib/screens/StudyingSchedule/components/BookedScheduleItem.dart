import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lettutor/screens/StudyingSchedule/components/SessionItem.dart';

import '../../HomePage/components/SkillTag.dart';

class BookedScheduleItem extends StatefulWidget {
  const BookedScheduleItem({super.key});

  @override
  State<StatefulWidget> createState() => _BookedScheduleItemState();
}

class _BookedScheduleItemState extends State<BookedScheduleItem> {
  // Default placeholder text.
  String lessonTime = "16:00 - 22:25";
  String bookingDate = "Wed, 15 Mar 23";
  String name = 'Keegan';
  String toturNationality = "Viet Nam";
  String description =
      "I am passionate about running and fitness, I often compete in trail/mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also enjoy watching rugby on the weekends, reading and watching podcasts on Youtube. My most memorable life experience would be living in and traveling around Southeast Asia.";
  List<Widget> sessionList = [];

  void _updateText() {
    setState(() {
      // Update the text.
      name = 'Flutter is Awesome!';
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sessionList.add(
      Text(
        "Lesson Time: " + lessonTime,
        style: TextStyle(fontSize: 20),
      ),
    );
    for (int i = 0; i < 10; i++) {
      sessionList.add(SessionItem(
          sessionNumber: i.toString(),
          sessionTime: "16:00 - 16:25",
          isBook: true));
    }
  }

  @override
  Widget build(BuildContext context) {
    return (Container(
        color: Color(0xfff1f1f1),
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.only(bottom: 30),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            bookingDate,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Container(
            margin: EdgeInsets.only(top:20, bottom: 20),
            padding: EdgeInsets.all(12),
            color: Colors.white,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.brown.shade800,
                  child: const Text('AH'),
                ),
                Container(
                    height: 70,
                    margin: EdgeInsets.only(left: 22),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          name,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          toturNationality,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        RatingBar.builder(
                          itemSize: 15,
                          initialRating: 0,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        )
                      ],
                    )),
                Spacer(),
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            alignment: Alignment.topLeft,
            width: double.infinity,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: sessionList,
            ),
          )
        ])));
  }
}
