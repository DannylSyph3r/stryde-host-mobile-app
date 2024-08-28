import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stryde_mobile_app/features/calendar/models/calendar_event_model.dart';
import 'package:stryde_mobile_app/theme/palette.dart';
import 'package:stryde_mobile_app/utils/app_extensions.dart';
import 'package:stryde_mobile_app/utils/widgets/container_list_tile.dart';

class EventDetailsBox extends ConsumerWidget {
  final String vehicleName;
  final String dropOffLocation;
  final String dropOffTime;
  final String pickUpLocation;
  final String pickUpTime;
  final EventType eventTypeOnDate;
  final bool hasBothEvents;
  final VoidCallback viewDetailsTap;
  const EventDetailsBox(
      {required this.vehicleName,
      required this.dropOffLocation,
      required this.dropOffTime,
      required this.pickUpLocation,
      required this.pickUpTime,
      required this.eventTypeOnDate,
      required this.viewDetailsTap,
      required this.hasBothEvents,
      super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
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
          vehicleName
              .txt16(fontW: F.w6, textAlign: TextAlign.left)
              .alignCenterLeft(),
          5.sbH,
          Opacity(
            opacity: hasBothEvents
                ? 1.0
                : (eventTypeOnDate == EventType.dropOff ? 1.0 : 0.5),
            child: OptionSelectionContainerTile(
              horizontalContentPadding: 5.w,
              leadingIcon: PhosphorIconsFill.circle,
              leadingIconColor: Palette.whiteColor,
              leadingIconSize: 15.h,
              titleLabel: "Drop-off",
              titleFontWeight: F.w6,
              subtitleLabel: dropOffTime,
              subtitleFontSize: 14.sp,
              interactiveTrailing: true,
              interactiveTrailingWidget: dropOffLocation.txt14(fontW: F.w6),
            ),
          ),
          Opacity(
            opacity: hasBothEvents
                ? 1.0
                : (eventTypeOnDate == EventType.pickUp ? 1.0 : 0.5),
            child: OptionSelectionContainerTile(
              horizontalContentPadding: 5.w,
              leadingIcon: PhosphorIconsFill.circle,
              leadingIconColor: Palette.strydeOrange,
              leadingIconSize: 15.h,
              titleLabel: "Pick-up",
              titleFontWeight: F.w6,
              subtitleLabel: pickUpTime,
              subtitleFontSize: 14.sp,
              interactiveTrailing: true,
              interactiveTrailingWidget: pickUpLocation.txt14(fontW: F.w6),
            ),
          ),
          5.sbH,
          "View Details"
              .txt16(
                  textAlign: TextAlign.right,
                  color: Palette.strydeOrange,
                  fontW: F.w6)
              .alignCenterRight()
              .tap(onTap: viewDetailsTap),
          5.sbH,
        ],
      ),
    );
  }
}
