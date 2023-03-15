import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/screens/HomePage/components/SearchComponent.dart';
import 'package:outline_search_bar/outline_search_bar.dart';

class CourseDetail extends StatefulWidget {
  const CourseDetail({super.key});

  @override
  State<StatefulWidget> createState() => _CourseDetailState();
}

class _CourseDetailState extends State<CourseDetail>
    with TickerProviderStateMixin {
  // Default placeholder text.
  String textToShow = 'I Like Flutter';
  int? _selectedChipIndex = 0;

  void _updateText() {
    setState(() {
      // Update the text.
      textToShow = 'Flutter is Awesome!';
    });
  }

  List<Widget> _getListData() {
    List<Widget> widgets = [];

    for (int i = 0; i < 10; i++) {
      String titleTopic = i.toString() + ". " + "Foods you love";
      widgets.add(
        Card(
          color: Colors.white,
          child: Container(
            width: 100,
            height: 100,
            margin: EdgeInsets.only(top: 16),

            child: Text(titleTopic, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400), textAlign: TextAlign.center,),
          ),
        ),
      );
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Course Detail'),
        ),
        body: Container(
          child: ListView(
            children: [
              Card(
                color: Colors.white,
                child: Column(children: [
                  Image.network(
                      "https://camblycurriculumicons.s3.amazonaws.com/5e2b895e541a832674533c18?h=d41d8cd98f00b204e9800998ecf8427e"),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Text("Basic Conversation Topics"),
                  ),
                  Container(
                    child:
                        Text("Gain confidence speaking about familliar topics"),
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
                      child: Text("Discover"),
                      onPressed: () {},
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
                            margin:
                                const EdgeInsets.only(left: 10.0, right: 20.0),
                            child: Divider(
                              color: Colors.black,
                              height: 36,
                            )),
                        Text(
                          "Overview",
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
                                  "Why take this course",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                )
                              ],
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 35, bottom: 14),
                                child: Text(
                                  "It can be intimidating to speak with a foreigner, no matter how much grammar and vocabulary you've mastered. If you have basic knowledge of English but have not spent much time speaking, this course will help you ease into your first English conversations.",
                                )),
                            Row(
                              children: [
                                Icon(
                                  Icons.question_mark_sharp,
                                  color: Colors.red,
                                ),
                                Text("What will you able to do",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ))
                              ],
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 35),
                                child: Text(
                                    "It can be intimidating to speak with a foreigner, no matter how much grammar and vocabulary you've mastered. If you have basic knowledge of English but have not spent much time speaking, this course will help you ease into your first English conversations."))
                          ],
                        ),
                      ),
                      Row(children: <Widget>[
                        Container(
                            width: 16,
                            margin:
                                const EdgeInsets.only(left: 10.0, right: 20.0),
                            child: Divider(
                              color: Colors.black,
                              height: 36,
                            )),
                        Text(
                          "Experience Level",
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
                        margin: EdgeInsets.only(top: 14, bottom: 14, left: 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.group_add_outlined,
                              color: Colors.blueAccent,
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  "Beginner",
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
                            margin:
                                const EdgeInsets.only(left: 10.0, right: 20.0),
                            child: Divider(
                              color: Colors.black,
                              height: 36,
                            )),
                        Text(
                          "Course Length",
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
                        margin: EdgeInsets.only(top: 14, bottom: 14, left: 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.book_outlined,
                              color: Colors.blueAccent,
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  "10 topics",
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
                            margin:
                                const EdgeInsets.only(left: 10.0, right: 20.0),
                            child: Divider(
                              color: Colors.black,
                              height: 36,
                            )),
                        Text(
                          "List Topics",
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
                        child: Wrap(
                          spacing: 5,
                          children: _getListData(),
                        ),
                      )
                    ],
                  ))
            ],
          ),
        ));
  }
}
