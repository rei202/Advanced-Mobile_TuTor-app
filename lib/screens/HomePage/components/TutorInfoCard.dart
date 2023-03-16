import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lettutor/screens/TutorProfile/TutorProfile.dart';

class TutorInfoCard extends StatefulWidget {
  const TutorInfoCard({super.key});

  @override
  State<StatefulWidget> createState() => _TutorInfoCardState();
}

class _TutorInfoCardState extends State<TutorInfoCard> {
  // Default placeholder text.
  String name = 'Keegan';
  String toturNationality = "Viet Nam";
  String description =
      "I am passionate about running and fitness, I often compete in trail/mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also enjoy watching rugby on the weekends, reading and watching podcasts on Youtube. My most memorable life experience would be living in and traveling around Southeast Asia.";

  void _updateText() {
    setState(() {
      // Update the text.
      name = 'Flutter is Awesome!';
    });
  }

  @override
  Widget build(BuildContext context) {
    return (GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => TutorProfile()));
      },
        child: Card(
            margin: EdgeInsets.only(bottom: 20),
            elevation: 2,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                                      itemPadding:
                                          EdgeInsets.symmetric(horizontal: 0.0),
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
                      Text(
                        description.length > 270
                            ? description.substring(0, 270) + '...'
                            : description,
                        style: TextStyle(fontSize: 14, color: Colors.black45),
                      ),
                      FilledButton(
                          onPressed: () {},

                          child: Text(
                            "Book",
                          ))
                    ])))));
  }
}
