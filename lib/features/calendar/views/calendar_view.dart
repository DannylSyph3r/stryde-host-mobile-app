import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stryde_mobile_app/features/calendar/providers/calendar_providers.dart';
import 'package:stryde_mobile_app/features/calendar/utils/calendar_event_utils.dart';
import 'package:stryde_mobile_app/features/calendar/views/calendar_event_details_view.dart';
import 'package:stryde_mobile_app/features/calendar/widgets/event_details_box.dart';
import 'package:stryde_mobile_app/features/calendar/widgets/selection_calendar.dart';
import 'package:stryde_mobile_app/theme/palette.dart';
import 'package:stryde_mobile_app/utils/app_extensions.dart';
import 'package:stryde_mobile_app/utils/nav.dart';
import 'package:stryde_mobile_app/utils/option_selection_modal.dart';
import 'package:stryde_mobile_app/utils/widgets/appbar.dart';
import 'package:stryde_mobile_app/utils/widgets/button.dart';

class CalendarView extends ConsumerStatefulWidget {
  const CalendarView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CalendarViewState();
}

class _CalendarViewState extends ConsumerState<CalendarView> {
  List<EventSetDetails> _currentEventSetDetails = [];

  String getDaySuffix(int day) {
    if (day >= 11 && day <= 13) {
      return 'th';
    }
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  final List<Map<String, dynamic>> optionSelections = [
    {'icon': PhosphorIconsBold.listBullets, 'label': 'Unlist/List'},
  ];

  @override
  Widget build(BuildContext context) {
    final calendarSelectionState = ref.watch(calendarSelectionProvider);
    final isListingModeOn = calendarSelectionState.isListingMode;
    final sortedDates = calendarSelectionState.unlistedDates.toList()..sort();
    final calendarDate = ref.watch(calendarDateProvider);
    final daySuffix = getDaySuffix(calendarDate.day);
    final today = DateTime.now();
    final isToday = calendarDate.year == today.year &&
        calendarDate.month == today.month &&
        calendarDate.day == today.day;
    final formattedDate = isToday
        ? 'Today'
        : DateFormat('EEEE MMM d').format(calendarDate) + daySuffix;

    return Scaffold(
      appBar: customAppBar(
        title: isListingModeOn ? "Listing" : "Calendar",
        context: context,
        implyLeading: false,
        toolbarHeight: 70.h,
        color: Colors.transparent,
        isTitleCentered: true,
        actions: [
          Visibility(
            visible: !isListingModeOn,
            child: Padding(
              padding: 10.padH,
              child: Icon(
                PhosphorIconsBold.dotsThreeVertical,
                size: 25.h,
              ).tap(onTap: () {
                showOptionsModal(
                  context,
                  selectionOptions: optionSelections
                      .map((option) => option['label'] as String)
                      .toList(),
                  leadingIcons: optionSelections
                      .map((option) => option['icon'] as IconData)
                      .toList(),
                  titleFontSize: 16.sp,
                  titleFontColor: Colors.white,
                  leadingIconColor: Colors.orange,
                  modalHeight: 110.h,
                  listViewHeight: 60.h,
                  onOptionTap: (index) {
                    ref
                        .read(calendarSelectionProvider.notifier)
                        .toggleListingMode();
                    goBack(context);
                  },
                );
              }),
            ),
          )
        ],
      ),
      body: Padding(
        padding: 15.padH,
        child: ListView(
          children: [
            10.sbH,
            SelectionCalendar(
              onDateSelected: (onSelectedDate) {
                onSelectedDate.log();
                "Provider Value: ${ref.read(calendarDateProvider.notifier).state}"
                    .log();
              },
              onEventSetDetailsUpdated: (eventSetDetails) {
                setState(() {
                  _currentEventSetDetails = eventSetDetails;
                  _currentEventSetDetails.elementAt(0).selectedEventType.log();
                });
              },
            ),
            30.sbH,
            Visibility(
              visible: !isListingModeOn,
              child: Column(
                children: [
                  formattedDate
                      .txt18(fontW: F.w6, textAlign: TextAlign.left)
                      .alignCenterLeft(),
                  10.sbH,
                  "${_currentEventSetDetails.length} event${_currentEventSetDetails.length != 1 ? 's' : ''}"
                      .txt16(textAlign: TextAlign.left)
                      .alignCenterLeft(),
                  10.sbH,
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _currentEventSetDetails.length,
                    itemBuilder: (context, index) {
                      final eventSet = _currentEventSetDetails[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        child: EventDetailsBox(
                          vehicleName: eventSet.vehicle,
                          dropOffLocation: eventSet.dropOffLocation,
                          dropOffTime: DateFormat('MMM d, yyyy h:mm a')
                              .format(eventSet.dropOffDateTime),
                          pickUpLocation: eventSet.pickUpLocation,
                          pickUpTime: DateFormat('MMM d, yyyy h:mm a')
                              .format(eventSet.pickUpDateTime),
                          eventTypeOnDate: eventSet.selectedEventType,
                          viewDetailsTap: () {
                            goTo(
                                context: context,
                                view: CalendarEventDetailsView());
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Visibility(
              visible: isListingModeOn,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  "Days Unlisted"
                      .txt18(fontW: F.w6, textAlign: TextAlign.left)
                      .alignCenterLeft(),
                  20.sbH,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...sortedDates.map((date) {
                        final dayName = DateFormat('EEEE MMM dd').format(date);
                        return Padding(
                          padding: 2.5.padV,
                          child: dayName.txt(size: 16.sp),
                        );
                      }).toList(),
                    ],
                  ),
                  30.sbH,
                  RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(
                      text: "Note: ",
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          color: Palette.strydeOrange,
                          fontSize: 14.sp,
                        ),
                      ),
                      children: [
                        TextSpan(
                          text: "you can only unlist days with no events.",
                          style: GoogleFonts.montserrat(
                            color: Palette.whiteColor,
                            textStyle: TextStyle(
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  50.sbH,
                  AppButton(
                    text: "Save",
                    onTap: () {
                      ref
                          .read(calendarSelectionProvider.notifier)
                          .toggleListingMode();
                    },
                  ).alignCenter(),
                  50.sbH
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
