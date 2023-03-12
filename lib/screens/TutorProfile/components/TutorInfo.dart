import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../HomePage/components/SkillTag.dart';

class TutorInfo extends StatefulWidget {
  const TutorInfo({super.key});

  @override
  State<StatefulWidget> createState() => _TutorInfoState();
}

class _TutorInfoState extends State<TutorInfo> {
  // Default placeholder text.
  String name = 'Keegan';
  String toturNationality = "Viet Nam";
  String description =
      "I am passionate about running and fitness, I often compete in trail/mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also enjoy watching rugby on the weekends, reading and watching podcasts on Youtube. My most memorable life experience would be living in and traveling around Southeast Asia.";
  List<Widget> _listSkill = [];

  void _updateText() {
    setState(() {
      // Update the text.
      name = 'Flutter is Awesome!';
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i < 5; i++) {
      _listSkill.add(SkillTag(name: "name" + i.toString()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return (Container(
        padding: EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.brown.shade800,
                  child: const Text('AH'),
                ),
                Container(
                    height: 70,
                    margin: EdgeInsets.only(left: 22),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          name,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          toturNationality,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        RatingBar.builder(
                          itemSize: 15,
                          initialRating: 0,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        )
                      ],
                    )),
                Spacer(),
                FavoriteButton(
                  valueChanged: () {},
                )
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
          ),
          Row(children: [Text("")]),
          Container(
            margin: EdgeInsets.only(bottom: 15),
            width: double.infinity,
            constraints: BoxConstraints(),
            child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: BorderSide(width: 1, color: Colors.black),
                  ),
                ),
                child: Text(
                  "Book",
                  style: TextStyle(color: Colors.white),
                )),
          ),
          Text(
            description,
            style:
                TextStyle(fontSize: 14, color: Color(0xff686868), height: 1.3),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 15, top: 15),
            child: Text(
              "Languages",
              style: TextStyle(fontSize: 17, color: Colors.black),
            ),
          ),
          Container(
              margin: EdgeInsets.only(bottom: 15),
              padding: EdgeInsets.only(left: 10, right: 10),
              height: 40,
              child: ListView(
                children: _listSkill,
                scrollDirection: Axis.horizontal,
              )),
          Container(
            margin: EdgeInsets.only(bottom: 15),
            child: Text(
              "Speciaties",
              style: TextStyle(fontSize: 17, color: Colors.black),
            ),
          ),
          Container(
              margin: EdgeInsets.only(bottom: 15),
              padding: EdgeInsets.only(left: 10, right: 10),
              height: 40,
              child: ListView(
                children: _listSkill,
                scrollDirection: Axis.horizontal,
              )),
          Container(
            margin: EdgeInsets.only(bottom: 15),
            child: Text(
              "Interests",
              style: TextStyle(fontSize: 17, color: Colors.black),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 15, left: 10),
            child: Text(
              description,
              style: TextStyle(
                  fontSize: 14, color: Color(0xff686868), height: 1.3),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 15,),
            child: Text(
              "Teaching Experience",
              style: TextStyle(fontSize: 17, color: Colors.black),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 15, left: 10),
            child: Text(
              description,
              style: TextStyle(
                  fontSize: 14, color: Color(0xff686868), height: 1.3),
            ),
          )
        ])));
  }
}
