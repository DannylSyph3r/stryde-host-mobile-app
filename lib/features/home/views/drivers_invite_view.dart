import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stryde_mobile_app/theme/palette.dart';
import 'package:stryde_mobile_app/utils/app_extensions.dart';
import 'package:stryde_mobile_app/utils/snack_bar.dart';
import 'package:stryde_mobile_app/utils/type_defs.dart';
import 'package:stryde_mobile_app/utils/widgets/appbar.dart';
import 'package:stryde_mobile_app/utils/widgets/vertical_railer.dart';

class DriversInviteView extends ConsumerWidget {
  const DriversInviteView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: customAppBar(
        title: "Drivers",
        context: context,
        color: Colors.transparent,
        isTitleCentered: true,
      ),
      body: Center(
        child: VerticalRailer(
          columnPadding: 15.padH,
          middle: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                PhosphorIconsFill.user,
                color: Palette.buttonBG,
                size: 150.h,
              ),
              10.sbH,
              "Invite a Driver".txt16()
            ],
          ),
          bottom: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: 15.0.padA,
                decoration: BoxDecoration(
                    color: Palette.buttonBG,
                    borderRadius: BorderRadius.circular(15.r)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    "AGassahashsq12".txt16(),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          PhosphorIconsBold.copySimple,
                          color: Palette.strydeOrange,
                          size: 25.h,
                        ),
                        5.sbW,
                        "Copy".txt14(fontW: F.w6),
                      ],
                    ).tap(onTap: () {
                      showFlushBanner(
                          context: context,
                          maxWidth: 130.w,
                          theMessage: "Copied",
                          theType: NotificationType.info,
                          dismissIn: const Duration(milliseconds: 200));
                    })
                  ],
                ),
              ),
              20.sbH,
              Container(
                width: 130.w,
                padding: 15.0.padA,
                decoration: BoxDecoration(
                  color: Palette.strydeOrange,
                  borderRadius: BorderRadius.circular(30.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      offset: const Offset(0, 4),
                      blurRadius: 8.0,
                      spreadRadius: 5.0,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      PhosphorIconsBold.uploadSimple,
                      size: 22.h,
                    ),
                    10.sbW,
                    "Invite".txt14(color: Palette.whiteColor, fontW: F.w6)
                  ],
                ),
              ),
              30.sbH
            ],
          ),
        ),
      ),
    );
  }
}
