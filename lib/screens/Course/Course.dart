import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/screens/HomePage/components/SearchComponent.dart';
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

  void _updateText() {
    setState(() {
      // Update the text.
      textToShow = 'Flutter is Awesome!';
    });
  }

  List<Widget> _getListData() {
    List<Widget> widgets = [];
    widgets.add(
      Container(
        margin: EdgeInsets.only(top: 16, bottom: 8),
      ),
    );
    for (int i = 0; i < 10; i++) {
      widgets.add(CourseCard());
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Course'),
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
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Container(
                          padding:
                              EdgeInsets.only(left: 20, right: 20, top: 20),
                          child: OutlineSearchBar(
                            hintText: "Search course",
                            debounceDelay: 3,
                            borderRadius:
                                BorderRadius.all(const Radius.circular(10.0)),
                          )),
                      Container(
                        padding: EdgeInsets.only(left: 20,right: 20,top: 5),
                        child: Wrap(
                          spacing: 5.0,
                          children: List<Widget>.generate(
                            3,
                            (int index) {
                              return ChoiceChip(
                                // selectedColor: Colors.amberAccent,
                                selectedShadowColor: Colors.cyanAccent,
                                label: Text('English for travel', style: TextStyle(fontSize: 10),),
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
                      Container(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          children:
                              // SearchComponent()
                              _getListData(),
                        ),
                      )
                    ],
                  ),
                ),
                Center(
                  child: Text("It's rainy here"),
                ),
              ],
            )));
  }
}
