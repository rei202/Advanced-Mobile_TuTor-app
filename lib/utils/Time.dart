import 'package:lettutor/models/Booking.dart';

class TimeUtil {
  static String formatTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays >= 365) {
      final years = (difference.inDays / 365).floor();
      return '$years ${years == 1 ? 'year' : 'years'} ago';
    } else if (difference.inDays >= 30) {
      final months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    } else if (difference.inDays >= 7) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks ${weeks == 1 ? 'week' : 'weeks'} ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else {
      return 'Just now';
    }
  }

  static String formatMinuteToHourCount(int minutes) {
    int hours = minutes ~/ 60;
    int remainingMinutes = minutes % 60;
    String hourString = hours.toString();
    String minuteString = remainingMinutes.toString();
    String result = '';

    if (hours > 0) {
      result += hourString + ' hours ';
    }

    result += minuteString + ' minutes';

    return result;
  }

  static Booking? getNearestObject(List<Booking> objects, int targetTimestamp) {
    Booking? nearestObject;
    int? minDifference;

    for (Booking object in objects) {
      int difference =
          (object.scheduleDetailInfo!.startPeriodTimestamp - targetTimestamp)
              .abs();
      if (minDifference == null || difference < minDifference) {
        minDifference = difference;
        nearestObject = object;
      }
    }
    return nearestObject;
  }
}
