import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/constrants/colors/MyPurple.dart';
import 'package:lettutor/screens/HomePage/components/SearchComponent.dart';
import 'package:lettutor/screens/LessonDetail/LessonDetail.dart';
import 'package:outline_search_bar/outline_search_bar.dart';

import '../../models/Course.dart';
import '../../models/Topic.dart';
import '../../services/courseService.dart';

class CourseDetail extends StatefulWidget {
  const CourseDetail({super.key, required this.courseId});

  final String courseId;

  @override
  State<StatefulWidget> createState() => _CourseDetailState();
}

class _CourseDetailState extends State<CourseDetail>
    with TickerProviderStateMixin {
  // Default placeholder text.
  String textToShow = 'I Like Flutter';
  bool isLoading = false;
  int? _selectedChipIndex = 0;
  late CourseModel courseModel;
  late Future<CourseModel?> _courseFuture;


  Future<void> loadCorse() async {
    if (!isLoading) {
      _courseFuture = CourseService.getCourse(widget.courseId);
      setState(() {
        isLoading = true;
      });
    }
  }


  List<Widget> _getListData(List<Topic> topics) {
    List<Widget> widgets = [];

    for (int i = 1; i <= topics.length; i++) {
      String titleTopic = i.toString() + ". " + topics[i -1].name;
      widgets.add(GestureDetector(
        onTap: () {
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => LessonDetail(courseModel: cou,)));
        },
        child: Card(
          color: myLightPurle,
          child: Container(
            height: 50,
            margin: EdgeInsets.only(left: 20),
            alignment: Alignment.centerLeft,
            width: double.infinity,
            child: Text(
              titleTopic,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ));
    }
    return widgets;
  }
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadCorse();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Course Detail', style: TextStyle(fontWeight: FontWeight.bold)).tr(),
        ),
        body: FutureBuilder<CourseModel?>(
            future: _courseFuture,
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
              final course = snapshot.data!;
              final topics = _getListData(course.topics);
              return Container(
                child: ListView(
                  children: [
                    Card(
                      color: myLighterPurle,
                      child: Column(children: [
                        Image.network(course.imageUrl),
                        Container(
                          padding: EdgeInsets.all(20),
                          child: Text(
                           course.name,
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          child: Text(
                            course.description,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(20),
                          width: double.infinity,
                          child: FilledButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color?>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed)) {
                                    return Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.5);
                                  }
                                  return null; // Use the component's default.
                                },
                              ),
                            ),
                            child: Text("Discover").tr(),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LessonDetail(courseModel: course,)));
                            },
                          ),
                        ),
                      ]),
                    ),
                    Container(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Row(children: <Widget>[
                              Container(
                                  width: 16,
                                  margin: const EdgeInsets.only(
                                      left: 10.0, right: 20.0),
                                  child: Divider(
                                    color: Colors.black,
                                    height: 36,
                                  )),
                              Text(
                                "Overview".tr(),
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                child: new Container(
                                    margin: const EdgeInsets.only(
                                        left: 20.0, right: 10.0),
                                    child: Divider(
                                      color: Colors.black,
                                      height: 36,
                                    )),
                              ),
                            ]),
                            Container(
                              margin: EdgeInsets.only(top: 14, bottom: 14),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.question_mark_sharp,
                                        color: Colors.red,
                                      ),
                                      Text(
                                        "Why take this course".tr(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      )
                                    ],
                                  ),
                                  Padding(
                                      padding:
                                          EdgeInsets.only(left: 35, bottom: 14),
                                      child: Text(
                                        course.reason
                                      )),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.question_mark_sharp,
                                        color: Colors.red,
                                      ),
                                      Text("What will you able to do".tr(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ))
                                    ],
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(left: 35),
                                      child: Text(course.purpose))
                                ],
                              ),
                            ),
                            Row(children: <Widget>[
                              Container(
                                  width: 16,
                                  margin: const EdgeInsets.only(
                                      left: 10.0, right: 20.0),
                                  child: Divider(
                                    color: Colors.black,
                                    height: 36,
                                  )),
                              Text(
                                "Experience Level".tr(),
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                child: new Container(
                                    margin: const EdgeInsets.only(
                                        left: 20.0, right: 10.0),
                                    child: Divider(
                                      color: Colors.black,
                                      height: 36,
                                    )),
                              ),
                            ]),
                            Container(
                              margin: EdgeInsets.only(
                                  top: 14, bottom: 14, left: 10),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.group_add_outlined,
                                    color: myPurple,
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text(
                                        "Level " + course.level,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ))
                                ],
                              ),
                            ),
                            Row(children: <Widget>[
                              Container(
                                  width: 16,
                                  margin: const EdgeInsets.only(
                                      left: 10.0, right: 20.0),
                                  child: Divider(
                                    color: Colors.black,
                                    height: 36,
                                  )),
                              Text(
                                "Course Length".tr(),
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                child: new Container(
                                    margin: const EdgeInsets.only(
                                        left: 20.0, right: 10.0),
                                    child: Divider(
                                      color: Colors.black,
                                      height: 36,
                                    )),
                              ),
                            ]),
                            Container(
                              margin: EdgeInsets.only(
                                  top: 14, bottom: 14, left: 10),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.book_outlined,
                                    color: myPurple,
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text(
                                        "${course.topics.length} topics",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ))
                                ],
                              ),
                            ),
                            Row(children: <Widget>[
                              Container(
                                  width: 16,
                                  margin: const EdgeInsets.only(
                                      left: 10.0, right: 20.0),
                                  child: Divider(
                                    color: Colors.black,
                                    height: 36,
                                  )),
                              Text(
                                "List Topics".tr(),
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                child: new Container(
                                    margin: const EdgeInsets.only(
                                        left: 20.0, right: 10.0),
                                    child: Divider(
                                      color: Colors.black,
                                      height: 36,
                                    )),
                              ),
                            ]),
                            Container(
                              child: Column(
                                children: topics,
                              ),
                            )
                          ],
                        ))
                  ],
                ),
              );
            }));
  }
}
