
import 'package:lettutor/models/TutorInfo.dart';

import 'ScheduleDetail.dart';
import 'Tutor.dart';

class ScheduleItem {
  final String id;
  final int startTime;
  final int endTime;
  final bool isBooked;
  List<ScheduleDetails> scheduleDetail = [];
  TutorInfo? tutorInfo;

  ScheduleItem(
      {required this.startTime,
      required this.endTime,
      required this.isBooked,
      required this.id,
      required this.scheduleDetail,
      required this.tutorInfo});

  factory ScheduleItem.fromJson(Map<String, dynamic> json) {
    List<ScheduleDetails> scheduleDetails = [];
    if (json['scheduleDetails'] != null) {
      for (var v in json['scheduleDetails']) {
        scheduleDetails.add(ScheduleDetails.fromJson(v));
      }
    }
    return ScheduleItem(
        id: json['id'],
        startTime: json['startTimestamp'],
        endTime: json['endTimestamp'],
        scheduleDetail: scheduleDetails,
        isBooked: json['isBooked'] == null ? true : json['isBooked'],
        tutorInfo: json['tutorInfo'] !=null ? TutorInfo.fromTutorInforJson(json['tutorInfo']): null);
  }
}
