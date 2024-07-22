// import 'package:file_picker/file_picker.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stryde_mobile_app/theme/palette.dart';
import 'package:stryde_mobile_app/utils/app_extensions.dart';
import 'package:stryde_mobile_app/utils/type_defs.dart';

void showSnackBar({required BuildContext context, required String text}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        duration: const Duration(milliseconds: 2000),
        content: text.txt16(
          fontWeight: FontWeight.w500,
          color: Palette.whiteColor,
        ),
      ),
    );
}

//! SHOW BANNER
showBanner({
  required BuildContext context,
  required String theMessage,
  required NotificationType theType,
  Duration? dismissIn,
}) {
  Flushbar(
    message: theMessage,
    messageSize: 15.sp,
    duration: const Duration(seconds: 4),
    flushbarPosition: FlushbarPosition.TOP,
    flushbarStyle: FlushbarStyle.FLOATING,
    margin: EdgeInsets.symmetric(horizontal: 10.w),
    borderRadius: BorderRadius.circular(7.r),
    reverseAnimationCurve: Curves.decelerate,
    forwardAnimationCurve: Curves.linearToEaseOut,
    messageColor: Colors.white,
    icon: Icon(
      theType == NotificationType.failure
          ? PhosphorIconsBold.warning
          : theType == NotificationType.success
              ? PhosphorIconsBold.checks
              : PhosphorIconsBold.warningCircle,
      color: Colors.white,
    ),
    backgroundColor: theType == NotificationType.failure
        ? Colors.red.shade400
        : theType == NotificationType.success
            ? Colors.green.shade400
            : Colors.green.shade500,
  ).show(context);
}
