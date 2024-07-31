import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stryde_mobile_app/theme/palette.dart';
import 'package:stryde_mobile_app/utils/app_extensions.dart';

class OptionSelectionContainerTile extends StatelessWidget {
  final IconData? leadingIcon;
  final double? horizontalContentPadding;
  final double? titleFontSize;
  final F? titleFontWeight;
  final double? leadingIconSize;
  final double? subtitleFontSize;
  final F? subtitleFontWeight;
  final String titleLabel;
  final String? subtitleLabel;
  final bool interactiveTrailing;
  final bool? isThreeLines;
  final Color? leadingIconColor;
  final Color? titleFontColor;
  final Color? subtitleFontColor;
  final Widget? interactiveTrailingWidget;
  final void Function()? onTileTap;

  const OptionSelectionContainerTile({
    super.key,
    this.horizontalContentPadding,
    required this.interactiveTrailing,
    this.isThreeLines = false,
    this.interactiveTrailingWidget,
    this.leadingIconSize,
    this.leadingIcon,
    this.leadingIconColor,
    this.titleFontColor,
    this.subtitleFontColor,
    this.subtitleLabel,
    required this.titleLabel,
    this.titleFontSize,
    this.titleFontWeight,
    this.subtitleFontSize,
    this.subtitleFontWeight,
    this.onTileTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTileTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 2.h, // Adjusted for less vertical space
          horizontal: horizontalContentPadding ?? 10.w,
        ),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          decoration: BoxDecoration(
            color: Colors.transparent, // Change as needed
            borderRadius:
                BorderRadius.circular(8.r), // Optional: add border radius
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (leadingIcon != null) ...[
                Icon(
                  leadingIcon,
                  size: leadingIconSize ?? 24.sp,
                  color: leadingIconColor ?? Palette.strydeOrange,
                ),
                SizedBox(width: 10.w), // Adjusted spacing between icon and text
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleLabel.txt(
                      size: subtitleFontSize ?? 16.sp,
                      fontW: subtitleFontWeight ?? F.w3,
                      color: subtitleFontColor ??
                          Theme.of(context).textTheme.bodySmall?.color,
                    ),
                    if (subtitleLabel != null) ...[
                      SizedBox(
                          height: 2
                              .h), // Adjusted spacing between title and subtitle

                      subtitleLabel!.txt(
                        size: subtitleFontSize ?? 12.sp,
                        fontW: subtitleFontWeight ?? F.w3,
                        color: subtitleFontColor ??
                            Theme.of(context).textTheme.bodySmall?.color,
                      ),
                    ],
                  ],
                ),
              ),
              if (interactiveTrailing) ...[
                interactiveTrailingWidget ??
                    Icon(
                      PhosphorIconsBold.caretRight,
                      size: 15.h,
                      color: Palette.strydeOrange,
                    ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
