import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/models/Category.dart';
import 'package:lettutor/models/Course.dart';
import 'package:lettutor/services/categoryService.dart';
import 'package:lettutor/services/courseService.dart';
import 'package:outline_search_bar/outline_search_bar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import '../Widget/DropDown.dart';
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
  List<Category> categories = [];
  String textSearch = "";
  List<String> stringCategories = [];
  int selectedLevelInt = -1;
  String selectedCategoryId = "-1";
  bool isSearching = false;

  final List<String> levelItems = [
    'None Level Search',
    'Any Level',
    'Beginner',
    'Upper-Beginner',
    'Pre-Intermediate',
    'Intermediate',
    'Upper-Intermediate',
    'Pre-Advanced',
    'Advanced',
    'Upper-Advanced',
  ];

  String? selectedLevelItem;
  String? selectedCategory;

  int checkSelectedValue(String selectedValue) {
    switch (selectedValue) {
      case "None Level Search":
        return -1;
      case "Any Level":
        return 0;
      case 'Beginner':
        return 1;
      case 'Upper-Beginner':
        return 2;
      case 'Pre-Intermediate':
        return 3;
      case 'Intermediate':
        return 4;
      case 'Upper-Intermediate':
        return 5;
      case 'Pre-Advanced':
        return 6;
      case 'Advanced':
        return 7;
      case 'Upper-Advanced':
        return 8;
      default:
        return -1;
    }
  }

  String findCategoryIdByName(String name) {
    for (var category in categories) {
      if (category.title == name) {
        return category.id;
      }
    }
    return '-1'; // Trả về giá trị mặc định khi không tìm thấy category
  }

  Future<void> loadCorses(page, perPage) async {
    List<CourseModel>? temp = await CourseService.getCourseList(page, perPage);
    setState(() {
      if (temp!.isEmpty || temp!.length == 1)
        isNoCourse = true;
      else
        isNoCourse = false;
      currentPage++;
      if (page == 1) {
        currentPage = 2;
        courseList.clear();
        courseList = List.of(temp!);
      } else
        courseList.addAll(List.of(temp!));
      print("reload course list");
    });
  }

  @override
  initState() {
    // TODO: implement initState
    super.initState();
    loadCorses(1, perPage);
    getCategories();
    _scrollController.addListener(() {
      if (_scrollController.offset ==
          _scrollController.position.maxScrollExtent) {
        if (!isSearching) loadCorses(currentPage, perPage);
      }
    });
  }

  Future<void> getCategories() async {
    var temp = await CategoryService.getCategoryList();
    setState(() {
      categories = List.of(temp!);
      stringCategories.add("None Category");
      stringCategories.addAll(categories!.map((e) => e.title).toList());
    });
  }

  void checkIsSearching(){
    if(textSearch == "" && selectedLevelInt == -1 && selectedCategoryId == '-1'){
      setState(() {
        isSearching = false;
      });
    }
    else{
      setState(() {
        isSearching = true;
      });
    }
  }

  Future<void> search(searchString, page, perPage) async {
    List<CourseModel>? temp = await CourseService.searchCourse(
        page, perPage, searchString, selectedCategoryId, selectedLevelInt);
    print(temp!.length);
    setState(() {
      if (temp!.isEmpty || temp!.length == 1)
        isNoCourse = true;
      else
        isNoCourse = false;
      if (page == 1) {
        courseList.clear();
        courseList = List.of(temp!);
      } else
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
          title: const Text('Course',
                  style: TextStyle(fontWeight: FontWeight.bold))
              .tr(),
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
                        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: OutlineSearchBar(
                          hintText: "Search".tr(),
                          debounceDelay: 1000,
                          onTypingFinished: (text) {
                            print(text);
                            setState(() {
                              textSearch = text;
                            });
                            search(
                              text,
                              1,
                              100,
                            );
                            checkIsSearching();
                          },
                          onClearButtonPressed: (text) {
                            setState(() {
                              textSearch = "";
                              selectedLevelItem = "None Level Search";
                              selectedCategory = "None Category";
                              selectedLevelInt = -1;
                              selectedCategoryId = '-1';
                            });
                            loadCorses(1, perPage);
                            checkIsSearching();
                          },
                          borderRadius:
                              BorderRadius.all(const Radius.circular(10.0)),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: 5, bottom: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: CustomDropdownButton2(
                                hint: 'Level',
                                dropdownItems: levelItems,
                                value: selectedLevelItem,
                                dropdownWidth: 180,
                                onChanged: (value) {
                                  setState(() {
                                    selectedLevelItem = value;
                                    selectedLevelInt =
                                        checkSelectedValue(value!);
                                  });
                                  search(
                                    textSearch,
                                    1,
                                    100,
                                  );
                                  checkIsSearching();
                                },
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: CustomDropdownButton2(
                                hint: 'Category',
                                dropdownItems: stringCategories,
                                value: selectedCategory,
                                dropdownWidth: 180,
                                onChanged: (value) {
                                  setState(() {
                                    selectedCategory = value;
                                    selectedCategoryId = findCategoryIdByName(value!);
                                  });
                                  search(
                                    textSearch,
                                    1,
                                    100,
                                  );
                                  checkIsSearching();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]);
                  } else if (index <= courseList.length) {
                    return Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: CourseCard(
                        course: courseList[index - 1],
                      ),
                    );
                  } else {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 32),
                      child: !isNoCourse && !isSearching
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                    );
                  }
                },
              ),
            ),
            Center(
              child: Text("It's rainy here"),
            ),
          ],
        ),
      ),
    );
  }
}
