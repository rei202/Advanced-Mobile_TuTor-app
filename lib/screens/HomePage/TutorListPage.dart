import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'components/BannerComponent.dart';
import 'components/TutorInfoCard.dart';

class TutorListPage extends StatefulWidget {
  const TutorListPage({super.key});

  @override
  State<StatefulWidget> createState() => _TutorListPageState();
}

class _TutorListPageState extends State<TutorListPage> {
  // Default placeholder text.
  String textToShow = 'I Like Flutter';

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
          alignment: Alignment.topLeft,
          child: Text(
            "Recommended Tutors",
            textAlign: TextAlign.start,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.black,
            ),
          )),
    );
    for (int i = 0; i < 10; i++) {
      widgets.add(TutorInfoCard());
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          BannerComponent(),
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
    );
  }
}
