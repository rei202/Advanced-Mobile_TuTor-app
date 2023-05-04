import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lettutor/models/UserInfo.dart';
import 'package:lettutor/services/profileService.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key, required this.myInfo}) : super(key: key);
  final UserInfo myInfo;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController level = TextEditingController();

  bool checkInput() {
    if ((name.text.isNotEmpty ||
            phone.text.isNotEmpty ||
            dob.text.isNotEmpty ||
            country.text.isNotEmpty) &&
        level.text.isNotEmpty)
      return true;
    else
      return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Profile",
            style: TextStyle(fontWeight: FontWeight.bold),
          ).tr(),
        ),
        body: ListView(children: [
          Container(
            padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: Container(
                  height: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CircleAvatar(
                        radius: 45,
                        backgroundImage: NetworkImage(widget.myInfo.avatar),
                      ),
                      Text(widget.myInfo.name,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      Text(widget.myInfo.email,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                    ],
                  ),
                )),
                Container(
                  height: 500,
                  margin: EdgeInsets.only(bottom: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Name".tr(),
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                      TextField(
                          controller: name,
                          style:
                              TextStyle(fontSize: 15, color: Colors.grey[700]),
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey.shade100,
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              hintText: widget.myInfo.name.toString())),
                      Text(
                        "Phone number".tr(),
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                      TextField(
                          controller: phone,
                          style:
                              TextStyle(fontSize: 15, color: Colors.grey[700]),
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey.shade100,
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              hintText: "+" + widget.myInfo.phone.toString())),
                      Text(
                        "Birthday".tr(),
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                      TextField(
                          controller: dob,
                          style:
                              TextStyle(fontSize: 15, color: Colors.grey[700]),
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey.shade100,
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              hintText: widget.myInfo.birthday)),
                      Text(
                        "Country".tr(),
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                      DropdownButtonFormField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          hintText: widget.myInfo.country,
                          hintStyle:
                              TextStyle(fontSize: 15, color: Colors.grey[700]),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
                        onChanged: (value) {
                          setState(() {
                            country.text = value ?? "Vietnam";
                          });
                        },
                        items: <String>[
                          'Vietnam',
                          'Albania',
                          'America',
                          'Andorra'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                  fontSize: 15, color: Colors.grey[700]),
                            ),
                          );
                        }).toList(),
                      ),
                      Text(
                        "My Level".tr(),
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                      DropdownButtonFormField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          hintText: widget.myInfo.level,
                          hintStyle:
                              TextStyle(fontSize: 15, color: Colors.grey[700]),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
                        onChanged: (value) {
                          setState(() {
                            level.text = value ?? "Beginner";
                          });
                        },
                        items: <String>[
                          'BEGINNER',
                          'HIGHER_BEGINNER',
                          'PRE_INTERMEDIATE',
                          'INTERMEDIATE',
                          'UPPER_INTERMEDIATE',
                          'ADVANCED',
                          'PROFICIENCY'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value.replaceAll('_', " "),
                              style: TextStyle(
                                  fontSize: 15, color: Colors.grey[700]),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    style: ElevatedButton.styleFrom(),
                    onPressed: checkInput()
                        ? () async {
                            UserInfo? user =
                                await ProfileService.updateUserInfo(
                                    name.text,
                                    phone.text,
                                    dob.text,
                                    country.text,
                                    level.text);
                            if (user != null) {
                              Fluttertoast.showToast(
                                  msg: "Successful",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            } else
                              Fluttertoast.showToast(
                                  msg: "Update user info failed",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            Future.delayed(Duration(seconds: 1), () {
                              Navigator.pop(context, true);
                            });
                          }
                        : null,
                    child: const Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(
                        "Save",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ]));
  }
}
