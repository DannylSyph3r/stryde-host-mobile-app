import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stryde_mobile_app/shared/app_graphics.dart';
import 'package:stryde_mobile_app/theme/palette.dart';
import 'package:stryde_mobile_app/utils/app_extensions.dart';
import 'package:stryde_mobile_app/utils/widgets/row_railer.dart';

class WaitlistTile extends ConsumerWidget {
  const WaitlistTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: 10.padV,
      child: Row(children: [
        Container(
          height: 60.h,
          decoration: BoxDecoration(
            color: Palette.buttonBG.withOpacity(0.5),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Palette.strydeOrange.withOpacity(0.2),
                spreadRadius: 10,
                blurRadius: 15,
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
            "Akinola Daniel Eri-ife"
                .txt14(
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
                  "8th January"
                      .txt12(textAlign: TextAlign.left)
                      .alignCenterLeft(),
                  5.sbH,
                  "3:30 AM".txt12(textAlign: TextAlign.left).alignCenterLeft()
                ],
              ),
              middle: const Icon(
                PhosphorIconsBold.caretRight,
                color: Palette.strydeOrange,
              ),
              trailing: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  "8th January"
                      .txt12(textAlign: TextAlign.right)
                      .alignCenterRight(),
                  5.sbH,
                  "3:30 AM".txt12(textAlign: TextAlign.right).alignCenterRight()
                ],
              ),
            )
          ],
        )),
      ]),
    );
  }
}
