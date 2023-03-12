import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../HomePage/components/SkillTag.dart';

class SessionItem extends StatelessWidget {
  const SessionItem(
      {super.key,
      required this.sessionNumber,
      required this.sessionTime,
      required this.isBook});

  final String sessionNumber;
  final String sessionTime;
  final bool isBook;

  @override
  Widget build(BuildContext context) {
    return (Container(
        padding: EdgeInsets.only(top: 10),
        child: Row(
          children: [
            Text("Session " + sessionNumber + " " + sessionTime, style: TextStyle(fontSize: 16),),
            Spacer(),
            isBook
                ? OutlinedButton.icon(
                    onPressed: () {},
                    label: Text("Cancel"),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                    ),
                    icon: Icon(Icons.cancel_outlined),
                  )
                : Container(),
          ],
        )));
  }
}
