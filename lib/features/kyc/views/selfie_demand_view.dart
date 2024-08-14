import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stryde_mobile_app/features/kyc/providers/kyc_providers.dart';
import 'package:stryde_mobile_app/features/kyc/views/confirmation_screen.dart';
import 'package:stryde_mobile_app/shared/app_graphics.dart';
import 'package:stryde_mobile_app/shared/app_texts.dart';
import 'package:stryde_mobile_app/theme/palette.dart';
import 'package:stryde_mobile_app/utils/app_extensions.dart';
import 'package:stryde_mobile_app/utils/nav.dart';
import 'package:stryde_mobile_app/utils/widgets/appbar.dart';
import 'package:stryde_mobile_app/utils/widgets/button.dart';

class SelfieDemandView extends ConsumerStatefulWidget {
  const SelfieDemandView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SelfieDemandViewState();
}

class _SelfieDemandViewState extends ConsumerState<SelfieDemandView> {

  @override
  Widget build(BuildContext context) {
    final selectedAccountType = ref.watch(accountTypeProvider);

// Determine the selfie demand description based on account type
    String selfieDescription;
    if (selectedAccountType == "Individual") {
      selfieDescription = AppTexts.selfieDemandDescription;
    } else if (selectedAccountType == "Enterprise") {
      selfieDescription = AppTexts.selfieDemandEnterpriseDescription;
    } else {
      selfieDescription = "Something is wrong";
    }

    return Scaffold(
      appBar: customAppBar(
        title: "Identification",
        context: context,
        toolbarHeight: 70.h,
        color: Colors.transparent,
        isTitleCentered: true,
      ),
      body: Padding(
        padding: 15.padH,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Padding(
                  padding: 15.padH,
                  child: Column(
                    children: [
                      10.sbH,
                      "Stryde needs a selfie from you :)"
                          .txt18(fontW: F.w6, textAlign: TextAlign.left)
                          .alignCenterLeft(),
                      20.sbH,
                      selfieDescription
                          .txt14(textAlign: TextAlign.left)
                          .alignCenterLeft(), // Use the determined description here
                      40.sbH,
                      "Follow these guidelines:"
                          .txt18(fontW: F.w6)
                          .alignCenterLeft(),
                      7.sbH,
                      "1. Use natural light".txt14().alignCenterLeft(),
                      5.sbH,
                      "2. Choose a plain backdrop".txt14().alignCenterLeft(),
                      5.sbH,
                      "4. No obstructions (hats, glasses)"
                          .txt14()
                          .alignCenterLeft(),
                      5.sbH,
                      "5. Hold the camera steady and stay still"
                          .txt14()
                          .alignCenterLeft(),
                      5.sbH,
                      "6. Keep a calm face".txt14().alignCenterLeft(),
                      60.sbH,
                      Container(
                        height: 150.h,
                        width: 150.h,
                        decoration: BoxDecoration(
                            color: Palette.strydeOrange,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.r))),
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppGraphics.camera.iconPng.myImage(),
                            10.sbH,
                            "Take Photo".txt12()
                          ],
                        )),
                      ).tap(onTap: () {}),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                AppButton(
                  text: "Proceed",
                  onTap: () {
                    goToAndReplace(
                        context: context, view: ProcessConfirmationScreen());
                  },
                ),
                30.sbH,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
