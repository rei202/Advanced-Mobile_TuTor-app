import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class SearchComponent extends StatefulWidget {
  const SearchComponent({super.key});

  @override
  State<StatefulWidget> createState() => _SearchComponentState();
}

class _SearchComponentState extends State<SearchComponent> {
  // Default placeholder text.
  String schedule = 'Sat, 11 Mar 23 14:00 - 14:25';
  String totalTime = 'Total lesson time is 300 hours 25 minutes';

  void _updateText() {
    setState(() {
      // Update the text.
      schedule = 'Flutter is Awesome!';
    });
  }

  @override
  Widget build(BuildContext context) {
    return (Container(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Row(
            children: [
              Container(
                width: 150,
                height: 35,
                margin: EdgeInsets.only(right: 15),
                child: TextField(
                  style: TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 15),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                    hintText: 'Enter tutor name',
                  ),
                ),
              ),
              Container(
                width: 150,
                height: 35,
                child: TextField(
                  style: TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 15),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                    hintText: 'Enter tutor nationality',
                  ),
                ),
              )
            ],
          ),
          //  Container(
          //    alignment: Alignment.topLeft,
          //    width: 300,
          //    height: 300,
          //    child: SfDateRangePicker(
          //   toggleDaySelection: true,
          //   selectionMode: DateRangePickerSelectionMode.range,
          //   showTodayButton: true,
          //   initialSelectedRange: PickerDateRange(
          //       DateTime.now().subtract(const Duration(days: 4)),
          //       DateTime.now().add(const Duration(days: 3))),
          // ),)
        ])));
  }
}
