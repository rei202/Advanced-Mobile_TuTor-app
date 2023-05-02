import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  List<FavoriteTutor> favoriteList = [];
  int? _selectedChipIndex = 0;
  final ScrollController _scrollController = ScrollController();

  final List<String> _filters = <String>[];
  String searchString = "";
  int page = 1;
  int perPage = 10;
  int currentPage = 1;
  bool isLoading = false;
  String dropdownValue = 'None';
  int totalLessonTime = 0;
  List<Booking> bookingList = [];
  Booking? upComingLesson = null;
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
    List<FavoriteTutor>? list2 = resFavoriteList;

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
      upComingLesson = TimeUtil.getNearestObject(temp!, timeStampNow)!;
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
        loadMoreTutorList();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  void _updateText() {
    setState(() {
      // Update the text.
      textToShow = 'Flutter is Awesome!';
    });
  }

  Future<void> search(_filters, searchString, page, perPage) async {
    List<Tutor>? temp =
        await SearchService.search(_filters, searchString, page, perPage);
    setState(() {
      tutorList = List.of(temp!);
    });
  }

  @override
  Widget build(BuildContext context) {
    print(tutorList.length);
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: ListView(
        children: [
          upComingLesson != null
              ? BannerComponent(
                  totalLessonTime: totalLessonTime,
                  upComingLession: upComingLesson!)
              : Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  height: 150,
                  color: Colors.blueAccent,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
          Container(
              padding: EdgeInsets.only(left: 20, right: 20, top: 20),
              child: OutlineSearchBar(
                hintText: "Search course",
                debounceDelay: 1000,
                onTypingFinished: (text) {
                  print(text);
                  search(_filters, text ?? "", page, perPage);
                },
                onClearButtonPressed: (text) {
                  search(_filters, "", page, perPage);
                },
                borderRadius: BorderRadius.all(const Radius.circular(10.0)),
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
                        search(_filters, searchString, page, perPage);
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
                    "Tutors",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                      color: Colors.black,
                    ),
                  ),
                  DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                    value: dropdownValue,
                    icon: Icon(Icons.filter_list),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                        print(newValue);
                        if (newValue == "Rating") {
                          List<Tutor> temp = List.of(tutorList);
                          temp.sort((a, b) =>
                              (b.rating ?? 0).compareTo(a.rating ?? 0));
                          tutorList = temp;
                        } else if (newValue == "None") {
                          tutorList = List.of(originalTutorList);
                        } else {
                          List<Tutor> temp = List.of(tutorList);
                          temp.sort((a, b) {
                            bool aIsFavorite = favoriteList
                                .any((element) => element.userId == a.userId);
                            bool bIsFavorite = favoriteList
                                .any((element) => element.userId == b.userId);
                            if (aIsFavorite && !bIsFavorite) {
                              return -1;
                            } else if (!aIsFavorite && bIsFavorite) {
                              return 1;
                            } else {
                              return a.name!.compareTo(b.name!);
                            }
                          });
                          tutorList = temp;
                        }
                      });
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
          Container(
            height: 500,
            padding: EdgeInsets.only(left: 20, right: 20),
            // child: Column(
            //   children:
            //       // SearchComponent()
            //       _getListData(),
            // ),
            child: ListView.builder(
                controller: _scrollController,
                itemCount: tutorList.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index < tutorList.length)
                    return TutorInfoCard(
                      tutor: tutorList[index],
                      favoriteList: favoriteList,
                    );
                  else
                    return Padding(
                        padding: EdgeInsets.symmetric(vertical: 32),
                        child: Center(child: CircularProgressIndicator()));

                }),
          )
        ],
      ),
    );
  }
}
