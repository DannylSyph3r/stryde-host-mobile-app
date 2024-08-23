import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stryde_mobile_app/theme/palette.dart';
import 'package:stryde_mobile_app/utils/app_extensions.dart';

class QuickActionPills extends ConsumerWidget {
  final IconData pillIcon;
  final String pillLabel;
  final VoidCallback? onPillTap;
  const QuickActionPills(
      {required this.pillIcon,
      required this.pillLabel,
      this.onPillTap,
      super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
          decoration: BoxDecoration(
              color: Palette.buttonBG,
              borderRadius: BorderRadius.circular(21.r)),
          child: Center(
            child: Column(
              children: [
                Icon(pillIcon, size: 25.h, color: Palette.strydeOrange),
                5.sbH,
                pillLabel.txt12()
              ],
            ),
          ),
        ).tap(onTap: onPillTap),
      ],
    );
  }
}
