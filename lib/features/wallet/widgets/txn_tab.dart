import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stryde_mobile_app/theme/palette.dart';
import 'package:stryde_mobile_app/utils/app_extensions.dart';

class PendingTransactionsTab extends ConsumerWidget {
  const PendingTransactionsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Palette.buttonBG,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SpinKitCircle(color: Palette.strydeOrange, size: 20),
          15.sbW,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              "Withdrawal".txt14(fontW: F.w8),
              5.sbH,
              "To ****24".txt12(fontW: F.w4),
            ],
          ),
          15.sbW,
          "₦10,000".txt16(fontW: F.w6)
        ],
      ),
    );
  }
}
