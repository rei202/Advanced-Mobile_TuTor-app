import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/constrants/colors/MyPurple.dart';
import 'package:lettutor/models/MyAppointment.dart';
import 'package:lettutor/models/Tutor.dart';
import 'package:lettutor/models/TutorSchedule.dart';
import 'package:lettutor/screens/TutorProfile/components/Schedule.dart';
import 'package:lettutor/services/tutorService.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:video_player/video_player.dart';

import 'components/TutorInfo.dart';

class TutorProfile extends StatefulWidget {
  const TutorProfile({
    super.key,
    this.tutorId,
    this.feedbacks,
  });

  final feedbacks;
  final tutorId;

  @override
  State<StatefulWidget> createState() => _TutorProfileState();
}

class _TutorProfileState extends State<TutorProfile> {
  String textToShow = 'I Like Flutter';
  late VideoPlayerController _controller = VideoPlayerController.network(
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
  );
  late Future<Tutor?> _tutorFuture;
  late Tutor? tutor;
  late Future<List<ScheduleItem>?> schedule;
  late List<MyAppointment> meetings = <MyAppointment>[];
  bool isLoadMeetings = false;
  bool isPlayedVideo = true;

  @override
  void initState() {
    super.initState();
    print(widget.feedbacks);
    getSchedule();
    _loadTutor();
  }

  void _loadTutor() async {
    _tutorFuture = TutorService.getTutorInfomation(widget.tutorId);
    // tutor = await TutorService.getTutorInfomation(widget.tutorId);
    _tutorFuture.then((tutor) {
      _controller = VideoPlayerController.network(
        tutor?.video ??
            'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      )..initialize().then((_) {
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          setState(() {});
        });
      _controller.play();
      _controller.setLooping(true);
    });
  }

  Future<void> getSchedule() async {
    late List<MyAppointment> tempMeetings = <MyAppointment>[];
    schedule = TutorService.getTutorSchedule(widget.tutorId);
    schedule.then((schedule) {
      for (final item in schedule!) {
        final DateTime startTime =
            DateTime.fromMillisecondsSinceEpoch(item.startTime);
        final DateTime endTime =
            DateTime.fromMillisecondsSinceEpoch(item.endTime);
        tempMeetings.add(MyAppointment(
          id: item.scheduleDetail[0].id,
          isBooked: item.isBooked,
          startTime: startTime,
          endTime: endTime,
          subject: '',
          color: item.isBooked ? myLightPurle : Colors.green,
          notes: item.isBooked ? "booked" : "available",
        ));
      }
      setState(() {
        meetings = List.of(tempMeetings);
        isLoadMeetings = true;
      });
    });
  }

  List<Appointment> _getDataSource() {
    return meetings;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tutor Profile"),
      ),
      body: ListView(
        children: [
          _controller != null && _controller.value.isInitialized
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      _controller.value.isPlaying
                          ? _controller.pause()
                          : _controller.play();
                    });
                  },
                  child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                )
              : Container(),
          FutureBuilder<Tutor?>(
            future: _tutorFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: Container(
                  child: CircularProgressIndicator(),
                  margin: EdgeInsets.only(top: 100),
                ));
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              if (!snapshot.hasData) {
                return Center(child: Text('No data'));
              }
              final tutor = snapshot.data!;
              return Container(
                padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: Column(children: [
                  TutorInfo(
                    tutor: tutor,
                    meetings: meetings,
                    isLoadMeetings: isLoadMeetings,
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 15, top: 15),
                  ),
                  FutureBuilder<List<ScheduleItem>?>(
                      future: schedule,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                              child: Container(
                            child: CircularProgressIndicator(),
                            margin: EdgeInsets.only(bottom: 100),
                          ));
                        }
                        if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        }
                        if (!snapshot.hasData) {
                          return Center(child: Text('No data'));
                        }
                        final schedule = snapshot.data!;
                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: SfCalendar(
                            headerStyle: CalendarHeaderStyle(
                              textStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: myPurple,
                              ),
                            ),
                            view: CalendarView.week,
                            dataSource: MeetingDataSource(meetings),
                            timeSlotViewSettings: TimeSlotViewSettings(
                              startHour: 0,
                              endHour: 24,
                              timeFormat: 'h:mm a',
                              timeInterval: Duration(minutes: 30),
                            ),
                          ),
                        );
                      }),
                ]
                    // SearchComponent()
                    ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
