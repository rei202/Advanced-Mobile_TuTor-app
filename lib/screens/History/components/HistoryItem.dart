import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/models/Booking.dart';
import 'package:lettutor/models/TutorInfo.dart';
import 'package:lettutor/screens/StudyingSchedule/components/SessionItem.dart';

import '../../HomePage/components/SkillTag.dart';

class HistoryItem extends StatefulWidget {
  const HistoryItem({super.key, required this.booking});

  final Booking booking;

  @override
  State<StatefulWidget> createState() => _HistoryItemState();
}

class _HistoryItemState extends State<HistoryItem> {
  // Default placeholder text.
  late String bookingDate;
  late String name;
  late String toturNationality;
  String description =
      "I am passionate about running and fitness, I often compete in trail/mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also enjoy watching rugby on the weekends, reading and watching podcasts on Youtube. My most memorable life experience would be living in and traveling around Southeast Asia.";
  List<Widget> sessionList = [];
  String request =
      "I need you to help me review previous lesson because yesterday i accent";

  //resquset for lesson
  bool isRequestFieldExpand = false;

  // review from tutor
  bool isReviewFieldExpand = false;

  void _updateText() {
    setState(() {
      // Update the text.
      name = 'Flutter is Awesome!';
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    TutorInfo tutorInfo =
        widget.booking.scheduleDetailInfo!.scheduleInfo!.tutorInfo!;
    setState(() {
      name = tutorInfo.name!;
      toturNationality = tutorInfo.country!;
      bookingDate = DateFormat('EEE, dd MMM yy').format(
          DateTime.fromMillisecondsSinceEpoch(
              widget.booking.scheduleDetailInfo!.startPeriodTimestamp));
    });
    super.initState();
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
            margin: EdgeInsets.only(top: 20, bottom: 20),
            padding: EdgeInsets.all(12),
            color: Colors.white,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.brown.shade800,
                  backgroundImage: NetworkImage(widget.booking
                      .scheduleDetailInfo!.scheduleInfo!.tutorInfo!.avatar!),
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
            child: Text(
              "Lesson Time: " +
                  DateFormat('HH:mm').format(
                      DateTime.fromMillisecondsSinceEpoch(widget
                          .booking.scheduleDetailInfo!.startPeriodTimestamp)) +
                  ' - ' +
                  DateFormat('HH:mm').format(
                      DateTime.fromMillisecondsSinceEpoch(widget
                          .booking.scheduleDetailInfo!.endPeriodTimestamp)),
              style: TextStyle(fontSize: 20),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            color: Colors.white,
            child: ExpansionPanelList(
              expansionCallback: (panelIndex, isExpanded) {
                isRequestFieldExpand = !isRequestFieldExpand;
                setState(() {});
              },
              children: <ExpansionPanel>[
                ExpansionPanel(
                  headerBuilder: (context, isExpanded) {
                    return Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          "Request for lesson",
                          style: TextStyle(fontSize: 14),
                        ));
                  },
                  body: Wrap(
                    alignment: WrapAlignment.end,
                    spacing: 8,
                    children: [
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.deepPurple,
                            border: Border.all(color: Colors.grey)),
                        width: double.infinity,
                        child: Text(
                          request,
                          style: TextStyle(
                              fontSize: 14, height: 1.5, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  isExpanded: isRequestFieldExpand,
                  canTapOnHeader: false,
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5, bottom: 5),
            color: Colors.white,
            child: ExpansionPanelList(
              expansionCallback: (panelIndex, isExpanded) {
                isReviewFieldExpand = !isReviewFieldExpand;
                setState(() {});
              },
              children: <ExpansionPanel>[
                ExpansionPanel(
                  headerBuilder: (context, isExpanded) {
                    return Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          "Review from tutor",
                          style: TextStyle(fontSize: 14),
                        ));
                  },
                  body: Wrap(
                    alignment: WrapAlignment.end,
                    spacing: 8,
                    children: [
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.deepPurple,
                            border: Border.all(color: Colors.grey)),
                        width: double.infinity,
                        child: Text(
                          request,
                          style: TextStyle(
                              fontSize: 14, height: 1.5, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  isExpanded: isReviewFieldExpand,
                  canTapOnHeader: false,
                )
              ],
            ),
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Row(
              children: [
                TextButton(onPressed: () {}, child: Text("Add a rating")),
                Spacer(),
                TextButton(onPressed: () {}, child: Text("Report")),
              ],
            ),
          )
        ])));
  }

  Future<void> _showAlertDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // <-- SEE HERE
          title: const Text('Cancel booking'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Are you sure want to cancel booking?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
