import 'dart:ui';

import 'package:syncfusion_flutter_calendar/calendar.dart';

class MyAppointment extends Appointment {
  final String id;
  final bool isBooked;

  MyAppointment({
    required this.id,
    required this.isBooked,
    required DateTime startTime,
    required DateTime endTime,
    required String subject,
    required Color color,
    required String notes,
  }) : super(
          startTime: startTime,
          endTime: endTime,
          subject: subject,
          color: color,
          notes: notes,
        );
}
