import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CountdownTimerText extends StatefulWidget {
  final int timestamp;

  CountdownTimerText({required this.timestamp});

  @override
  _CountdownTimerTextState createState() => _CountdownTimerTextState();
}

class _CountdownTimerTextState extends State<CountdownTimerText> {
  late DateTime _endTime;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _endTime = DateTime.fromMillisecondsSinceEpoch(widget.timestamp).subtract(Duration(seconds: 1));
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.utc(0).add(DateTime.now().difference(_endTime));
    String formattedTime = DateFormat('HH:mm:ss').format(dateTime );
    return Text(
      '$formattedTime',
      style: TextStyle(fontSize: 24),
    );
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (DateTime.now().isAfter(_endTime)) {
          timer.cancel();
        }
      });
    });
  }
}
