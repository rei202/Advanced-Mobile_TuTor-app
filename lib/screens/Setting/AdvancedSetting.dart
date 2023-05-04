import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lettutor/models/UserInfo.dart';
import 'package:lettutor/services/profileService.dart';

class AdvancedSetting extends StatefulWidget {
  const AdvancedSetting({Key? key}) : super(key: key);

  @override
  State<AdvancedSetting> createState() => _AdvancedSettingState();
}

class _AdvancedSettingState extends State<AdvancedSetting> {
  String selectedLanguage = 'English';
  List<String> languages = ['English', 'Tiếng Việt'];
  late String language ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Advanced Settings",
            style: TextStyle(fontWeight: FontWeight.bold),
          ).tr(),
        ),
        body: Column(
          children: [
            const Divider(),
            InkWell(
              child: Container(
                padding:
                    EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Languages'.tr(),
                      style: TextStyle(fontSize: 16),
                    ),
                    Icon(Icons.arrow_forward_ios_rounded)
                  ],
                ),
              ),
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return SizedBox(
                        height: 160,
                        child: Container(
                            padding: EdgeInsets.only(
                                left: 15, right: 15, top: 5, bottom: 5),
                            child: Column(children: [
                              Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Text(
                                    "Languages",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  )),
                              const Divider(),
                              InkWell(
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: 15, right: 15, top: 5, bottom: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Tiếng Việt",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      context.locale.toString() == "vi_VN"
                                          ? Icon(
                                              Icons.check_outlined,
                                              color: Colors.deepPurple,
                                            )
                                          : Container()
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    language = "vietnamese";
                                  });
                                  context.locale = Locale('vi', 'VN');
                                  Navigator.pop(context);
                                },
                              ),
                              const Divider(),
                              InkWell(
                                  onTap: () {
                                    setState(() {
                                      language = "english";
                                    });
                                    context.locale = Locale("en", 'US');
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: 15, right: 15, top: 5, bottom: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "English",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        context.locale.toString() != "vi_VN"
                                            ? Icon(
                                                Icons.check_outlined,
                                                color: Colors.deepPurple,
                                              )
                                            : Container()
                                      ],
                                    ),
                                  )),
                            ])),
                      );
                    });
              },
            ),
            const Divider(),

          ],
        ));
  }
}
