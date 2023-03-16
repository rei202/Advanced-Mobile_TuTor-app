import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lettutor/screens/CourseDetail/CourseDetail.dart';

class CourseCard extends StatefulWidget {
  const CourseCard({super.key});

  @override
  State<StatefulWidget> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  // Default placeholder text.
  String courseName = "Life in the internet age";
  String description =
      "let's discuss how technology is changing the way we live";
  String level = "intermediate - 11 Lessons";

  void _updateText() {
    setState(() {
      // Update the text.
    });
  }

  @override
  Widget build(BuildContext context) {
    return (GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => CourseDetail()));

      },
        child:Card(
        margin: EdgeInsets.only(bottom: 20),
        elevation: 2,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            child: Image.network(
                "https://camblycurriculumicons.s3.amazonaws.com/5e0e8b212ac750e7dc9886ac?h=d41d8cd98f00b204e9800998ecf8427e"),
          ),
          Container(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(40)),
                    child: Text(
                  courseName,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Text(

                    description,
                    style: TextStyle(fontSize: 14, color: Color(0xff808080)),
                  ),
                ),
                Container(
                  child: Text(
                    level,
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                )
              ],
            ),
          )
        ])))));
  }
}
