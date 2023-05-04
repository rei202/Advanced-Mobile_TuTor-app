import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/screens/Course/Course.dart';
import 'package:lettutor/screens/CourseDetail/CourseDetail.dart';
import 'package:lettutor/screens/History/History.dart';
import 'package:lettutor/screens/HomePage/HomePage.dart';
import 'package:lettutor/screens/LessonDetail/LessonDetail.dart';
import 'package:lettutor/screens/LoginPage.dart';
import 'package:lettutor/screens/Setting/Setting.dart';
import 'package:lettutor/screens/StudyingSchedule/StudyingSchedule.dart';
import 'package:lettutor/screens/TutorProfile/TutorProfile.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int navIndex = 0;

  @override
  Widget build(BuildContext context) {
    const pages = [
      const HomePage(),
      const Course(),
      const StudyingSchedule(),
      const History(),
      const Setting()
    ];
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return MaterialApp(
        routes: <String, WidgetBuilder>{
          '/home': (context) => const HomePage(),
          '/course': (context) => const Course(),
          '/schedule': (context) => const StudyingSchedule(),
          '/history': (context) => const History(),
          '/Setting': (context) => const Setting(),

        },
        theme: ThemeData(
          colorSchemeSeed: const Color(0xff6750a4), useMaterial3: true,
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          // primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: navIndex,
            // fixedColor: Colors.black,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.deepPurpleAccent,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: "Home".tr(),
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.book_outlined), label: "Course".tr()),
              BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_month), label: "Schedule".tr()),
              BottomNavigationBarItem(
                  icon: Icon(Icons.history_outlined), label: "History".tr()),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: "Setting".tr()),
            ],
            onTap: (index) {
              setState(() {
                navIndex = index;
              });
            },
          ),
          body: pages[navIndex],
        ));
  }
}
