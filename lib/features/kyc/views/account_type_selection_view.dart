import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stryde_mobile_app/shared/app_graphics.dart';
import 'package:stryde_mobile_app/shared/app_texts.dart';
import 'package:stryde_mobile_app/theme/palette.dart';
import 'package:stryde_mobile_app/utils/app_extensions.dart';
import 'package:stryde_mobile_app/utils/widgets/appbar.dart';

class AccountTypeSelectionView extends ConsumerWidget {
  const AccountTypeSelectionView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: customAppBar("Account Type",
          context: context, implyLeading: true, toolbarHeight: 60.h),
      body: Padding(
        padding: 20.padH,
        child: Column(
          children: [
            20.sbH,
            Container(
                height: 100.h,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 9,
                        blurRadius: 18,
                        offset: const Offset(5, 10),
                      ),
                    ],
                    color: Palette.buttonBG,
                    borderRadius: BorderRadius.all(Radius.circular(21.r))),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                  child: Row(children: [
                    AppGraphics.personIcon.iconPng.myImage(fit: BoxFit.cover),
                    15.sbW,
                    Expanded(
                      child: Column(
                        children: [
                          "Individual".txt18(fontW: F.w7).alignCenterLeft(),
                          8.sbH,
                          AppTexts.individualDescription.txt14()
                        ],
                      ),
                    )
                  ]),
                )),
            30.sbH,
            Container(
                height: 100.h,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 9,
                        blurRadius: 18,
                        offset: const Offset(5, 10),
                      ),
                    ],
                    color: Palette.buttonBG,
                    borderRadius: BorderRadius.all(Radius.circular(21.r))),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                  child: Row(children: [
                    AppGraphics.enterpriseIcon.iconPng
                        .myImage(fit: BoxFit.cover),
                    15.sbW,
                    Expanded(
                      child: Column(
                        children: [
                          "Enterprise".txt18(fontW: F.w7).alignCenterLeft(),
                          8.sbH,
                          AppTexts.enterpriseDescription.txt14()
                        ],
                      ),
                    )
                  ]),
                ))
          ],
        ),
      ),
    );
  }
}
