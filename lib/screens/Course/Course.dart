import 'package:easy_localization/easy_localization.dart';
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
  int currentPage = 1;
  int perPage = 5;
  List<CourseModel> courseList = [];
  bool isLoading = false;
  bool isNoCourse = false;
  final ScrollController _scrollController = ScrollController();

  Future<void> loadCorses(page, perPage) async  {
      List<CourseModel>? temp = await CourseService.getCourseList(page, perPage);
      setState(() {
        if (temp!.isEmpty || temp!.length == 1)
          isNoCourse = true;
        else
          isNoCourse = false;
        currentPage++;
        if (page == 1){
          currentPage = 2;
          courseList.clear();
          courseList = List.of(temp!);
        }
        else
          courseList.addAll(List.of(temp!));
        print("reload course list");
      });

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadCorses(1, perPage);
    _scrollController.addListener(() {
      if (_scrollController.offset ==
          _scrollController.position.maxScrollExtent) {
        loadCorses(currentPage, perPage);
      }
    });
  }

  Future<void> search(searchString, page, perPage) async {
    List<CourseModel>? temp = await CourseService.searchCourse(page, perPage, searchString);
    print(temp!.length);
    setState(() {
      if (temp!.isEmpty || temp!.length == 1)
        isNoCourse = true;
      else
        isNoCourse = false;
      if (page == 1){
        courseList.clear();
        courseList = List.of(temp!);
      }
      else
        courseList.addAll(List.of(temp!));
      print("search course list");
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Course', style: TextStyle(fontWeight: FontWeight.bold)).tr(),
              bottom: TabBar(
                tabs: <Widget>[
                  Tab(
                    icon: Icon(Icons.book_online_outlined),
                    text: "Course".tr(),
                  ),
                  Tab(
                    icon: Icon(Icons.book),
                    text: "Book2".tr(),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                Center(
                  child: ListView.builder(
                      controller: _scrollController,
                      itemCount: courseList.length + 2,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == 0) {
                          return Column(children: [
                            Container(
                                padding: EdgeInsets.only(
                                    left: 20, right: 20, top: 20),
                                child: OutlineSearchBar(
                                  hintText: "Search".tr(),
                                  debounceDelay: 1000,
                                  onTypingFinished: (text) {
                                    print(text);
                                    search(text, 1, 100);
                                  },
                                  onClearButtonPressed: (text) {
                                    loadCorses(1, perPage);
                                  },
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
                        else
                          return Padding(
                              padding: EdgeInsets.symmetric(vertical: 32),
                              child: !isNoCourse
                                  ? Center(child: CircularProgressIndicator())
                                  : Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset('images/empty-box.png',
                                        width: 70, height: 70),
                                    SizedBox(height: 5.0),
                                    Text(
                                      'No Course',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
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
