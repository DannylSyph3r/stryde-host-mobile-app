import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stryde_mobile_app/features/calendar/providers/calendar_providers.dart';
import 'package:stryde_mobile_app/theme/palette.dart';
import 'package:stryde_mobile_app/utils/app_extensions.dart';

// SelectionCalendar Widget
class SelectionCalendar extends ConsumerWidget {
  final ValueChanged<DateTime> onDateSelected;

  const SelectionCalendar({super.key, required this.onDateSelected});

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
      ref.read(calendarDateProvider.notifier).state = date;
      onDateSelected(date);
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
                color: Palette.darkBG.withOpacity(0.4),
                shape: BoxShape.circle),
            child: Padding(
              padding: 5.0.padA,
              child: Icon(
                PhosphorIconsBold.caretLeft,
                size: 25.h,
                color: Palette.strydeOrange,
              ),
            ),
          ).tap(onTap: onPreviousMonth),
          "${CalendarUtils.monthNames[focusedDay.month - 1]} ${focusedDay.year}"
              .txt(size: 17.sp, fontW: F.w6),
          Container(
            decoration: BoxDecoration(
                color: Palette.darkBG.withOpacity(0.4),
                shape: BoxShape.circle),
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
    final selectedDate = ref.watch(
        calendarDateProvider); // Watching the state provider directly to get the selected date
    final calendarDateNotifier = ref.read(calendarDateProvider.notifier);

    final firstDayOfMonth = DateTime(focusedDay.year, focusedDay.month, 1);
    final lastDayOfMonth = DateTime(focusedDay.year, focusedDay.month + 1, 0);
    final daysInMonth = lastDayOfMonth.day;

    final firstWeekday = firstDayOfMonth.weekday % 7;
    final totalDays = firstWeekday + daysInMonth;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200), // Animation duration
      child: GridView.builder(
        key: ValueKey(focusedDay.month), // Unique key for animation
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
            final isSelected = selectedDate == date;
            return GestureDetector(
              onTap: () {
                calendarDateNotifier.state = date;
                onDateSelected(date);
              },
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
                            width: 7.h, // Set a width for the circles
                            height: 7.h, // Set a height for the circles
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Palette.whiteColor
                                  : Colors.transparent,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 5.h), // Spacing between circles
                          Container(
                            width: 7.h,
                            height: 7.h,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Palette.strydeOrange
                                  : Colors.transparent,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                      3.sbH,
                      day.toString().txt(
                            size: 18.sp,
                            color: isSelected
                                ? Palette.strydeOrange
                                : Palette.whiteColor,
                            fontWeight:
                                isSelected ? FontWeight.w600 : FontWeight.w300,
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

// CalendarUtils
class CalendarUtils {
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
