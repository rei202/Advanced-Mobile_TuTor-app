import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lettutor/constrants/colors/MyPurple.dart';
import 'package:lettutor/models/UserInfo.dart';
import 'package:lettutor/services/profileService.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

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
  File? _selectedImage;

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

  Future<void> _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
      var res = await ProfileService.updateAvatar(File(pickedImage.path));
      print(res);
      if (res != null) {
        showTopSnackBar(
            Overlay.of(context),
            CustomSnackBar.success(
              message: "Update avatar successfully",
              maxLines: 2,
            ),
            displayDuration: const Duration(milliseconds: 500),
            animationDuration: const Duration(milliseconds: 1000));
      }
    }
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
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 45,
                            backgroundImage: _selectedImage != null
                                ? FileImage(_selectedImage!)
                                : NetworkImage(widget.myInfo.avatar)
                                    as ImageProvider<Object>?,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: CircleAvatar(
                              radius: 13,
                              backgroundColor: myPurple,
                              child: IconButton(
                                color: Colors.white,
                                icon: Icon(Icons.edit, size: 15),
                                onPressed: _pickImage,
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(widget.myInfo.name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )),
                      Text(widget.myInfo.email,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          )),
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
                        ),
                      ),
                      TextField(
                          controller: name,
                          style: TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                              filled: true,
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
                        ),
                      ),
                      TextField(
                          controller: phone,
                          style: TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                              filled: true,
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
                        ),
                      ),
                      TextField(
                          controller: dob,
                          style: TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                              filled: true,
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
                        ),
                      ),
                      DropdownButtonFormField(
                        decoration: InputDecoration(
                          filled: true,
                          hintText: widget.myInfo.country,
                          hintStyle: TextStyle(fontSize: 15),
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
                              style: TextStyle(fontSize: 15),
                            ),
                          );
                        }).toList(),
                      ),
                      Text(
                        "My Level".tr(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      DropdownButtonFormField(
                        decoration: InputDecoration(
                          filled: true,
                          hintText: widget.myInfo.level,
                          hintStyle: TextStyle(fontSize: 15),
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
                              style: TextStyle(fontSize: 15),
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
                              showTopSnackBar(
                                  Overlay.of(context),
                                  CustomSnackBar.success(
                                    message: "Update profile successfully",
                                    maxLines: 2,
                                  ),
                                  displayDuration:
                                      const Duration(milliseconds: 500),
                                  animationDuration:
                                      const Duration(milliseconds: 1000));
                            } else
                            showTopSnackBar(
                                Overlay.of(context),
                                CustomSnackBar.error(
                                  message:
                                  "Update user info failed",
                                  maxLines: 2,
                                ),
                                displayDuration: const Duration(
                                    milliseconds: 500));
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
