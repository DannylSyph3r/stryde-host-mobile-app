import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stryde_mobile_app/features/calendar/models/calendar_event_model.dart';
import 'package:stryde_mobile_app/features/calendar/providers/calendar_providers.dart';
import 'package:stryde_mobile_app/features/calendar/utils/calendar_event_utils.dart';
import 'package:stryde_mobile_app/theme/palette.dart';
import 'package:stryde_mobile_app/utils/app_extensions.dart';

class SelectionCalendar extends ConsumerWidget {
  final ValueChanged<DateTime> onDateSelected;

  const SelectionCalendar(
      {super.key,
      required this.onDateSelected});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final focusedDay = ref.watch(focusedDayProvider);

    void onPreviousMonth() {
      ref.read(focusedDayProvider.notifier).state = DateTime(
        focusedDay.year,
        focusedDay.month - 1,
      );
    }

    void onNextMonth() {
      ref.read(focusedDayProvider.notifier).state = DateTime(
        focusedDay.year,
        focusedDay.month + 1,
      );
    }

    void handleDateSelected(DateTime date) {
      final calendarSelectionNotifier =
          ref.read(calendarSelectionProvider.notifier);
      final calendarSelectionState = ref.read(calendarSelectionProvider);

      if (calendarSelectionState.isListingMode) {
        final wasToggled = calendarSelectionNotifier.toggleDate(date, context);
        if (!wasToggled) {
          return;
        }
      } else {
        ref.read(calendarDateProvider.notifier).state = date;
        onDateSelected(date);
        // The currentEventSetDetailsProvider will automatically update
      }
    }

    return Container(
      padding: 10.0.padV,
      decoration: BoxDecoration(
        color: Palette.buttonBG,
        borderRadius: BorderRadius.all(Radius.circular(15.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(0, 4),
            blurRadius: 8.0,
            spreadRadius: 5.0,
          ),
        ],
      ),
      child: Column(
        children: [
          CalendarHeader(
            focusedDay: focusedDay,
            onPreviousMonth: onPreviousMonth,
            onNextMonth: onNextMonth,
          ),
          const CalendarDaysOfWeek(),
          CalendarGrid(
            focusedDay: focusedDay,
            onDateSelected: handleDateSelected,
          ),
        ],
      ),
    );
  }
}

// CalendarHeader Widget
class CalendarHeader extends StatelessWidget {
  final DateTime focusedDay;
  final VoidCallback onPreviousMonth;
  final VoidCallback onNextMonth;

  const CalendarHeader({
    super.key,
    required this.focusedDay,
    required this.onPreviousMonth,
    required this.onNextMonth,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Palette.darkBG.withOpacity(0.4), shape: BoxShape.circle),
            child: Padding(
              padding: 5.0.padA,
              child: Icon(
                PhosphorIconsBold.caretLeft,
                size: 25.h,
                color: Palette.strydeOrange,
              ),
            ),
          ).tap(onTap: onPreviousMonth),
          "${DaysOfTheWeek.monthNames[focusedDay.month - 1]} ${focusedDay.year}"
              .txt(size: 17.sp, fontW: F.w6),
          Container(
            decoration: BoxDecoration(
                color: Palette.darkBG.withOpacity(0.4), shape: BoxShape.circle),
            child: Padding(
              padding: 5.0.padA,
              child: Icon(
                PhosphorIconsBold.caretRight,
                size: 25.h,
                color: Palette.strydeOrange,
              ),
            ),
          ).tap(onTap: onNextMonth),
        ],
      ),
    );
  }
}

// CalendarDaysOfWeek Widget
class CalendarDaysOfWeek extends StatelessWidget {
  const CalendarDaysOfWeek({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: ['S', 'M', 'T', 'W', 'T', 'F', 'S'].map((day) {
        return Expanded(
          child: Center(
            child: day.txt18(fontW: F.w6),
          ),
        );
      }).toList(),
    );
  }
}

// CalendarGrid Widget
// CalendarGrid Widget
class CalendarGrid extends ConsumerWidget {
  final DateTime focusedDay;
  final ValueChanged<DateTime> onDateSelected;

  const CalendarGrid({
    super.key,
    required this.focusedDay,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(calendarDateProvider);
    final calendarSelectionState = ref.watch(calendarSelectionProvider);
    final firstDayOfMonth = DateTime(focusedDay.year, focusedDay.month, 1);
    final lastDayOfMonth = DateTime(focusedDay.year, focusedDay.month + 1, 0);
    final daysInMonth = lastDayOfMonth.day;
    final firstWeekday = firstDayOfMonth.weekday % 7;
    final totalDays = firstWeekday + daysInMonth;

    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: GridView.builder(
        key: ValueKey(focusedDay.month),
        shrinkWrap: true,
        itemCount: totalDays,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
        ),
        itemBuilder: (context, index) {
          if (index < firstWeekday) {
            return Container();
          } else {
            final day = index - firstWeekday + 1;
            final date = DateTime(focusedDay.year, focusedDay.month, day);
            final isSelected = !calendarSelectionState.isListingMode &&
                selectedDate.year == date.year &&
                selectedDate.month == date.month &&
                selectedDate.day == date.day;
            final isUnlisted =
                calendarSelectionState.unlistedDates.contains(date);
            final isToday = date.year == todayDate.year &&
                date.month == todayDate.month &&
                date.day == todayDate.day;
            final events = CalendarEventUtils.getEventsForDate(date);

            return GestureDetector(
              onTap: () => onDateSelected(date),
              child: Container(
                color: Colors.transparent,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 7.h,
                            height: 7.h,
                            decoration: BoxDecoration(
                              color: events.contains(EventType.dropOff)
                                  ? Palette.whiteColor
                                  : Colors.transparent,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 5.h),
                          Container(
                            width: 7.h,
                            height: 7.h,
                            decoration: BoxDecoration(
                              color: events.contains(EventType.pickUp)
                                  ? Palette.strydeOrange
                                  : Colors.transparent,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                      3.sbH,
                      Opacity(
                        opacity: isUnlisted ? 0.4 : 1.0,
                        child: day.toString().txt(
                              size: 18.sp,
                              color: isToday
                                  ? Palette.strydeOrange
                                  : (isSelected
                                      ? Palette.strydeOrange
                                      : Palette.whiteColor),
                              fontWeight: isSelected || isToday
                                  ? FontWeight.w600
                                  : FontWeight.w300,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

// DaysOfTheWeek
class DaysOfTheWeek {
  static const List<String> monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
}
