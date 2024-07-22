import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stryde_mobile_app/theme/palette.dart';
import 'package:stryde_mobile_app/utils/app_extensions.dart';

class OptionSelectionListTile extends StatelessWidget {
  final IconData? leadingIcon;
  final double? horizontalContentPadding;
  final double? titleFontSize;
  final String titleLabel;
  final String? subtitleLabel;
  final bool interactiveTrailing;
  final bool? isThreeLines;
  final Widget? interactiveTrailingWidget;
  final void Function()? onTileTap;
  const OptionSelectionListTile(
      {super.key,
      this.horizontalContentPadding,
      required this.interactiveTrailing,
      this.isThreeLines = false,
      this.interactiveTrailingWidget,
      this.leadingIcon,
      this.subtitleLabel,
      required this.titleLabel,
      this.titleFontSize,
      this.onTileTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTileTap,
      contentPadding: EdgeInsets.symmetric(
          vertical: 0.h, horizontal: horizontalContentPadding ?? 10.w),
      isThreeLine: isThreeLines ?? false,
      minVerticalPadding: 10.h,
      minLeadingWidth: 5.w,
      subtitle: subtitleLabel?.txt12(),
      leading: leadingIcon != null
          ? Icon(
              leadingIcon,
              size: 24.sp,
              color: Palette.strydeOrange,
            )
          : const SizedBox.shrink(),
      title: Container(
          padding:
              subtitleLabel != null ? EdgeInsets.only(bottom: 10.h) : 0.0.padA,
          child: titleLabel.txt(size: titleFontSize ?? 16.sp, fontW: F.w3)),
      trailing: interactiveTrailing == false
          ? Icon(PhosphorIconsBold.caretRight, size: 15.h, color: Palette.strydeOrange,)
          : interactiveTrailingWidget
    );
  }
}
