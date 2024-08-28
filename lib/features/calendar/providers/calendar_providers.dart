import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stryde_mobile_app/features/calendar/utils/calendar_event_utils.dart';
import 'package:stryde_mobile_app/theme/palette.dart';
import 'package:stryde_mobile_app/utils/app_extensions.dart';

final calendarDateProvider = StateProvider<DateTime>((ref) {
  return DateTime.now();
});

final focusedDayProvider = StateProvider<DateTime>((ref) {
  return DateTime.now();
});

//Class to hold the state for listing mode and date selection
class CalendarSelectionState {
  final bool isListingMode;
  final Set<DateTime> selectedDates;
  final Set<DateTime> unlistedDates;

  CalendarSelectionState({
    required this.isListingMode,
    required this.selectedDates,
    required this.unlistedDates,
  });

  CalendarSelectionState copyWith({
    bool? isListingMode,
    Set<DateTime>? selectedDates,
    Set<DateTime>? unlistedDates,
  }) {
    return CalendarSelectionState(
      isListingMode: isListingMode ?? this.isListingMode,
      selectedDates: selectedDates ?? this.selectedDates,
      unlistedDates: unlistedDates ?? this.unlistedDates,
    );
  }
}

class CalendarSelectionNotifier extends StateNotifier<CalendarSelectionState> {
  CalendarSelectionNotifier()
      : super(CalendarSelectionState(
          isListingMode: false,
          selectedDates: {},
          unlistedDates: {},
        ));

  void toggleListingMode() {
    state = state.copyWith(isListingMode: !state.isListingMode);
  }

  bool toggleDate(DateTime date, BuildContext context) {
    if (state.isListingMode) {
      final newUnlistedDates = Set<DateTime>.from(state.unlistedDates);
      final events = CalendarEventUtils.getEventsForDate(date);

      if (events.isNotEmpty) {
        // Show snackbar for the first attempt
        if (!newUnlistedDates.contains(date)) {
          _showSnackBar(context, "Cannot unlist a date with an event.");
        }
        return false; // Date not toggled
      }

      if (newUnlistedDates.contains(date)) {
        newUnlistedDates.remove(date);
      } else {
        newUnlistedDates.add(date);
      }

      state = state.copyWith(unlistedDates: newUnlistedDates);
      return true; // Date successfully toggled
    } else {
      // Handle normal date selection here if needed
      return false;
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(PhosphorIconsBold.warningCircle, color: Palette.strydeOrange,),
            10.sbW,
            Text(
              message,
              style: TextStyle(
                color: (Theme.of(context).colorScheme.brightness == Brightness.dark
                    ? Palette.whiteColor
                    : Palette.blackColor),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        duration: const Duration(milliseconds: 400),
        backgroundColor: Palette.buttonBG,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}

final calendarSelectionProvider =
    StateNotifierProvider<CalendarSelectionNotifier, CalendarSelectionState>(
        (ref) {
  return CalendarSelectionNotifier();
});
