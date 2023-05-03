import 'dart:async';

import 'package:flutter/material.dart';

class CountdownOverlay extends StatefulWidget {
  final int duration;
  final VoidCallback onFinish;

  CountdownOverlay({required this.duration, required this.onFinish});

  @override
  _CountdownOverlayState createState() => _CountdownOverlayState();
}

class _CountdownOverlayState extends State<CountdownOverlay> {
  late Timer _timer;
  int _countdown = 0;

  @override
  void initState() {
    super.initState();
    _countdown = widget.duration;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _countdown--;
        if (_countdown <= 0) {
          _timer.cancel();
          widget.onFinish();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.6),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            '$_countdown',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
