import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stryde_mobile_app/features/base_nav/wrapper/base_nav_wrapper.dart';
import 'package:stryde_mobile_app/shared/app_texts.dart';
import 'package:stryde_mobile_app/theme/palette.dart';
import 'package:stryde_mobile_app/utils/app_extensions.dart';
import 'package:stryde_mobile_app/utils/nav.dart';
import 'package:stryde_mobile_app/utils/widgets/button.dart';
import 'package:stryde_mobile_app/utils/widgets/vertical_railer.dart';

class GarageConfirmationScreen extends ConsumerWidget {
  const GarageConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: VerticalRailer(
      columnPadding: 50.padV,
      middle: Column(
        children: [
          Column(mainAxisSize: MainAxisSize.min, children: [
            Icon(
              PhosphorIconsFill.checkCircle,
              size: 100.h,
              color: Palette.strydeOrange,
            ),
            30.sbH,
            AppTexts.garageVerifiationConfirmation
                .txt16(textAlign: TextAlign.center)
          ]),
        ],
      ),
      bottom: AppButton(text: "Proceed", onTap: () {
        goToAndReplace(context: context, view: BaseNavWrapper());
      }),
    ));
  }
}
