import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/constrants/colors/MyPurple.dart';
import 'package:lettutor/models/Booking.dart';
import 'package:lettutor/models/FavoriteTutor.dart';
import 'package:lettutor/services/callService.dart';
import 'package:lettutor/services/classService.dart';
import 'package:lettutor/services/searchService.dart';
import 'package:lettutor/services/tutorService.dart';
import 'package:lettutor/utils/Time.dart';
import 'package:outline_search_bar/outline_search_bar.dart';

import '../../models/Tutor.dart';
import 'components/BannerComponent.dart';
import 'components/TutorInfoCard.dart';

List<String> specialties = [
  'english-for-kids',
  'business-english',
  'conversational-english',
  'starters',
  'movers',
  'flyers',
  'ket',
  'pet',
  'ielts',
  'toefl',
  'toeic'
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Default placeholder text.
  String textToShow = 'I Like Flutter';
  List<Tutor> tutorList = [];
  List<Tutor> originalTutorList = [];
  List<Tutor> favoriteList = [];
  int? _selectedChipIndex = 0;
  final ScrollController _scrollController = ScrollController();

  final List<String> _filters = <String>[];
  String searchString = "";
  int page = 1;
  int perPage = 10;
  int currentPage = 1;
  int searchPage = 1;
  int searchPerPage = 2;
  int searchCurrentPage = 1;
  bool isLoading = false;
  String dropdownValue = 'None';
  int totalLessonTime = 0;
  List<Booking> bookingList = [];
  Booking? upComingLesson = null;
  bool isSearching = false;
  bool isNoTutor = false;
  bool favoriteMode = false;

  // bool isInProgress = true;

  void getTutorList(int page, int perPage) async {
    var resTutorList = await TutorService.getTutorList(
      page,
      perPage,
    );
    var resFavoriteList = await TutorService.getFavoriteTutorList(
      page,
      perPage,
    );
    List<Tutor>? list1 = resTutorList;
    List<Tutor>? list2 = resFavoriteList;

    if (!isLoading) {
      setState(() {
        originalTutorList.addAll(list1!);
        favoriteList.addAll(list2!);
        tutorList = List.of(originalTutorList);
        currentPage++;
        // isInProgress = false;
      });
      isLoading = true;
    }
  }

  Future<void> getTotalLessonTime() async {
    int time = await CallService.getTotalTimeLesson();
    setState(() {
      totalLessonTime = time;
    });
  }

  Future<void> getBookingList() async {
    int timeStampNow = DateTime.now().millisecondsSinceEpoch;
    print(timeStampNow);
    List<Booking>? temp = await ClassService.getBookingList(timeStampNow);
    setState(() {
      bookingList = List.of(temp!);
      upComingLesson = TimeUtil.getNearestObject(temp!, timeStampNow);
    });
  }

  void loadMoreTutorList() async {
    setState(() {
      // isInProgress = true;
    });
    var resTutorList = await TutorService.getTutorList(
      currentPage,
      perPage,
    );
    List<Tutor>? list1 = resTutorList;
    setState(() {
      if (list1!.isEmpty)
        isNoTutor = true;
      else
        isNoTutor = false;
      currentPage++;
      originalTutorList.addAll(list1!);
      tutorList = List.of(originalTutorList);
      // isInProgress = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTotalLessonTime();
    getTutorList(page, perPage);
    getBookingList();
    _scrollController.addListener(() {
      if (_scrollController.offset ==
          _scrollController.position.maxScrollExtent) {
        print(isSearching);
        if (!isSearching && !favoriteMode)
          loadMoreTutorList();
        else if (isSearching && !favoriteMode) loadMoreTutorSearchList();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> search(_filters, searchString, page, perPage) async {
    print(isSearching);
    setState(() {
      searchCurrentPage = 1;
      favoriteMode = false;
    });
    List<Tutor>? temp =
        await SearchService.search(_filters, searchString, page, perPage);
    setState(() {
      tutorList = List.of(temp!);
      if (tutorList.isEmpty || temp!.length == 1)
        isNoTutor = true;
      else
        isNoTutor = false;
      if (searchString.toString().isEmpty && _filters.isEmpty)
        isSearching = false;
      else
        isSearching = true;
    });
  }

  void loadMoreTutorSearchList() async {
    setState(() {
      searchCurrentPage++;
    });
    List<Tutor>? temp = await SearchService.search(
        _filters, searchString, searchCurrentPage, searchPerPage);
    print("load more search: l " + temp!.length.toString());
    setState(() {
      if (temp!.isEmpty)
        isNoTutor = true;
      else
        isNoTutor = false;
      tutorList.addAll(temp!);
      if (searchString.toString().isEmpty && _filters.isEmpty)
        isSearching = false;
      else
        isSearching = true;
      // isInProgress = false;
    });
  }

  bool checkFavorite(Tutor tutor, List<Tutor> favoriteList) {
    if (favoriteList.any((element) => element.userId == tutor.userId)) {
      return true;
    } else
      return false;
  }

  @override
  Widget build(BuildContext context) {
    print(tutorList.length);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home".tr(),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      // body: ListView(
      //   children: [
      //
      //     Container(
      //       height: 500,
      //       padding: EdgeInsets.only(left: 20, right: 20),
      //       // child: Column(
      //       //   children:
      //       //       // SearchComponent()
      //       //       _getListData(),
      //       // ),
      //       child: ,
      //     )
      //   ],
      // ),
      body: ListView.builder(
          controller: _scrollController,
          itemCount: tutorList.length + 2,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Column(
                children: [
                  Container(
                    width: double.maxFinite,
                    child: upComingLesson != null
                        ? BannerComponent(
                            totalLessonTime: totalLessonTime,
                            upComingLession: upComingLesson!)
                        : Container(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            height: 150,
                            color: myPurple,
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "You have no upcoming lesson",
                                    style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    ' Welcome to LetTutor!',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ])),
                  ),
                  Container(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: OutlineSearchBar(
                        hintText: "Search".tr(),
                        debounceDelay: 1000,
                        onTypingFinished: (text) {
                          print(text);
                          setState(() {
                            searchString = text;
                          });
                          search(_filters, text ?? "", searchCurrentPage,
                              searchPerPage);
                        },
                        onClearButtonPressed: (text) {
                          setState(() {
                            searchString = "";
                          });
                          search(
                              _filters, "", searchCurrentPage, searchPerPage);
                        },
                        borderRadius:
                            BorderRadius.all(const Radius.circular(10.0)),
                      )),
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 5),
                    child: Wrap(
                      spacing: 3,
                      runSpacing: -10,
                      children: specialties.map(
                        (specialty) {
                          return FilterChip(
                            // selectedColor: Colors.amberAccent,
                            selectedShadowColor: Colors.cyanAccent,
                            label: Text(
                              specialty.replaceAll("-", " "),
                              style: TextStyle(fontSize: 10),
                            ),
                            selected: _filters.contains(specialty),
                            onSelected: (bool value) async {
                              setState(() {
                                if (value) {
                                  if (!_filters.contains(specialty)) {
                                    _filters.add(specialty);
                                  }
                                } else {
                                  _filters.removeWhere((String name) {
                                    return name == specialty;
                                  });
                                }
                                search(
                                    _filters, searchString, 1, searchPerPage);
                                setState(() {
                                  isNoTutor = true;
                                });
                                // tutorList = originalTutorList.where((tutor) {
                                //   return _filters.every((filter) =>
                                //       tutor.specialties?.contains(filter) ?? false);
                                // }).toList();
                                // print(tutorList);
                              });
                            },
                          );
                        },
                      ).toList(),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      margin: EdgeInsets.only(top: 16, bottom: 8),
                      alignment: Alignment.topLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Tutors".tr(),
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 23,
                            ),
                          ),
                          DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                            value: dropdownValue,
                            icon: Icon(Icons.filter_list),
                            onChanged: (String? newValue) async {
                              setState(() {
                                dropdownValue = newValue!;
                              });
                              print(newValue);
                              if (newValue == "Rating") {
                                setState(() {
                                  favoriteMode = false;
                                  List<Tutor> temp = List.of(tutorList);
                                  temp.sort((a, b) =>
                                      (b.rating ?? 0).compareTo(a.rating ?? 0));
                                  tutorList = temp;
                                });
                              } else if (newValue == "None") {
                                setState(() {
                                  favoriteMode = false;
                                  tutorList = List.of(originalTutorList);
                                  isSearching = false;
                                });
                              } else {
                                favoriteMode = true;
                                List<Tutor>? temp =
                                    await TutorService.getFavoriteTutorList(
                                        1, 10);

                                // tutorList = temp
                                //     .where((tutor) => favoriteList.any(
                                //         (element) => element.userId == tutor.userId))
                                //     .toList();
                                setState(() {
                                  tutorList = temp!;
                                  isSearching = true;
                                });
                              }
                            },
                            items: <String>['None', 'Rating', 'Favorite']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ))
                        ],
                      )),
                ],
              );
            } else if (index <= tutorList.length)
              return Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: TutorInfoCard(
                  tutor: tutorList[index - 1],
                  isFavorite: checkFavorite(tutorList[index - 1], favoriteList),
                  key: ValueKey(tutorList[index - 1].userId),
                ),
              );
            else
              return Padding(
                  padding: EdgeInsets.symmetric(vertical: 32),
                  child: !isNoTutor && !favoriteMode
                      ? Center(child: CircularProgressIndicator())
                      : Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset('images/empty-box.png',
                                  width: 70, height: 70),
                              SizedBox(height: 5.0),
                              Text(
                                'No tutor',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ));
          }),
    );
  }
}
