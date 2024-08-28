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

  static List<EventSetDetails> getEventSetDetailsForDate(DateTime date) {
    Map<String, EventSetDetails> eventSetDetailsMap = {};

    for (var eventSet in eventSets) {
      bool isDropOffSameDay = isSameDay(eventSet.dropOff.eventDateTime, date);
      bool isPickUpSameDay = isSameDay(eventSet.pickUp.eventDateTime, date);

      if (isDropOffSameDay || isPickUpSameDay) {
        String key = eventSet.dropOff.carName; // Use car name as a unique key

        if (!eventSetDetailsMap.containsKey(key)) {
          eventSetDetailsMap[key] = EventSetDetails(
            vehicle: eventSet.dropOff.carName,
            dropOffLocation: eventSet.dropOff.location,
            dropOffDateTime: eventSet.dropOff.eventDateTime,
            pickUpLocation: eventSet.pickUp.location,
            pickUpDateTime: eventSet.pickUp.eventDateTime,
            dropOffEventType: isDropOffSameDay ? EventType.dropOff : null,
            pickUpEventType: isPickUpSameDay ? EventType.pickUp : null,
          );
        } else {
          // If both events are on the same day, update the existing entry
          if (isDropOffSameDay) {
            eventSetDetailsMap[key]!.dropOffEventType = EventType.dropOff;
          }
          if (isPickUpSameDay) {
            eventSetDetailsMap[key]!.pickUpEventType = EventType.pickUp;
          }
        }
      }
    }

    return eventSetDetailsMap.values.toList();
  }

  static int getEventCountForDate(DateTime date) {
    int count = 0;
    for (var eventSet in eventSets) {
      if (isSameDay(eventSet.dropOff.eventDateTime, date)) {
        count++;
      }
      if (isSameDay(eventSet.pickUp.eventDateTime, date)) {
        count++;
      }
    }
    return count;
  }

  static bool hasSameDayEvents(DateTime date) {
    var eventSetDetails = getEventSetDetailsForDate(date);
    return eventSetDetails.any((details) => details.hasBothEvents);
  }
}

class EventSetDetails {
  final String vehicle;
  final String dropOffLocation;
  final DateTime dropOffDateTime;
  final String pickUpLocation;
  final DateTime pickUpDateTime;
  EventType? dropOffEventType;
  EventType? pickUpEventType;

  EventSetDetails({
    required this.vehicle,
    required this.dropOffLocation,
    required this.dropOffDateTime,
    required this.pickUpLocation,
    required this.pickUpDateTime,
    this.dropOffEventType,
    this.pickUpEventType,
  });

  bool get hasBothEvents => dropOffEventType != null && pickUpEventType != null;

  EventType? get selectedEventType {
    if (hasBothEvents) {
      return EventType
          .dropOff; // Prioritize drop-off when both events occur on the same day
    }
    return dropOffEventType ?? pickUpEventType;
  }
}
