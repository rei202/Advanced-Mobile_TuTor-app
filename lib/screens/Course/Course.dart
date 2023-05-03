import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/models/Course.dart';
import 'package:lettutor/services/courseService.dart';
import 'package:outline_search_bar/outline_search_bar.dart';

import 'components/CourseCard.dart';

class Course extends StatefulWidget {
  const Course({super.key});

  @override
  State<StatefulWidget> createState() => _CourseState();
}

class _CourseState extends State<Course> with TickerProviderStateMixin {
  // Default placeholder text.
  String textToShow = 'I Like Flutter';
  int? _selectedChipIndex = 0;
  int page = 1;
  int size = 100;
  List<CourseModel> courseList = [];
  bool isLoading = false;

  Future<void> loadCorses() async {
    if (!isLoading) {
      List<CourseModel>? temp = await CourseService.getCourseList(page, size);
      setState(() {
        courseList.addAll(List.of(temp!));
        isLoading = true;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadCorses();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Course', style: TextStyle(fontWeight: FontWeight.bold)),
              bottom: TabBar(
                tabs: <Widget>[
                  Tab(
                    icon: Icon(Icons.book_online_outlined),
                    text: "Course",
                  ),
                  Tab(
                    icon: Icon(Icons.book),
                    text: "Book",
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                Center(
                  // child: ListView(
                  //   shrinkWrap: true,
                  //   children: [
                  //     Container(
                  //         padding:
                  //             EdgeInsets.only(left: 20, right: 20, top: 20),
                  //         child: OutlineSearchBar(
                  //           hintText: "Search course",
                  //           debounceDelay: 3,
                  //           borderRadius:
                  //               BorderRadius.all(const Radius.circular(10.0)),
                  //         )),
                  //     Container(
                  //       padding: EdgeInsets.only(left: 20, right: 20, top: 5),
                  //       child: Wrap(
                  //         spacing: 5.0,
                  //         children: List<Widget>.generate(
                  //           3,
                  //           (int index) {
                  //             return ChoiceChip(
                  //               // selectedColor: Colors.amberAccent,
                  //               selectedShadowColor: Colors.cyanAccent,
                  //               label: Text(
                  //                 'English for travel',
                  //                 style: TextStyle(fontSize: 10),
                  //               ),
                  //               selected: _selectedChipIndex == index,
                  //               onSelected: (bool selected) {
                  //                 setState(() {
                  //                   _selectedChipIndex =
                  //                       selected ? index : null;
                  //                 });
                  //               },
                  //             );
                  //           },
                  //         ).toList(),
                  //       ),
                  //     ),
                  //     Container(
                  //       padding: EdgeInsets.only(left: 20, right: 20),
                  //       child: Column(children: [
                  //         Container(
                  //           child: ListView.builder(
                  //               itemCount: courseList.length + 1,
                  //               itemBuilder: (BuildContext context, int index) {
                  //                 if (index < courseList.length)
                  //                   return CourseCard();
                  //               }),
                  //         )
                  //       ]
                  //           // SearchComponent()
                  //           // _getListData(),
                  //
                  //           ),
                  //     )
                  //   ],
                  // ),
                  child: ListView.builder(
                      itemCount: courseList.length + 1,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == 0) {
                          return Column(children: [
                            Container(
                                padding: EdgeInsets.only(
                                    left: 20, right: 20, top: 20),
                                child: OutlineSearchBar(
                                  hintText: "Search course",
                                  debounceDelay: 3,
                                  borderRadius: BorderRadius.all(
                                      const Radius.circular(10.0)),
                                )),
                            Container(
                              padding:
                                  EdgeInsets.only(left: 20, right: 20, top: 5),
                              child: Wrap(
                                spacing: 5.0,
                                children: List<Widget>.generate(
                                  3,
                                  (int index) {
                                    return ChoiceChip(
                                      // selectedColor: Colors.amberAccent,
                                      selectedShadowColor: Colors.cyanAccent,
                                      label: Text(
                                        'English for travel',
                                        style: TextStyle(fontSize: 10),
                                      ),
                                      selected: _selectedChipIndex == index,
                                      onSelected: (bool selected) {
                                        setState(() {
                                          _selectedChipIndex =
                                              selected ? index : null;
                                        });
                                      },
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                          ]);
                        } else if (index <= courseList.length)
                          return Container(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: CourseCard(
                                course: courseList[index - 1],
                              ));
                      }),
                ),
                Center(
                  child: Text("It's rainy here"),
                ),
              ],
            )));
  }
}
