

import 'package:stryde_mobile_app/features/calendar/models/calendar_event_model.dart';

class CalendarEventUtils {
  static List<EventType> getEventsForDate(DateTime date) {
    List<EventType> events = [];
    for (var eventSet in eventSets) {
      if (isSameDay(eventSet.dropOff.eventDateTime, date)) {
        events.add(EventType.dropOff);
      }
      if (isSameDay(eventSet.pickUp.eventDateTime, date)) {
        events.add(EventType.pickUp);
      }
    }
    return events;
  }

  static bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year && 
           date1.month == date2.month && 
           date1.day == date2.day;
  }
}