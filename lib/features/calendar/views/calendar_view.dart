import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stryde_mobile_app/features/calendar/providers/calendar_providers.dart';
import 'package:stryde_mobile_app/features/calendar/views/calendar_event_details_view.dart';
import 'package:stryde_mobile_app/features/calendar/widgets/selection_calendar.dart';
import 'package:stryde_mobile_app/theme/palette.dart';
import 'package:stryde_mobile_app/utils/app_extensions.dart';
import 'package:stryde_mobile_app/utils/nav.dart';
import 'package:stryde_mobile_app/utils/option_selection_modal.dart';
import 'package:stryde_mobile_app/utils/widgets/appbar.dart';
import 'package:stryde_mobile_app/utils/widgets/container_list_tile.dart';

class CalendarView extends ConsumerStatefulWidget {
  const CalendarView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CalendarViewState();
}

class _CalendarViewState extends ConsumerState<CalendarView> {
  // Function to get the appropriate day suffix
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
            title: "Calendar",
            context: context,
            implyLeading: false,
            toolbarHeight: 70.h,
            color: Colors.transparent,
            isTitleCentered: true,
            actions: [
              Padding(
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
                    modalHeight: 150.h, // Specify the height of the modal
                    listViewHeight: 80.h, // Specify the height of the ListView
                    onOptionTap: (index) {},
                  );
                }),
              )
            ]),
        body: Padding(
          padding: 15.padH,
          child: ListView(children: [
            10.sbH,
            SelectionCalendar(onDateSelected: (onSelectedDate) {
              onSelectedDate.log();
              "Provider Value: ${ref.read(calendarDateProvider.notifier).state}"
                  .log();
            }),
            30.sbH,
            formattedDate
                .txt18(fontW: F.w6, textAlign: TextAlign.left)
                .alignCenterLeft(), // Display the formatted date with suffix
            10.sbH,
            "2 events".txt16(textAlign: TextAlign.left).alignCenterLeft(),
            10.sbH,
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
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
                  "Lamborghini Aventador"
                      .txt16(fontW: F.w6, textAlign: TextAlign.left)
                      .alignCenterLeft(),
                  5.sbH,
                  OptionSelectionContainerTile(
                    horizontalContentPadding: 5.w,
                    leadingIcon: PhosphorIconsFill.circle,
                    leadingIconColor: Palette.whiteColor,
                    leadingIconSize: 15.h,
                    titleLabel: "Drop-off",
                    titleFontWeight: F.w6,
                    subtitleLabel: "9:00 AM",
                    subtitleFontSize: 14.sp,
                    interactiveTrailing: true,
                    interactiveTrailingWidget: "Abuja".txt14(fontW: F.w6),
                  ),
                  OptionSelectionContainerTile(
                    horizontalContentPadding: 5.w,
                    leadingIcon: PhosphorIconsFill.circle,
                    leadingIconColor: Palette.strydeOrange,
                    leadingIconSize: 15.h,
                    titleLabel: "Pick-up",
                    titleFontWeight: F.w6,
                    subtitleLabel: "5:00 PM",
                    subtitleFontSize: 14.sp,
                    interactiveTrailing: true,
                    interactiveTrailingWidget: "Abuja".txt14(fontW: F.w6),
                  ),
                  5.sbH,
                  "View Details"
                      .txt16(
                          textAlign: TextAlign.right,
                          color: Palette.strydeOrange,
                          fontW: F.w6)
                      .alignCenterRight()
                      .tap(onTap: () {
                    goTo(context: context, view: CalendarEventDetailsView());
                  }),
                  5.sbH,
                ],
              ),
            ),
            50.sbH,
          ]),
        ));
  }
}
