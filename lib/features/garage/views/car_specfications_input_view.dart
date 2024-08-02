import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stryde_mobile_app/features/garage/providers/garage_providers.dart';
import 'package:stryde_mobile_app/features/garage/views/garage_confirmation_screem.dart';
import 'package:stryde_mobile_app/features/kyc/widgets/doc_picker_modalsheet.dart';
import 'package:stryde_mobile_app/shared/app_texts.dart';
import 'package:stryde_mobile_app/theme/palette.dart';
import 'package:stryde_mobile_app/utils/app_extensions.dart';
import 'package:stryde_mobile_app/utils/nav.dart';
import 'package:stryde_mobile_app/utils/widgets/appbar.dart';
import 'package:stryde_mobile_app/utils/widgets/button.dart';
import 'package:stryde_mobile_app/utils/widgets/text_input.dart';

enum SecurityQuestions { yes, no }

class CarSpecificationsInputView extends ConsumerStatefulWidget {
  const CarSpecificationsInputView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CarSpecificationsInputViewState();
}

class _CarSpecificationsInputViewState
    extends ConsumerState<CarSpecificationsInputView> {
  final TextEditingController _manufacturerController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _modelYearController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  final TextEditingController _fuelTypeController = TextEditingController();
  final TextEditingController _transmissionController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _licensePlateController = TextEditingController();
  final ValueNotifier<SecurityQuestions?> _insuranceNotifier =
      ValueNotifier<SecurityQuestions?>(null);
  final ValueNotifier<SecurityQuestions?> _trackerNotifier =
      ValueNotifier<SecurityQuestions?>(null);

  Widget buildSecurityRadioSection(
      String title, ValueNotifier<SecurityQuestions?> notifier) {
    return Padding(
      padding: 10.padV,
      child: Container(
          height: 80.h,
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          decoration: BoxDecoration(
              color: Palette.buttonBG,
              borderRadius: BorderRadius.all(Radius.circular(15.r))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    title
                        .txt(
                            size: 13.sp, textAlign: TextAlign.left, fontW: F.w6)
                        .alignCenterLeft(),
                  ],
                ),
              ),
              10.sbW,
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var option in SecurityQuestions.values) ...[
                    SizedBox(
                      height: 20.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          option == SecurityQuestions.yes
                              ? Row(
                                  children: [
                                    'Yes'.txt(size: 13.sp, fontW: F.w6),
                                  ],
                                )
                              : Row(
                                  children: [
                                    'No'.txt12(size: 13.sp, fontW: F.w6),
                                    2.sbW
                                  ],
                                ),
                          ValueListenableBuilder<SecurityQuestions?>(
                            valueListenable: notifier,
                            builder: (context, value, child) {
                              return Radio<SecurityQuestions>(
                                activeColor: Palette.strydeOrange,
                                value: option,
                                groupValue: value,
                                onChanged: (SecurityQuestions? newValue) {
                                  notifier.value = newValue;
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    7.sbH, // Add vertical space between rows
                  ],
                ],
              )
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: "Car Details",
          context: context,
          toolbarHeight: 70.h,
          color: Colors.transparent,
          isTitleCentered: true),
      body: ListView(
        padding: 15.padH,
        children: [
          Column(children: [
            10.sbH,
            "Car Specifications".txt16(fontW: F.w6).alignCenterLeft(),
            20.sbH,
            TextInputWidget(
              hintText: "Manufacturer",
              controller: _manufacturerController,
              suffixIcon: Padding(
                padding: 5.padH,
                child: Container(
                    decoration: const BoxDecoration(
                        border: Border(
                            left: BorderSide(color: Palette.strydeOrange))),
                    child: Padding(
                      padding: 10.padH,
                      child: Icon(PhosphorIconsRegular.caretDown, size: 18.h),
                    )),
              ),
            ),
            15.sbH,
            TextInputWidget(
              hintText: "Model",
              controller: _modelController,
              suffixIcon: Padding(
                padding: 5.padH,
                child: Container(
                    decoration: const BoxDecoration(
                        border: Border(
                            left: BorderSide(color: Palette.strydeOrange))),
                    child: Padding(
                      padding: 10.padH,
                      child: Icon(PhosphorIconsRegular.caretDown, size: 18.h),
                    )),
              ),
            ),
            15.sbH,
            TextInputWidget(
              hintText: "Year",
              controller: _modelYearController,
              suffixIcon: Padding(
                padding: 5.padH,
                child: Container(
                    decoration: const BoxDecoration(
                        border: Border(
                            left: BorderSide(color: Palette.strydeOrange))),
                    child: Padding(
                      padding: 10.padH,
                      child: Icon(PhosphorIconsRegular.caretDown, size: 18.h),
                    )),
              ),
            ),
            15.sbH,
            TextInputWidget(
              hintText: "Fuel Type",
              controller: _fuelTypeController,
              suffixIcon: Padding(
                padding: 5.padH,
                child: Container(
                    decoration: const BoxDecoration(
                        border: Border(
                            left: BorderSide(color: Palette.strydeOrange))),
                    child: Padding(
                      padding: 10.padH,
                      child: Icon(PhosphorIconsRegular.caretDown, size: 18.h),
                    )),
              ),
            ),
            15.sbH,
            TextInputWidget(
              hintText: "Colour",
              controller: _colorController,
              suffixIcon: Padding(
                padding: 5.padH,
                child: Container(
                    decoration: const BoxDecoration(
                        border: Border(
                            left: BorderSide(color: Palette.strydeOrange))),
                    child: Padding(
                      padding: 10.padH,
                      child: Icon(PhosphorIconsRegular.caretDown, size: 18.h),
                    )),
              ),
            ),
            15.sbH,
            TextInputWidget(
              hintText: "Transmission",
              controller: _transmissionController,
              suffixIcon: Padding(
                padding: 5.padH,
                child: Container(
                    decoration: const BoxDecoration(
                        border: Border(
                            left: BorderSide(color: Palette.strydeOrange))),
                    child: Padding(
                      padding: 10.padH,
                      child: Icon(PhosphorIconsRegular.caretDown, size: 18.h),
                    )),
              ),
            ),
            15.sbH,
            TextInputWidget(
              hintText: "Short Description",
              controller: _descriptionController,
            ),
            15.sbH,
            TextInputWidget(
              hintText: "License Plate",
              controller: _licensePlateController,
            ),
            15.sbH,
            Container(
              width: double.infinity,
              height: 50.h,
              decoration: BoxDecoration(
                  color: Palette.buttonBG,
                  borderRadius: BorderRadius.all(Radius.circular(15.r)),
                  border: Border.all(color: Palette.greyColor, width: 1)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    PhosphorIconsRegular.paperclip,
                    color: Palette.strydeOrange,
                  ),
                  5.sbW,
                  "Attach Vehicle Image".txt16()
                ],
              ),
            ).tap(onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => DocPickerModalBottomSheet(
                  onTakeDocPicture: () {
                    goBack(context);
                  },
                ),
              );
            }),
            30.sbH,
            "Security"
                .txt16(fontW: F.w6, textAlign: TextAlign.left)
                .alignCenterLeft(),
            5.sbH,
            AppTexts.securityDescription
                .txt14(textAlign: TextAlign.left)
                .alignCenterLeft(),
            15.sbH,
            buildSecurityRadioSection(
                "Do you have comprehensive Insurance?", _insuranceNotifier),
            buildSecurityRadioSection(
                "Do you have a tracker installed?", _trackerNotifier),
            30.sbH,
            AppButton(
                text: "Proceed",
                onTap: () {
                  ref.invalidate(kycGarageProvider);
                  goTo(context: context, view: GarageConfirmationScreen());
                }),
            50.sbH
          ]),
        ],
      ),
    );
  }
}
