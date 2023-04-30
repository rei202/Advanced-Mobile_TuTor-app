import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lettutor/screens/Course/Course.dart';
import 'package:lettutor/screens/CourseDetail/CourseDetail.dart';
import 'package:lettutor/screens/ForgotPassword.dart';
import 'package:lettutor/screens/History/History.dart';
import 'package:lettutor/screens/HomePage/HomePage.dart';
import 'package:lettutor/screens/LessonDetail/LessonDetail.dart';
import 'package:lettutor/screens/LoginPage.dart';
import 'package:lettutor/screens/MainScreen.dart';
import 'package:lettutor/screens/SignupPage.dart';
import 'package:lettutor/screens/StudyingSchedule/StudyingSchedule.dart';
import 'package:lettutor/screens/TutorProfile/TutorProfile.dart';

Future<void> main() async {
  await GetStorage.init();
  runApp(const MyHomePage());
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int navIndex = 0;

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        home: LoginPage());
  }
}
