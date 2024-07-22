import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stryde_mobile_app/theme/palette.dart';
import 'package:stryde_mobile_app/utils/nav.dart';

AppBar customAppBar(String title,
    {bool isLeftAligned = false,
    bool? isTitleCentered,
    bool? implyLeading,
    double? fontSize,
    FontWeight? fontWeight,
    List<Widget>? actions,
    TabBar? bottom,
    double? toolbarHeight,
    bool showBackButton = true,
    Color? color,
    Color? fontColor,
    Color? iconColor,
    bool overrideBackButtonAction = false,
    bool showXIcon = false,
    Color? foregroundColor,
    Function? backFunction,
    required BuildContext context}) {
  bool shouldShowLeading = implyLeading ?? true;
  bool shouldCenterTitle =
      isTitleCentered ?? (!shouldShowLeading || !isLeftAligned);

  final isDarkMode = Theme.of(context).brightness == Brightness.dark;
  final backgroundColor =
      color ?? (isDarkMode ? Palette.darkBG : Palette.whiteColor);
  final onBackgroundColor =
      isDarkMode ? Palette.whiteColor : Palette.blackColor;

  return AppBar(
    toolbarHeight: toolbarHeight ?? 75.h,
    automaticallyImplyLeading: shouldShowLeading,
    titleSpacing: isLeftAligned ? 0 : 5.w,
    scrolledUnderElevation: 0,
    surfaceTintColor: Colors.transparent,
    foregroundColor: foregroundColor ?? onBackgroundColor,
    backgroundColor: color ?? backgroundColor,
    leading: shouldShowLeading
        ? showBackButton
            ? overrideBackButtonAction
                ? showXIcon
                    ? IconButton(
                        onPressed: () => backFunction!(),
                        icon: Icon(
                          Icons.close,
                          color: iconColor ?? onBackgroundColor,
                        ))
                    : BackButton(
                        color: iconColor ?? onBackgroundColor,
                        onPressed: () => backFunction!(),
                      )
                : showXIcon
                    ? IconButton(
                        onPressed: () => goBack(context),
                        icon: Icon(
                          Icons.close,
                          color: iconColor ?? onBackgroundColor,
                        ))
                    : BackButton(
                        color: iconColor ?? onBackgroundColor,
                      )
            : null
        : null,
    elevation: 0,
    centerTitle: shouldCenterTitle,
    leadingWidth: isLeftAligned ? 30.w : null,
    title: Text(
      title,
      style: GoogleFonts.montserrat(
        textStyle: TextStyle(
          fontSize: fontSize ?? 22.sp,
          color: fontColor ?? onBackgroundColor,
          fontWeight: fontWeight,
        ),
      ),
    ),
    actions: actions ?? const [SizedBox.shrink()],
    bottom: bottom,
  );
}
