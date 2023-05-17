import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lettutor/constrants/colors/MyPurple.dart';
import 'package:lettutor/services/classService.dart';
import 'package:path/path.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../HomePage/components/SkillTag.dart';

class SessionItem extends StatefulWidget {
  const SessionItem(
      {super.key,
      required this.sessionNumber,
      required this.sessionTime,
      required this.isBook,
      required this.context,
      required this.scheduleDetailId,
      required this.callback});

  final String sessionNumber;
  final String sessionTime;
  final bool isBook;
  final BuildContext context;
  final String scheduleDetailId;
  final Function callback;

  @override
  State<StatefulWidget> createState() => _SessionItemState();
}

class _SessionItemState extends State<SessionItem> {
  final TextEditingController noteTextController = TextEditingController();
  List<String> dropdownValues = [
    "Reschedule at another time",
    "Busy at that time",
    "Asked by the tutor",
    "Other"
  ];
  String? selectedValue = "Reschedule at another time";
  bool isReloadApi = false;

  int checkSelectedValue(String selectedValue) {
    switch (selectedValue) {
      case "Reschedule at another time":
        return 1;
      case "Busy at that time":
        return 2;
      case "Asked by the tutor":
        return 3;
      case "Other":
        return 4;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return (Container(
        padding: EdgeInsets.only(top: 10),
        child: Row(
          children: [
            Text(
              "Session " + widget.sessionNumber + " " + widget.sessionTime,
              style: TextStyle(fontSize: 16),
            ),
            Spacer(),
            widget.isBook
                ? OutlinedButton.icon(
                    // onPressed: () {
                    //   callback(1, 10);
                    // },
                    onPressed: () async {
                      showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => StatefulBuilder(
                              builder: (BuildContext context,
                                      StateSetter setState) =>
                                  AlertDialog(
                                    backgroundColor: Colors.white,
                                    title: const Text('Cancel booking'),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Container(
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          child: DropdownButton<String>(
                                            underline: Container(),
                                            value: selectedValue,
                                            onChanged: (newValue) {
                                              setState(() {
                                                selectedValue = newValue;
                                              });
                                            },
                                            items: dropdownValues.map((value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(value),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                        SizedBox(height: 16.0),
                                        TextFormField(
                                          controller: noteTextController,
                                          maxLines: 3,
                                          decoration: InputDecoration(
                                            hintText: 'Report description',
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                      ],
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          noteTextController.clear();
                                          Navigator.pop(context, 'Cancel');
                                        },
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  myPurple),
                                          foregroundColor: MaterialStateProperty
                                              .all<Color>(Colors
                                                  .white), // Màu chữ của nút
                                          // Các thuộc tính khác của nút (ví dụ: background color, padding, border, etc.)
                                        ),
                                        onPressed: () async {
                                          var response = await ClassService
                                              .cancelBookingClass(
                                              widget.scheduleDetailId,
                                                  checkSelectedValue(
                                                      selectedValue!),
                                                  noteTextController.text);

                                          if (response["isSuccess"]) {
                                            await widget.callback(1, 10);
                                            showTopSnackBar(
                                                Overlay.of(context),
                                                CustomSnackBar.success(
                                                  message:
                                                      "Cancel booking successfully",
                                                  maxLines: 2,
                                                ),
                                                displayDuration: const Duration(
                                                    milliseconds: 500),
                                                animationDuration:
                                                    const Duration(
                                                        milliseconds: 1000));
                                          }
                                          Navigator.pop(context, 'OK');
                                        },
                                        child: const Text('Submit'),
                                      ),
                                    ],
                                  )));

                      ;
                    },
                    label: Text("Cancel"),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                    ),
                    icon: Icon(Icons.cancel_outlined),
                  )
                : Container(),
          ],
        )));
  }
}
