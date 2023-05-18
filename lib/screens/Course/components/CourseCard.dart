import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lettutor/models/Course.dart';
import 'package:lettutor/screens/CourseDetail/CourseDetail.dart';

class CourseCard extends StatefulWidget {
  const CourseCard({super.key, required this.course});

  final CourseModel course;

  @override
  State<StatefulWidget> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  // Default placeholder text.
  late String courseName;
  String description =
      "let's discuss how technology is changing the way we live";
  String level = "intermediate - 11 Lessons";

  void _updateText() {
    setState(() {
      // Update the text.
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // setState(() {
    //   courseName = widget.course!.name;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return (GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CourseDetail(courseId: widget.course.id,)));
        },
        child: Card(
            margin: EdgeInsets.only(bottom: 20),
            elevation: 2,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Container(
                    child: Image.network(widget.course.imageUrl),
                  ),
                  Container(
                    padding: EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40)),
                            child: Text(
                              widget.course!.name,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                            )),
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child: Text(
                            widget.course!.description,
                            style: TextStyle(
                                fontSize: 14, color: Color(0xff808080)),
                          ),
                        ),
                        Container(
                          child: Text(
                            "Level " + widget.course.level +" - " + widget.course.topics.length.toString() + " lessons",
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        )
                      ],
                    ),
                  )
                ])))));
  }
}
