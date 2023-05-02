import 'package:flutter/cupertino.dart';

class ScheduleWidget extends StatelessWidget {
  final List<String> schedule;

  ScheduleWidget({required this.schedule});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Schedule',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: schedule.length,
            itemBuilder: (BuildContext context, int index) {
              return Text(schedule[index]);
            },
          ),
        ],
      ),
    );
  }
}