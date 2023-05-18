import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/services/classService.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../constrants/colors/MyPurple.dart';
import '../../../models/MyAppointment.dart';
import '../../../models/TutorSchedule.dart';
import '../TutorProfile.dart';

class BookingClass extends StatefulWidget {
  const BookingClass({Key? key, required this.meetings}) : super(key: key);
  final List<MyAppointment> meetings;

  @override
  State<BookingClass> createState() => _BookingClassState();
}

class _BookingClassState extends State<BookingClass> {
  String time = "Choose a available time";
  String status = "booked";
  String selectedId = "";
  TextEditingController _noteTextController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.meetings);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Booking", style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.only(top: 10),
          child: ListView(children: [
            Container(
              margin: EdgeInsets.only(
                bottom: 10,
              ),
              child: Text(
                "Select your expected time",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                  ),
                ),
                SizedBox(width: 4),
                Text('Available', style: TextStyle(fontSize: 12)),
                SizedBox(width: 16),
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: myLightPurle,
                  ),
                ),
                SizedBox(width: 4),
                Text('Booked', style: TextStyle(fontSize: 12)),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: SfCalendar(
                view: CalendarView.week,
                dataSource: MeetingDataSource(widget.meetings),
                headerStyle: CalendarHeaderStyle(
                  textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: myPurple,
                  ),
                ),
                timeSlotViewSettings: TimeSlotViewSettings(
                  startHour: 0,
                  endHour: 24,
                  timeFormat: 'h:mm a',
                  timeInterval: Duration(minutes: 30),
                ),
                onTap: (calendarTapDetails) {
                  if (calendarTapDetails.targetElement ==
                      CalendarElement.appointment) {
                    final tappedAppointment =
                        calendarTapDetails.appointments![0];
                    // do something with the tappedAppointment
                    print(tappedAppointment);
                    setState(() {
                      time = DateFormat('HH:mm')
                              .format(tappedAppointment.startTime) +
                          " - " +
                          DateFormat('HH:mm')
                              .format(tappedAppointment.endTime) +
                          " " +
                          DateFormat('EEEE, dd/MM/yyyy')
                              .format(tappedAppointment.startTime);
                      status = tappedAppointment.notes;
                      selectedId = tappedAppointment.id;
                    });
                  }
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10, top: 20),
              child: Text(
                "Booking Time",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Container(
              color: myLighterPurle,
              height: 40,
              alignment: Alignment.center,
              child: Text(
                time,
                style: TextStyle(
                    fontSize: 16, color: myPurple, fontWeight: FontWeight.w500),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10, top: 20),
              child: Text(
                "Notes",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500),
              ),
            ),
            TextFormField(
              controller: _noteTextController,
              maxLines: 2,
              decoration: InputDecoration(
                hintText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10, top: 20),
            ),
            FilledButton(
                onPressed: status == "booked"
                    ? null
                    : () async {
                        print(selectedId);
                        print(_noteTextController.text);
                        var response = await ClassService.bookClass(
                            selectedId, _noteTextController.text);
                        if (response['isSuccess']) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text(
                                'Successful',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16),
                              ),
                              backgroundColor: Colors.green,
                            ),
                          );
                          Future.delayed(Duration(seconds: 2), () {
                            Navigator.pop(context);
                          });
                        } else {
                          if(response['status'] == 400){
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text(
                                  'Booking has already exists',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 16),
                                ),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        }
                      },
                child: Text("Book"))
          ] // SearchComponent()
              ),
        ));
  }
}
