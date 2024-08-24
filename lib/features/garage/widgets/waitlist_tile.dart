import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stryde_mobile_app/shared/app_graphics.dart';
import 'package:stryde_mobile_app/theme/palette.dart';
import 'package:stryde_mobile_app/utils/app_extensions.dart';
import 'package:stryde_mobile_app/utils/widgets/row_railer.dart';

class WaitlistTile extends ConsumerWidget {
  final String renterName;
  final String dateFrom;
  final String timeFrom;
  final String dateTo;
  final String timeTo;
  final VoidCallback onWaitListTap;
  const WaitlistTile(
      {required this.renterName,
      required this.dateFrom,
      required this.timeFrom,
      required this.dateTo,
      required this.timeTo,
      required this.onWaitListTap,
      super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 15.h),
      child: Row(children: [
        Container(
          height: 60.h,
          decoration: BoxDecoration(
            color: Palette.buttonBG.withOpacity(0.5),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Palette.strydeOrange.withOpacity(0.2),
                spreadRadius: 7,
                blurRadius: 10,
              ),
            ],
          ),
          child: Center(
              child: AppGraphics.memeoji.png.myImage(fit: BoxFit.contain)),
        ),
        15.sbW,
        Expanded(
            child: Column(
          children: [
            renterName
                .txt12(
                    textAlign: TextAlign.left,
                    fontW: F.w6,
                    overflow: TextOverflow.ellipsis)
                .alignCenterLeft(),
            5.sbH,
            RowRailer(
              rowPadding: 0.padH,
              leading: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  dateFrom.txt14(textAlign: TextAlign.left).alignCenterLeft(),
                  5.sbH,
                  timeFrom.txt12(textAlign: TextAlign.left).alignCenterLeft()
                ],
              ),
              middle: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    PhosphorIconsBold.caretRight,
                    color: Palette.strydeOrange,
                    size: 20.h,
                  ),
                  15.sbW
                ],
              ),
              trailing: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  dateTo.txt14(textAlign: TextAlign.left).alignCenterLeft(),
                  5.sbH,
                  timeTo.txt12(textAlign: TextAlign.left).alignCenterLeft()
                ],
              ),
            )
          ],
        )),
      ]).tap(onTap: onWaitListTap),
    );
  }
}
