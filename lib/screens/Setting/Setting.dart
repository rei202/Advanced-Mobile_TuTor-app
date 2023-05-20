import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/models/UserInfo.dart';
import 'package:lettutor/screens/BecomeTeacher/BecomeTeacher.dart';
import 'package:lettutor/screens/ChatGPT/ChatGPT.dart';
import 'package:lettutor/screens/Setting/AdvancedSetting.dart';
import 'package:lettutor/screens/Setting/Profile.dart';
import 'package:lettutor/services/profileService.dart';

import '../../constrants/colors/MyPurple.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  late Future<UserInfo?> userInfo;
  bool isLoading = false;

  Future<void> getUserInfo() async {
    if (!isLoading) {
      userInfo = ProfileService.getUserInfo();
      setState(() {
        isLoading = true;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Setting",
          style: TextStyle(fontWeight: FontWeight.bold),
        ).tr(),
      ),
      body: FutureBuilder<UserInfo?>(
          future: userInfo,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: Container(
                child: CircularProgressIndicator(),
                margin: EdgeInsets.only(bottom: 100),
              ));
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (!snapshot.hasData) {
              return Center(child: Text('No data'));
            }
            final user = snapshot.data!;
            return Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Profile(
                                    myInfo: user,
                                  ))).then(
                        (value) {
                          if (value) {
                            //refresh here
                            setState(() {
                              isLoading = false;
                            });
                            getUserInfo();
                          }
                        },
                      );
                    },
                    child: Card(
                        color: myLighterPurle,
                        child: Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              CircleAvatar(
                                radius: 35,
                                backgroundColor: Colors.brown.shade200,
                                backgroundImage: NetworkImage(user.avatar),
                              ),
                              Container(
                                  height: 70,
                                  margin: EdgeInsets.only(left: 22),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          user.name,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          user.email,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ])),
                              Spacer(),
                            ],
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                        )),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10, top: 40),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChatGPT()));
                        },
                        // style: ElevatedButton.styleFrom(
                        //   primary: myLighterPurle, // Set the background color of the button
                        // ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                margin: EdgeInsets.only(left: 5, right: 10),
                                child: Icon(
                                  Icons.messenger_outline,
                                  size: 22,
                                )),
                            Text("Chat with ChatGPT").tr(),
                            Spacer(),
                            Icon(Icons.keyboard_arrow_right)
                          ],
                        )),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BecomeTeacher()));
                        },
                        // style: ElevatedButton.styleFrom(
                        //   primary: myLighterPurle, // Set the background color of the button
                        // ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                margin: EdgeInsets.only(left: 5, right: 10),
                                child: Icon(
                                  Icons.face,
                                  size: 22,
                                )),
                            Text("Become a Teacher").tr(),
                            Spacer(),
                            Icon(Icons.keyboard_arrow_right)
                          ],
                        )),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AdvancedSetting()));
                        },
                        // style: ElevatedButton.styleFrom(
                        //   primary: myLighterPurle, // Set the background color of the button
                        // ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                margin: EdgeInsets.only(left: 5, right: 10),
                                child: Icon(
                                  Icons.settings,
                                  size: 22,
                                )),
                            Text("Advanced Settings").tr(),
                            Spacer(),
                            Icon(Icons.keyboard_arrow_right)
                          ],
                        )),
                  ),
                  Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.only(bottom: 10, top: 40),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(context, '/Signin', (route) => false);
                        },
                        style: ElevatedButton.styleFrom(
                          primary:
                              myPurple, // Set the background color of the button
                        ),
                        child: Text("Sign out", style: TextStyle(fontSize: 18, color: Colors.white),)),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
