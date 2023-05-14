import 'package:easy_localization/easy_localization.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lettutor/constrants/colors/MyPurple.dart';
import 'package:lettutor/models/Tutor.dart';
import 'package:lettutor/screens/TutorProfile/components/Review.dart';
import 'package:lettutor/services/tutorService.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../models/MyAppointment.dart';
import '../../HomePage/components/SkillTag.dart';
import 'BookingClass.dart';

class TutorInfo extends StatefulWidget {
  const TutorInfo(
      {super.key,
      required this.tutor,
      required this.meetings,
      required this.isLoadMeetings});

  final Tutor tutor;
  final List<MyAppointment> meetings;
  final bool isLoadMeetings;

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
  bool isFavorite = false;
  bool checkbox1 = false;
  bool checkbox2 = false;
  bool checkbox3 = false;
  TextEditingController _reportTextController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name = widget.tutor.name!;
    toturNationality = widget.tutor.country!;
    description = widget.tutor.bio!;
    isFavorite = widget.tutor.isFavorite!;
    print(widget.tutor.rating);
    _listSkill.add(Container(
        padding: EdgeInsets.only(left: 5),
        child: Chip(
          label: Text(
            "English",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color(0x8c6851a5),
        )));
    _listSkill.add(Container(
        padding: EdgeInsets.only(left: 5),
        child: Chip(
          label: Text(
            "Japanese",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color(0x8c6851a5),
        )));
    _listSkill.add(Container(
        padding: EdgeInsets.only(left: 5),
        child: Chip(
          label: Text(
            "Vietnamese",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color(0x8c6851a5),
        )));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _reportTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String image = widget.tutor.avatar ??
        "https://icon-library.com/images/default-profile-icon/default-profile-icon-16.jpg";
    return (Container(
        padding: EdgeInsets.only(top: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.brown.shade800,
                  backgroundImage: NetworkImage(image),
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
                          initialRating: widget.tutor.rating ?? 0,
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
                IconButton(
                  iconSize: 32,
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
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
            ),
          ),
          Row(children: [Text("")]),
          widget.isLoadMeetings
              ? Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: 5),
                  constraints: BoxConstraints(),
                  child: FilledButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BookingClass(
                                      meetings: widget.meetings,
                                    )));
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: BorderSide(width: 1, color: Colors.black),
                        ),
                      ),
                      child: Text(
                        "Book".tr(),
                        style: TextStyle(color: Colors.white),
                      )))
              : Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                  Container(
                    width: 30,
                    height: 30,
                    margin: EdgeInsets.all(10),
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                    ),
                  )
                ]),
          Container(
              padding: EdgeInsets.only(bottom: 10),
              width: double.infinity,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(children: [
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Review(tutorId: widget.tutor.userId,)));
                          },
                          iconSize: 30,
                          color: Colors.deepPurple,
                          icon: Icon(
                            Icons.star_border_outlined,
                          )),
                      Text(
                        "Review".tr(),
                        style: TextStyle(fontSize: 12),
                      )
                    ]),
                    Column(
                      children: [
                        IconButton(
                          iconSize: 30,
                          onPressed: () => showDialog<String>(
                              context: context,
                              builder: (BuildContext context) =>
                                  StatefulBuilder(
                                      builder: (BuildContext context,
                                              StateSetter setState) =>
                                          AlertDialog(
                                            title:  const Text('Report tutor'),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                CheckboxListTile(
                                                  title: const Text(
                                                      'This tutor is annoying me'),
                                                  value: checkbox1,
                                                  onChanged: (bool? value) {
                                                    setState(() {
                                                      checkbox1 = value!;
                                                      _reportTextController
                                                              .text =
                                                          _reportTextController
                                                                  .text +
                                                              "This tutor is annoying me.\n";
                                                    });
                                                  },
                                                ),
                                                CheckboxListTile(
                                                  title: const Text(
                                                      'This profile is pretending be someone or is fake'),
                                                  value: checkbox2,
                                                  onChanged: (bool? value) {
                                                    setState(() {
                                                      checkbox2 = value!;
                                                      _reportTextController
                                                              .text =
                                                          _reportTextController
                                                                  .text +
                                                              "This profile is pretending be someone or is fake.\n";
                                                    });
                                                  },
                                                ),
                                                CheckboxListTile(
                                                  title: const Text(
                                                      'Inappropriate profile photo'),
                                                  value: checkbox3,
                                                  onChanged: (bool? value) {
                                                    setState(() {
                                                      checkbox3 = value!;
                                                      _reportTextController
                                                              .text =
                                                          _reportTextController
                                                                  .text +
                                                              "Inappropriate profile photo.\n";
                                                    });
                                                  },
                                                ),
                                                TextFormField(
                                                  controller:
                                                      _reportTextController,
                                                  maxLines: 3,
                                                  decoration: InputDecoration(
                                                    hintText:
                                                        'Report description',
                                                    border:
                                                        OutlineInputBorder(),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  _reportTextController.clear();
                                                  checkbox1 = checkbox2 =
                                                      checkbox3 = false;
                                                  Navigator.pop(
                                                      context, 'Cancel');
                                                },
                                                child: const Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () async {
                                                  var response = await TutorService
                                                      .reportTutor(
                                                          widget.tutor.userId,
                                                          _reportTextController
                                                              .text);
                                                  if (response) {
                                                    // print("report");
                                                    // ScaffoldMessenger.of(context).showSnackBar(
                                                    //   SnackBar(
                                                    //     content: const Text(
                                                    //       'Successful',
                                                    //       textAlign: TextAlign.center,
                                                    //       style: TextStyle(fontSize: 16),
                                                    //     ),
                                                    //     backgroundColor: Colors.green,
                                                    //   ),
                                                    // ).closed.then((value) {
                                                    //   Navigator.pop(context, 'OK');
                                                    // });
                                                    Fluttertoast.showToast(
                                                        msg: "Successful",
                                                        toastLength:
                                                            Toast.LENGTH_SHORT,
                                                        gravity:
                                                            ToastGravity.BOTTOM,
                                                        backgroundColor:
                                                            Colors.green,
                                                        textColor: Colors.white,
                                                        fontSize: 16.0);
                                                  }
                                                  Future.delayed(
                                                      Duration(seconds: 1), () {
                                                    Navigator.pop(
                                                        context, 'OK');
                                                  });
                                                },
                                                child: const Text('Submit'),
                                              ),
                                            ],
                                          ))),
                          color: Colors.deepPurple,
                          icon: Icon(
                            Icons.flag_outlined,
                          ),
                        ),
                        Text(
                          "Report".tr(),
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    )
                  ])),
          Text(
            description,
            style:
                TextStyle(fontSize: 14, color: Color(0xff686868), height: 1.3),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 15, top: 15),
            child: Text(
              "Languages".tr(),
              style: TextStyle(fontSize: 17, color: Colors.black),
            ),
          ),
          Container(
              margin: EdgeInsets.only(bottom: 15),
              padding: EdgeInsets.only(left: 10, right: 10),
              height: 40,
              child: ListView(
                children: widget.tutor.languages?.split(",").map((language) {
                      return Container(
                          padding: EdgeInsets.only(left: 5),
                          child: Chip(
                            label: Text(
                              language!,
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Color(0x8c6851a5),
                          ));
                    }).toList() ??
                    [],
                scrollDirection: Axis.horizontal,
              )),
          Container(
            margin: EdgeInsets.only(bottom: 15),
            child: Text(
              "Speciaties".tr(),
              style: TextStyle(fontSize: 17, color: Colors.black),
            ),
          ),
          Container(
              margin: EdgeInsets.only(bottom: 15),
              padding: EdgeInsets.only(left: 10, right: 10),
              height: 40,
              child: ListView(
                children:
                    widget.tutor.specialties?.split(",").map((specialties) {
                          return Container(
                              padding: EdgeInsets.only(left: 5),
                              child: Chip(
                                label: Text(
                                  specialties!.replaceAll("-", " "),
                                  style: TextStyle(color: Colors.white),
                                ),
                                backgroundColor: Color(0x8c6851a5),
                              ));
                        }).toList() ??
                        [],
                scrollDirection: Axis.horizontal,
              )),
          Container(
            margin: EdgeInsets.only(bottom: 15),
            child: Text(
              "Interests".tr(),
              style: TextStyle(fontSize: 17, color: Colors.black),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 15, left: 10),
            child: Text(
              widget.tutor.interests!,
              style: TextStyle(
                  fontSize: 14, color: Color(0xff686868), height: 1.3),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              bottom: 15,
            ),
            child: Text(
              "Teaching Experience".tr(),
              style: TextStyle(fontSize: 17, color: Colors.black),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 15, left: 10),
            child: Text(
              widget.tutor.experience!,
              style: TextStyle(
                  fontSize: 14, color: Color(0xff686868), height: 1.3),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              bottom: 5,
            ),
            child: Text(
              "Schedule".tr(),
              style: TextStyle(fontSize: 17, color: Colors.black),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green,
                ),
              ),
              SizedBox(width: 4),
              Text('Available', style: TextStyle(fontSize: 12)),
              SizedBox(width: 16),
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: myLightPurle,
                ),
              ),
              SizedBox(width: 4),
              Text('Booked', style: TextStyle(fontSize: 12)),
            ],
          )
        ])));
  }
}
