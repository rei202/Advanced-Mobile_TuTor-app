import 'ScheduleDetail.dart';

class Booking {
  late String id;
  late String userId;
  late int updatedAtTimeStamp;
  late int createdAtTimeStamp;
  late String scheduleDetailId;
  late String tutorMeetingLink;
  late String studentMeetingLink;
  String? studentRequest;
  String? tutorReview;
  int? scoreByTutor;
  late String createdAt;
  late String updatedAt;
  String? recordUrl;
  late bool isDeleted;
  bool showRecordUrl = true;
  // List<String> studentMaterials = [];
  ScheduleDetails? scheduleDetailInfo;

  Booking({
    required this.createdAtTimeStamp,
    required this.updatedAtTimeStamp,
    required this.id,
    required this.userId,
    required this.scheduleDetailId,
    required this.tutorMeetingLink,
    required this.studentMeetingLink,
    this.studentRequest,
    this.tutorReview,
    this.scoreByTutor,
    required this.createdAt,
    required this.updatedAt,
    this.recordUrl,
    required this.isDeleted,
    required this.showRecordUrl,
    // required this.studentMaterials,
    this.scheduleDetailInfo,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      createdAtTimeStamp: json['createdAtTimeStamp'],
      updatedAtTimeStamp: json['updatedAtTimeStamp'],
      id: json['id'],
      userId: json['userId'],
      scheduleDetailId: json['scheduleDetailId'],
      tutorMeetingLink: json['tutorMeetingLink'],
      studentMeetingLink: json['studentMeetingLink'],
      studentRequest: json['studentRequest'],
      tutorReview: json['tutorReview'],
      scoreByTutor: json['scoreByTutor'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      recordUrl: json['recordUrl'],
      isDeleted: json['isDeleted'],
      showRecordUrl: json["showRecordUrl"] ?? true,
      // studentMaterials: json["studentMaterials"] ?? [],
      scheduleDetailInfo: json["scheduleDetailInfo"] != null
          ? ScheduleDetails.fromJson(json["scheduleDetailInfo"])
          : null,
    );
  }
}
