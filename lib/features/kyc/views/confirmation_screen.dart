import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stryde_mobile_app/features/kyc/providers/kyc_providers.dart';
import 'package:stryde_mobile_app/features/kyc/views/kyc_slider.dart';
import 'package:stryde_mobile_app/shared/app_texts.dart';
import 'package:stryde_mobile_app/theme/palette.dart';
import 'package:stryde_mobile_app/utils/app_extensions.dart';
import 'package:stryde_mobile_app/utils/nav.dart';
import 'package:stryde_mobile_app/utils/widgets/button.dart';
import 'package:stryde_mobile_app/utils/widgets/vertical_railer.dart';

class ProcessConfirmationScreen extends ConsumerWidget {
  const ProcessConfirmationScreen({super.key});

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
                  // .animate().scaleY(duration: 250.milliseconds),
                  30.sbH,
                  AppTexts.verfiicationConfirmation
                      .txt16(textAlign: TextAlign.center)
                  // .animate()
                  // .fadeIn(duration: 3.seconds),
                ]),
              ],
            ),
            bottom: AppButton(
                text: "Proceed",
                onTap: () {
                  ref.read(carouselStateProvider.notifier).state = 1;
                  goTo(context: context, view: KycSliderView());
                })
            // .animate().fadeIn(duration: 3.seconds),
            ));
  }
}
