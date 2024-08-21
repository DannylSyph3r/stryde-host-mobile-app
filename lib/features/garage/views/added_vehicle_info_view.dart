import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stryde_mobile_app/features/garage/views/garage_confirmation_screen.dart';
import 'package:stryde_mobile_app/theme/palette.dart';
import 'package:stryde_mobile_app/utils/app_extensions.dart';
import 'package:stryde_mobile_app/utils/nav.dart';
import 'package:stryde_mobile_app/utils/option_selection_modal.dart';
import 'package:stryde_mobile_app/utils/widgets/appbar.dart';
import 'package:stryde_mobile_app/utils/widgets/button.dart';
import 'package:stryde_mobile_app/utils/widgets/text_input.dart';

enum SecurityQuestions { yes, no }

class AdditionalVehicleInformationView extends ConsumerStatefulWidget {
  const AdditionalVehicleInformationView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AdditionalVehicleInformationViewState();
}

class _AdditionalVehicleInformationViewState
    extends ConsumerState<AdditionalVehicleInformationView> {
  List<String> engineTypes = [
    "Petrol (Gasoline)",
    "V4 Petrol Engine",
    "V6 Petrol Engine",
    "V8 Petrol Engine",
    "V10 Petrol Engine",
    "V12 Petrol Engine",
    "V16 Petrol Engine",
    "Naturally Aspirated Engine",
    "Turbocharged Petrol Engine",
    "Supercharged Petrol Engine",
    "Direct Injection Engine",
    "Inline-4 Petrol Engine (I4)",
    "Inline-6 Petrol Engine (I6)",
    "Rotary Engine (Wankel Engine)",
    "Atkinson Cycle Engine",
    "Miller Cycle Engine",
    "Turbocharged Inline Engines (I3, I5)",
    "Variable Valve Timing (VVT) Engine",
    "Flex-Fuel Petrol Engine (E85 compatible)",
    "Diesel",
    "V4 Diesel Engine",
    "V6 Diesel Engine",
    "V8 Diesel Engine",
    "V10 Diesel Engine",
    "V12 Diesel Engine",
    "Inline-4 Diesel Engine (I4)",
    "Inline-6 Diesel Engine (I6)",
    "Naturally Aspirated Diesel Engine",
    "Turbocharged Diesel Engine",
    "Common Rail Diesel Engine",
    "Two-Stroke Diesel Engine",
    "Four-Stroke Diesel Engine",
    "Dual-Fuel Diesel Engine",
    "Turbocharged Inline Diesel Engines (I3, I5)",
    "Direct Injection Diesel Engine",
    "Electric",
    "Battery Electric Vehicle (BEV) Motor",
    "Hybrid Electric Vehicle (HEV) Motor",
    "Plug-in Hybrid Electric Vehicle (PHEV) Motor",
    "Fuel Cell Electric Vehicle (FCEV) Motor",
    "Extended Range Electric Vehicle (EREV) Motor",
    "CNG Engine",
    "CNG Dual-Fuel Engine",
    "LPG Engine",
    "LPG Dual-Fuel Engine",
    "Flex-Fuel Diesel Engine (E85 compatible)"
  ];

  final TextEditingController _primaryExteriorColorController =
      TextEditingController();
  final TextEditingController _secondaryExteriorColorController =
      TextEditingController();
  final TextEditingController _primaryInteriorColorController =
      TextEditingController();
  final TextEditingController _secondaryInteriorColorController =
      TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _seatNumberController = TextEditingController();
  final TextEditingController _engineTypeController = TextEditingController();
  final TextEditingController _tireSizeController = TextEditingController();
  final TextEditingController _licensePlateController = TextEditingController();
  final TextEditingController _vinNumberController = TextEditingController();
  final TextEditingController _carPriceController = TextEditingController();
  final ValueNotifier<SecurityQuestions?> _tintedWindowsNotifier =
      ValueNotifier<SecurityQuestions?>(null);
  final ValueNotifier<SecurityQuestions?> _vehicleOwnershipNotifier =
      ValueNotifier<SecurityQuestions?>(null);

  @override
  void dispose() {
    _primaryExteriorColorController.dispose();
    _secondaryExteriorColorController.dispose();
    _primaryInteriorColorController.dispose();
    _secondaryInteriorColorController.dispose();
    _descriptionController.dispose();
    _seatNumberController.dispose();
    _engineTypeController.dispose();
    _tireSizeController.dispose();
    _licensePlateController.dispose();
    _vinNumberController.dispose();
    _tintedWindowsNotifier.dispose();
    _vehicleOwnershipNotifier.dispose();
    super.dispose();
  }

  Widget buildSecurityRadioSection(
      String title, ValueNotifier<SecurityQuestions?> notifier) {
    return Padding(
      padding: 10.padV,
      child: Container(
          height: 80.h,
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          decoration: BoxDecoration(
              color: Palette.buttonBG,
              borderRadius: BorderRadius.all(Radius.circular(15.r)),
              border: Border.all(color: Palette.greyColor)),
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
            "Additional Information".txt16(fontW: F.w6).alignCenterLeft(),
            20.sbH,
            TextInputWidget(
              hintText: "Primary Exterior Colour",
              controller: _primaryExteriorColorController,
              // suffixIcon: Padding(
              //   padding: 5.padH,
              //   child: Container(
              //       decoration: const BoxDecoration(
              //           border: Border(
              //               left: BorderSide(color: Palette.strydeOrange))),
              //       child: Padding(
              //         padding: 10.padH,
              //         child: Icon(PhosphorIconsRegular.caretDown, size: 18.h),
              //       )),
              // ),
            ),
            15.sbH,
            TextInputWidget(
              hintText: "Secondary Exterior Colour",
              controller: _secondaryExteriorColorController,
              // suffixIcon: Padding(
              //   padding: 5.padH,
              //   child: Container(
              //       decoration: const BoxDecoration(
              //           border: Border(
              //               left: BorderSide(color: Palette.strydeOrange))),
              //       child: Padding(
              //         padding: 10.padH,
              //         child: Icon(PhosphorIconsRegular.caretDown, size: 18.h),
              //       )),
              // ),
            ),
            15.sbH,
            TextInputWidget(
              hintText: "Primary Interior Colour",
              controller: _primaryInteriorColorController,
              // suffixIcon: Padding(
              //   padding: 5.padH,
              //   child: Container(
              //       decoration: const BoxDecoration(
              //           border: Border(
              //               left: BorderSide(color: Palette.strydeOrange))),
              //       child: Padding(
              //         padding: 10.padH,
              //         child: Icon(PhosphorIconsRegular.caretDown, size: 18.h),
              //       )),
              // ),
            ),
            15.sbH,
            TextInputWidget(
              hintText: "Secondary Interior Colour",
              controller: _secondaryInteriorColorController,
              // suffixIcon: Padding(
              //   padding: 5.padH,
              //   child: Container(
              //       decoration: const BoxDecoration(
              //           border: Border(
              //               left: BorderSide(color: Palette.strydeOrange))),
              //       child: Padding(
              //         padding: 10.padH,
              //         child: Icon(PhosphorIconsRegular.caretDown, size: 18.h),
              //       )),
              // ),
            ),
            15.sbH,
            TextInputWidget(
              height: 200.h,
              maxLines: 20,
              maxLength: 1500,
              keyboardType: TextInputType.multiline,
              hintText:
                  "Description of Exterior and interior (include any modifications)",
              contentPadding:
                  EdgeInsets.only(left: 15.w, right: 15.w, bottom: 20.w),
              controller: _descriptionController,
            ),
            25.sbH,
            TextInputWidget(
              hintText: "Number of Seats",
              controller: _seatNumberController,
              keyboardType: TextInputType.number,
            ),
            15.sbH,
            TextInputWidget(
              isTextFieldEnabled: false,
              hintText: "Engine Type",
              controller: _engineTypeController,
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
            ).tap(onTap: () {
              showOptionsModal(
                context,
                selectionOptions: engineTypes,
                leadingIcons: List.generate(
                  engineTypes.length,
                  (index) => PhosphorIconsFill.engine,
                ),
                titleFontSize: 14.sp,
                onOptionTap: (index) {
                  final selectedEngineType = engineTypes[index];
                  _engineTypeController.text = selectedEngineType;
                  goBack(context);
                },
                modalHeight: 600.h,
                listViewHeight: 550.h,
              );
            }),
            15.sbH,
            TextInputWidget(
              hintText: "Tire Size",
              controller: _tireSizeController,
              keyboardType: TextInputType.number,
            ),
            5.sbH,
            buildSecurityRadioSection(
                "Do you have any tinted windows?", _tintedWindowsNotifier),
            30.sbH,
            "Vehicle Identification Details"
                .txt16(fontW: F.w6, textAlign: TextAlign.left)
                .alignCenterLeft(),
            5.sbH,
            "This information is needed to easily identify your vehicle"
                .txt14(textAlign: TextAlign.left)
                .alignCenterLeft(),
            20.sbH,
            buildSecurityRadioSection("Are you the owner of this vehicle?",
                _vehicleOwnershipNotifier),
            8.sbH,
            TextInputWidget(
              hintText: "License Plate Number",
              controller: _licensePlateController,
            ),
            15.sbH,
            TextInputWidget(
              hintText: "Vehicle Identification / Chassis Number",
              controller: _vinNumberController,
            ),
            30.sbH,
            "Rental Price"
                .txt16(fontW: F.w6, textAlign: TextAlign.left)
                .alignCenterLeft(),
            20.sbH,
            TextInputWidget(
                hintText: "50,000 - 100,000",
                prefix: Padding(
                  padding: 12.5.padA,
                  child: Container(
                    decoration: const BoxDecoration(
                        border: Border(
                            right: BorderSide(color: Palette.strydeOrange))),
                    height: 26.h,
                    width: 35.w,
                    child: Center(
                        child: Padding(
                      padding: 4.0.padH,
                      child: "₦".txt18(fontW: F.w6).alignCenterLeft(),
                    )),
                  ),
                ),
                controller: _carPriceController,
                keyboardType: TextInputType.number),
            30.sbH,
            AppButton(
                text: "Proceed",
                onTap: () {
                  goToAndReplace(
                      context: context, view: GarageConfirmationScreen());
                }),
            50.sbH
          ]),
        ],
      ),
    );
  }
}
