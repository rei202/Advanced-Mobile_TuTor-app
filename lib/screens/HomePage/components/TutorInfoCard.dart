import 'dart:ffi';

import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lettutor/constrants/colors/MyPurple.dart';
import 'package:lettutor/models/FavoriteTutor.dart';
import 'package:lettutor/screens/TutorProfile/TutorProfile.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../models/Tutor.dart';
import '../../../services/tutorService.dart';

class TutorInfoCard extends StatefulWidget {
  const TutorInfoCard(
      {super.key, required this.tutor, required this.isFavorite});

  final Tutor tutor;
  final bool isFavorite;

  @override
  State<StatefulWidget> createState() => _TutorInfoCardState();
}

class _TutorInfoCardState extends State<TutorInfoCard> {
  // Default placeholder text.
  String description =
      "I am passionate about running and fitness, I often compete in trail/mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also enjoy watching rugby on the weekends, reading and watching podcasts on Youtube. My most memorable life experience would be living in and traveling around Southeast Asia.";
  late bool isFavorite;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isFavorite = widget.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    String toturNationality = widget.tutor.country ?? "Unknown";
    description = widget.tutor.bio.toString();
    String image = widget.tutor.avatar ??
        "https://icon-library.com/images/default-profile-icon/default-profile-icon-16.jpg";
    return (GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => TutorProfile(tutorId: widget.tutor.userId, feedbacks: widget.tutor.feedbacks)));
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
                              backgroundColor: Colors.brown.shade200,
                              backgroundImage: NetworkImage(image),
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
                                      widget.tutor.name.toString(),
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
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
                                      ignoreGestures: true,
                                      itemSize: 15,
                                      initialRating: widget.tutor.rating ?? 0.0,
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
                            IconButton(
                              icon: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: isFavorite ? Colors.red : Colors.black38,
                              ),
                              onPressed: () async {
                                var response = await TutorService.addTutortoFavorite(
                                    widget.tutor.userId!);
                                if (response) {

                                  showTopSnackBar(
                                      Overlay.of(context),
                                      CustomSnackBar.success(
                                        message: "Tutor was added in favorite list",
                                        maxLines: 2,
                                      ),
                                      displayDuration:
                                      const Duration(milliseconds: 500),
                                      animationDuration:
                                      const Duration(milliseconds: 1000)
                                  );
                                }
                                else{
                                  showTopSnackBar(
                                      Overlay.of(context),
                                      CustomSnackBar.success(
                                        message: "Tutor was removed in favorite list",
                                        maxLines: 2,
                                      ),
                                      displayDuration:
                                      const Duration(milliseconds: 500),
                                      animationDuration:
                                      const Duration(milliseconds: 1000));
                                }
                                setState(() {
                                  isFavorite = !isFavorite;
                                });
                              },
                            ),
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                      ),
                      Row(children: [Text("")]),
                      Container(
                        height: 40,
                          child: ListView(
                        scrollDirection: Axis.horizontal,
                        // căn chỉnh các widget con bên trái
                        children: widget.tutor.specialties
                                ?.split(",")
                                .map((specialties) {
                              return Padding(
                                  padding: EdgeInsets.only(right: 5),
                                  child: Chip(
                                    // selectedColor: Colors.amberAccent,
                                    label: Text(
                                      specialties.toString().replaceAll("-", " "),
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ));
                            }).toList() ??
                            [],
                      )),
                      Text(
                        description.length > 270
                            ? description.substring(0, 270) + '...'
                            : description,
                        style: TextStyle(fontSize: 14, color: Colors.black45),
                      ),
                      // FilledButton(
                      //     onPressed: () {},
                      //
                      //     child: Text(
                      //       "Book",
                      //     ))
                    ])))));
  }
}
