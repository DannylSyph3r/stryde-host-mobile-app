import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stryde_mobile_app/shared/app_texts.dart';
import 'package:stryde_mobile_app/theme/palette.dart';
import 'package:stryde_mobile_app/utils/app_extensions.dart';

class ProcessConfirmationScreen extends ConsumerWidget {
  const ProcessConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(
            PhosphorIconsFill.checkCircle,
            size: 100.h,
            color: Palette.strydeOrange,
          ),
          30.sbH,
          AppTexts.verfiicationConfirmation.txt16(textAlign: TextAlign.center)
        ]),
      ),
    );
  }
}
