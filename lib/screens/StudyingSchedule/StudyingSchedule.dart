import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/screens/StudyingSchedule/components/BookedScheduleItem.dart';
import 'package:video_player/video_player.dart';

class StudyingSchedule extends StatefulWidget {
  const StudyingSchedule({super.key});

  @override
  State<StatefulWidget> createState() => _StudyingScheduleState();
}

class _StudyingScheduleState extends State<StudyingSchedule> {
  // Default placeholder text.
  String textToShow = 'I Like Flutter';
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    // _controller = VideoPlayerController.network(
    //     'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
    //   ..initialize().then((_) {
    //     // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
    //     setState(() {});
    //   });
    // _controller.play();
    // _controller.setLooping(true);
  }

  void _updateText() {
    setState(() {
      // Update the text.
      textToShow = 'Flutter is Awesome!';
    });
  }

  // List<Widget> _getListData() {
  //   List<Widget> widgets = [];
  //   widgets.add(
  //     Container(
  //         margin: EdgeInsets.only(top: 16, bottom: 8),
  //         alignment: Alignment.topLeft,
  //         child: Text(
  //           "Recommended Tutors",
  //           textAlign: TextAlign.start,
  //           style: TextStyle(
  //             fontWeight: FontWeight.bold,
  //             fontSize: 25,
  //             color: Colors.black,
  //           ),
  //         )),
  //   );
  //   for (int i = 0; i < 10; i++) {
  //     widgets.add(TutorInfoCard());
  //   }
  //   return widgets;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Schedule"),
      ),
        body: Container(
          padding: EdgeInsets.only(top:30, left: 10, right: 10),
      child: ListView(children: [BookedScheduleItem(), BookedScheduleItem()]),
    ));
  }
}
