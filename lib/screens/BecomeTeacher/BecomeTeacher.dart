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

class BecomeTeacher extends StatefulWidget {
  const BecomeTeacher({Key? key}) : super(key: key);

  @override
  State<BecomeTeacher> createState() => _BecomeTeacherState();
}

class _BecomeTeacherState extends State<BecomeTeacher> {
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
      await ProfileService.updateAvatar(File(pickedImage.path));
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
                                : NetworkImage("https://th.bing.com/th/id/R.8af1f2eeba472f41b2100fe675c63900?rik=vgIszS0S8HCJEw&riu=http%3a%2f%2f1.bp.blogspot.com%2f-1uQRYMklACU%2fToQ6aL-5uUI%2fAAAAAAAAAgQ%2f9_u0922cL14%2fs1600%2fcute-puppy-dog-wallpapers.jpg&ehk=4Y4H%2bEJ9YYrV3jxDGuJ1mnBni7xGrGr8OgWVwSpOG7c%3d&risl=&pid=ImgRaw&r=0")
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
                      Text("widget.myInfo.name",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )),
                      Text("widget.myInfo.email",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          )),
                    ],
                  ),
                )),
                Container(
                  margin: EdgeInsets.only(bottom: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tutoring name".tr(),
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
                            )),
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
                              hintText:" widget.myInfo.birthday")),
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
                          hintText: "widget.myInfo.country",
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
                        "Interests".tr(),
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
                              )),
                      Text(
                        "Education".tr(),
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
                          )),
                      Text(
                        "Target student",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      DropdownButtonFormField(
                        decoration: InputDecoration(
                          filled: true,
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
                          'INTERMEDIATE',
                          'ADVANCED',
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
                      Text(
                        "Education".tr(),
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
                          )),
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
                ),
              ],
            ),
          )
        ]));
  }
}
