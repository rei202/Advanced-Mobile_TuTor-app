import 'package:lettutor/models/Booking.dart';

class ScheduleUtils {
  static List<List<Booking>> groupScheduleItems(List<Booking> bookingItems) {
    // create an empty list to hold groups
    List<List<Booking>> groups = [];
    // loop through schedule items and group them
    List<Booking> currentGroup = [];
    for (int i = 0; i < bookingItems.length; i++) {
      Booking currentItem = bookingItems[i];
      Booking? previousItem = i > 0 ? bookingItems[i - 1] : null;
      DateTime currentStartTime = DateTime.fromMillisecondsSinceEpoch(
          currentItem.scheduleDetailInfo!.startPeriodTimestamp);
      DateTime? previousEndTime;
      if (previousItem != null)
        previousEndTime = DateTime.fromMillisecondsSinceEpoch(
            previousItem.scheduleDetailInfo!.endPeriodTimestamp);
      if (previousItem == null ||
          currentStartTime.difference(previousEndTime!).inMinutes > 5 || bookingItems[i].scheduleDetailInfo?.scheduleInfo?.tutorInfo?.userId != bookingItems[i - 1].scheduleDetailInfo?.scheduleInfo?.tutorInfo?.userId) {
        // start a new group
        currentGroup = [currentItem];
        groups.add(currentGroup);
      } else {
        // add item to current group
        currentGroup.add(currentItem);
      }
    }
    return groups;
  }
}
