import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stryde_mobile_app/features/calendar/providers/calendar_providers.dart';
import 'package:stryde_mobile_app/features/messages/views/chat_view.dart';
import 'package:stryde_mobile_app/shared/app_graphics.dart';
import 'package:stryde_mobile_app/theme/palette.dart';
import 'package:stryde_mobile_app/utils/app_extensions.dart';
import 'package:stryde_mobile_app/utils/nav.dart';
import 'package:stryde_mobile_app/utils/widgets/appbar.dart';
import 'package:stryde_mobile_app/utils/widgets/container_list_tile.dart';
import 'package:stryde_mobile_app/utils/widgets/row_railer.dart';

class CalendarEventDetailsView extends ConsumerStatefulWidget {
  const CalendarEventDetailsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CalendarEventDetailsViewState();
}

class _CalendarEventDetailsViewState
    extends ConsumerState<CalendarEventDetailsView> {
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
        title: "Details",
        context: context,
        toolbarHeight: 70.h,
        color: Colors.transparent,
        isTitleCentered: true,
      ),
      body: Padding(
        padding: 15.padH,
        child: Column(children: [
          10.sbH,
          RowRailer(
            rowPadding: 0.padH,
            leading: Row(
              children: [
                Container(
                  height: 60.h,
                  decoration: BoxDecoration(
                    color: Palette.buttonBG.withOpacity(0.5),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Palette.strydeOrange.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  child: Center(
                      child:
                          AppGraphics.memeoji.png.myImage(fit: BoxFit.contain)),
                ),
                15.sbW,
                Expanded(
                    child: Column(
                  children: [
                    Container(
                      child: "Akinola Daniel Eri-ife"
                          .txt16(
                              textAlign: TextAlign.left,
                              fontW: F.w6,
                              overflow: TextOverflow.ellipsis)
                          .alignCenterLeft(),
                    ),
                    3.sbH,
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        "4.5".txt14(textAlign: TextAlign.left, fontW: F.w4),
                        5.sbW,
                        Icon(
                          PhosphorIconsFill.star,
                          size: 15.h,
                          color: Palette.strydeOrange,
                        )
                      ],
                    ).alignCenterLeft(),
                  ],
                ))
              ],
            ),
            trailing: Icon(
              PhosphorIconsFill.envelope,
              size: 30.h,
              color: Palette.strydeOrange,
            ).tap(onTap: (){
              goTo(context: context, view: ChatView());
            }),
          ),
          30.sbH,
          formattedDate
              .txt18(fontW: F.w6, textAlign: TextAlign.left)
              .alignCenterLeft(), // Display the formatted date with suffix
          10.sbH,
          "2 events".txt14(textAlign: TextAlign.left).alignCenterLeft(),
          20.sbH,
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
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
