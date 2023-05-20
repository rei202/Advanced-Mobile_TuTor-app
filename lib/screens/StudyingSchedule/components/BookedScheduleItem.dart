import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/models/TutorInfo.dart';
import 'package:lettutor/screens/StudyingSchedule/components/SessionItem.dart';

import '../../../constrants/colors/MyPurple.dart';
import '../../../models/Booking.dart';
import '../../HomePage/components/SkillTag.dart';

class BookedScheduleItem extends StatefulWidget {
  const BookedScheduleItem({
    required this.groupBookingItem,
    required this.callback,
    required this.key,
  }) : super(key: key);

  final Function callback;
  final Key key;
  final List<Booking> groupBookingItem;

  @override
  State<StatefulWidget> createState() => _BookedScheduleItemState();
}

class _BookedScheduleItemState extends State<BookedScheduleItem> {
  // Default placeholder text.
  late String name;
  late String toturNationality;
  String description =
      "I am passionate about running and fitness, I often compete in trail/mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also enjoy watching rugby on the weekends, reading and watching podcasts on Youtube. My most memorable life experience would be living in and traveling around Southeast Asia.";
  List<Widget> sessionList = [];
  String request =
      "I need you to help me review previous lesson because yesterday i accent";

  //resquset for lesson
  bool active = false;
  String exTitle = "Sport Categories";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    TutorInfo tutorInfo =
        widget.groupBookingItem[0].scheduleDetailInfo!.scheduleInfo!.tutorInfo!;
    setState(() {
      name = tutorInfo.name!;
      toturNationality = tutorInfo.country!;
    });
    List<Booking> booking = widget.groupBookingItem;
    sessionList.add(
      Text(
        booking.length == 1
            ? DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(
                    booking[0].scheduleDetailInfo!.startPeriodTimestamp)) +
                ' - ' +
                DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(
                    booking[0].scheduleDetailInfo!.endPeriodTimestamp))
            : "Lesson Time: " +
                DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(
                    booking[0].scheduleDetailInfo!.startPeriodTimestamp)) +
                ' - ' +
                DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(
                    booking[booking.length - 1]
                        .scheduleDetailInfo!
                        .endPeriodTimestamp)),
        style: TextStyle(fontSize: 20),
      ),
    );
    for (int i = 0; i < booking.length; i++) {
      sessionList.add(SessionItem(
        key: ValueKey(booking[i].id),
        scheduleDetailId: booking[i].id,
        sessionNumber: i.toString(),
        sessionTime: DateFormat('HH:mm').format(
                DateTime.fromMillisecondsSinceEpoch(
                    booking[i].scheduleDetailInfo!.startPeriodTimestamp)) +
            ' - ' +
            DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(
                booking[i].scheduleDetailInfo!.endPeriodTimestamp)),
        isBook: DateTime.now()
                .difference(DateTime.fromMillisecondsSinceEpoch(
                    booking[i].scheduleDetailInfo!.startPeriodTimestamp))
                .inHours <
            2,
        context: this.context,
        callback: widget.callback,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return (Container(
        color: myLighterPurle,
        padding: EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
        margin: EdgeInsets.only(bottom: 30),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            DateFormat('EEE, dd MMM yy').format(
                DateTime.fromMillisecondsSinceEpoch(widget.groupBookingItem[0]
                    .scheduleDetailInfo!.startPeriodTimestamp)),
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Card(
              child: Container(
            margin: EdgeInsets.only(top: 20, bottom: 20),
            padding: EdgeInsets.all(12),
            // color: myLightPurle,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.brown.shade800,
                  backgroundImage: NetworkImage(widget.groupBookingItem[0]
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
                          ),
                        ),
                        Text(
                          toturNationality,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    )),
                Spacer(),
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
          )),
          Card(
              child: Container(
            padding: EdgeInsets.all(20),
            alignment: Alignment.topLeft,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: sessionList,
            ),
          )),
          Container(
            margin: EdgeInsets.only(top: 5, bottom: 10, left: 5, right: 5),
            color: Colors.white,
            child: ExpansionPanelList(
              expansionCallback: (panelIndex, isExpanded) {
                active = !active;
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
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
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
                      OutlinedButton(
                          onPressed: () {}, child: Text("Edit request"))
                    ],
                  ),
                  isExpanded: active,
                  canTapOnHeader: false,
                )
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
