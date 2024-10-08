import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stryde_mobile_app/features/base_nav/wrapper/base_nav_wrapper.dart';
import 'package:stryde_mobile_app/features/garage/notifiers/garage_notifiers.dart';
import 'package:stryde_mobile_app/features/garage/providers/garage_providers.dart';
import 'package:stryde_mobile_app/features/garage/views/added_vehicle_info_view.dart';
import 'package:stryde_mobile_app/shared/app_texts.dart';
import 'package:stryde_mobile_app/theme/palette.dart';
import 'package:stryde_mobile_app/utils/app_constants.dart';
import 'package:stryde_mobile_app/utils/app_extensions.dart';
import 'package:stryde_mobile_app/utils/nav.dart';
import 'package:stryde_mobile_app/utils/option_selection_modal.dart';
import 'package:stryde_mobile_app/utils/snack_bar.dart';
import 'package:stryde_mobile_app/utils/type_defs.dart';
import 'package:stryde_mobile_app/utils/widgets/appbar.dart';
import 'package:stryde_mobile_app/utils/widgets/button.dart';
import 'package:stryde_mobile_app/utils/widgets/frosted_glass_loader.dart';
import 'package:stryde_mobile_app/utils/widgets/list_tile.dart';
import 'package:stryde_mobile_app/utils/widgets/text_input.dart';

enum SecurityQuestions { yes, no }

class BasicVehicleInformationView extends ConsumerStatefulWidget {
  const BasicVehicleInformationView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BasicVehicleInformationViewState();
}

class _BasicVehicleInformationViewState
    extends ConsumerState<BasicVehicleInformationView> {
  List<int> years = List.generate(2024 - 2006 + 1, (index) => 2006 + index);
  List<String> fuelTypes = [
    "Petrol",
    "Diesel",
    "Electric",
    "Hybrid",
    "Plug-in Hybrid Electric Vehicle (PHEV)",
    "Compressed Natural Gas (CNG)",
    "Liquefied Petroleum Gas (LPG)",
    "Ethanol (E85)",
    "Biodiesel",
    "Hydrogen Fuel Cells",
    "Methanol",
    "Synthetic Fuels",
    "Flex-Fuel"
  ];
  List<String> transmissionTypes = [
    "Automatic Transmission (AT)",
    "Continuously Variable Transmission (CVT)",
    "Manual Transmission (MT)",
    "Dual-Clutch Transmission (DCT)",
    "Semi-Automatic Transmission"
  ];

  List<String> vehicleTypes = [
    "Sedan",
    "SUV (Sport Utility Vehicle)",
    "Coupes & Convertibles",
    "Mini-Van",
    "Van",
    "Pick-up Truck",
    "Bus",
    "Hatchback",
    "Station Wagon",
    "RV (Recreational Vehicle)",
    "Limousine"
  ];
  final List<Map<String, dynamic>> vehicleFeatures = [
    {'icon': PhosphorIconsBold.bluetooth, 'label': 'Bluetooth connectivity'},
    {'icon': PhosphorIconsBold.mapTrifold, 'label': 'GPS navigation'},
    {'icon': PhosphorIconsFill.videoCamera, 'label': 'Backup camera'},
    {'icon': PhosphorIconsFill.doorOpen, 'label': 'Keyless entry'},
    {'icon': PhosphorIconsFill.monitor, 'label': 'Touchscreen display'},
    {'icon': PhosphorIconsFill.sun, 'label': 'Climate control'},
    {'icon': PhosphorIconsFill.lightbulb, 'label': 'LED lighting'},
    {'icon': PhosphorIconsFill.speedometer, 'label': 'Cruise control'},
    {'icon': PhosphorIconsFill.scales, 'label': 'Stability control'},
    {'icon': PhosphorIconsFill.seat, 'label': 'Leather seats'},
    {'icon': PhosphorIconsFill.tire, 'label': 'Tire pressure warning'},
  ];
  final List<Map<String, dynamic>> optionSelections = [
    {'icon': PhosphorIconsBold.shield, 'label': 'Comprehensive Insurance'},
    {'icon': PhosphorIconsFill.shield, 'label': 'Third Party Insurance'},
  ];
  final TextEditingController _manufacturerController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _modelYearController = TextEditingController();
  final TextEditingController _trimController = TextEditingController();
  final TextEditingController _fuelTypeController = TextEditingController();
  final TextEditingController _transmissionController = TextEditingController();
  final TextEditingController _vehicleTypeController = TextEditingController();
  final TextEditingController _insuranceTypeController =
      TextEditingController();
  final TextEditingController _insuranceNumberController =
      TextEditingController();
  final TextEditingController _insuranceCompanyController =
      TextEditingController();
  final ValueNotifier<Set<String>> _selectedFeaturesNotifier =
      ValueNotifier(<String>{});
  final ValueNotifier<bool?> _insuranceNotifier = ValueNotifier(null);
  final ValueNotifier<SecurityQuestions?> _trackerNotifier =
      ValueNotifier<SecurityQuestions?>(null);

  Future<void> pickImage() async {
    try {
      final result = await FilePicker.platform
          .pickFiles(type: FileType.image, allowMultiple: true);

      if (result == null || result.files.isEmpty) {
        return;
      }

      final fileTemp = File(result.files.single.path!);
      // Check if the provider is provided before updating the state
      fileTemp.log();
    } catch (e) {
      showFlushBanner(
          context: context,
          theMessage: "An Error Occured",
          theType: NotificationType.failure);
    }
  }

  @override
  void dispose() {
    _manufacturerController.dispose();
    _modelController.dispose();
    _modelYearController.dispose();
    _trimController.dispose();
    _fuelTypeController.dispose();
    _transmissionController.dispose();
    _vehicleTypeController.dispose();
    _insuranceTypeController.dispose();
    _insuranceNumberController.dispose();
    _insuranceCompanyController.dispose();
    _selectedFeaturesNotifier.dispose();
    _insuranceNotifier.dispose();
    _trackerNotifier.dispose();
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

  String titleFormatters(String input) {
    // Split the input string by commas and trim whitespace
    List<String> items = input.split(',').map((s) => s.trim()).toList();

    // Capitalize the first letter of each word and remove hyphens
    List<String> formattedItems = items.map((item) {
      // Remove hyphens and split into words
      List<String> words = item.replaceAll('-', ' ').split(' ');
      // Capitalize first letter of each word
      String capitalizedWords = words.map((word) {
        return word.isNotEmpty
            ? word[0].toUpperCase() + word.substring(1).toLowerCase()
            : '';
      }).join(' ');
      return capitalizedWords;
    }).toList();

    // Join the formatted items with ' and '
    return formattedItems.join(' and ');
  }

  @override
  Widget build(BuildContext context) {
    final carMakeList = ref.watch(garageCarMakeProvider);
    final kycGarageState = ref.watch(kycGarageProvider);
    return Stack(
      children: [
        Scaffold(
          appBar: customAppBar(
              overrideBackButtonAction: true,
              backFunction: () {
                ref.invalidate(garageCarMakeProvider);
              },
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
                  isTextFieldEnabled: false,
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
                          child:
                              Icon(PhosphorIconsRegular.caretDown, size: 18.h),
                        )),
                  ),
                ).tap(onTap: () {
                  showModalBottomSheet(
                      isScrollControlled: true,
                      enableDrag: true,
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (context) => Container(
                          height: 600.h,
                          width: width(context),
                          decoration: BoxDecoration(
                            color: Palette.darkBG,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25.r),
                              topRight: Radius.circular(25.r),
                            ),
                          ),
                          child: Padding(
                            padding: 20.padH,
                            child: Column(
                              children: [
                                20.sbH,
                                Container(
                                  width: 60.w,
                                  height: 4.h,
                                  decoration: ShapeDecoration(
                                    color: Palette.strydeOrange,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                  ),
                                ),
                                20.sbH,
                                SizedBox(
                                  height: 550.h,
                                  child: ListView.builder(
                                      cacheExtent: 600,
                                      shrinkWrap: true,
                                      itemCount: years.length,
                                      itemBuilder: ((context, index) {
                                        final int yearsDisplay = years[index];
                                        return OptionSelectionListTile(
                                          leadingIcon:
                                              PhosphorIconsFill.calendar,
                                          interactiveTrailing: false,
                                          titleFontSize: 16.sp,
                                          titleFontWeight: F.w6,
                                          titleLabel: yearsDisplay.toString(),
                                          onTileTap: () {
                                            _manufacturerController.clear();
                                            _modelController.clear();
                                            _trimController.clear();
                                            _vehicleTypeController.clear();
                                            _modelYearController.text =
                                                yearsDisplay.toString();
                                            ref
                                                .read(garageCarMakeProvider
                                                    .notifier)
                                                .fetchCarMakes(yearsDisplay);
                                            goBack(context);
                                          },
                                        );
                                      })),
                                ),
                              ],
                            ),
                          )));
                }),
                15.sbH,
                TextInputWidget(
                  isTextFieldEnabled: false,
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
                          child:
                              Icon(PhosphorIconsRegular.caretDown, size: 18.h),
                        )),
                  ),
                ).tap(onTap: () {
                  showModalBottomSheet(
                      isScrollControlled: true,
                      enableDrag: true,
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (context) => Container(
                          height: 600.h,
                          width: width(context),
                          decoration: BoxDecoration(
                            color: Palette.darkBG,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25.r),
                              topRight: Radius.circular(25.r),
                            ),
                          ),
                          child: Padding(
                            padding: 20.padH,
                            child: Column(
                              children: [
                                20.sbH,
                                Container(
                                  width: 60.w,
                                  height: 4.h,
                                  decoration: ShapeDecoration(
                                    color: Palette.strydeOrange,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                  ),
                                ),
                                20.sbH,
                                SizedBox(
                                  height: 550.h,
                                  child: carMakeList.isLoading
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : carMakeList.makes.isNotEmpty
                                          ? ListView.builder(
                                              cacheExtent: 600,
                                              physics:
                                                  const BouncingScrollPhysics(),
                                              itemCount:
                                                  carMakeList.makes.length,
                                              itemBuilder: (context, index) {
                                                final make = carMakeList.makes[
                                                    index]; // Get the MakeDisplay object
                                                return OptionSelectionListTile(
                                                  leadingIcon: PhosphorIconsFill
                                                      .carSimple,
                                                  interactiveTrailing: false,
                                                  titleFontSize: 16.sp,
                                                  titleFontWeight: F.w6,
                                                  titleLabel: make
                                                      .makeDisplay, // Display makeDisplay
                                                  onTileTap: () {
                                                    _modelController.clear();
                                                    _trimController.clear();
                                                    _vehicleTypeController
                                                        .clear();
                                                    _manufacturerController
                                                            .text =
                                                        make.makeDisplay;

                                                    ref
                                                        .read(
                                                            garageCarMakeProvider
                                                                .notifier)
                                                        .fetchCarModels(make
                                                            .makeId); // Call your fetchCarModels function
                                                    goBack(context);
                                                  },
                                                );
                                              },
                                            )
                                          : const Center(
                                              child: Text(
                                                  'No car makes available.'),
                                            ),
                                )
                              ],
                            ),
                          )));
                }),
                15.sbH,
                TextInputWidget(
                  isTextFieldEnabled: false,
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
                          child:
                              Icon(PhosphorIconsRegular.caretDown, size: 18.h),
                        )),
                  ),
                ).tap(onTap: () {
                  showModalBottomSheet(
                      isScrollControlled: true,
                      enableDrag: true,
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (context) => Container(
                          height: 600.h,
                          width: width(context),
                          decoration: BoxDecoration(
                            color: Palette.darkBG,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25.r),
                              topRight: Radius.circular(25.r),
                            ),
                          ),
                          child: Padding(
                            padding: 20.padH,
                            child: Column(
                              children: [
                                20.sbH,
                                Container(
                                  width: 60.w,
                                  height: 4.h,
                                  decoration: ShapeDecoration(
                                    color: Palette.strydeOrange,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                  ),
                                ),
                                20.sbH,
                                SizedBox(
                                  height: 550.h,
                                  child: carMakeList
                                          .isLoading // Use your loading state for models
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : carMakeList.models
                                              .isNotEmpty // Replace with your models list
                                          ? ListView.builder(
                                              cacheExtent: 600,
                                              physics:
                                                  const BouncingScrollPhysics(),
                                              itemCount: carMakeList.models
                                                  .length, // Use the correct list for models
                                              itemBuilder: (context, index) {
                                                final model = carMakeList
                                                        .models[
                                                    index]; // Get the ModelDisplay object
                                                return OptionSelectionListTile(
                                                  leadingIcon: PhosphorIconsFill
                                                      .carSimple,
                                                  interactiveTrailing: false,
                                                  titleFontSize: 16.sp,
                                                  titleFontWeight: F.w6,
                                                  titleLabel: model
                                                      .modelName, // Display modelName
                                                  onTileTap: () {
                                                    _trimController.clear();
                                                    _vehicleTypeController
                                                        .clear();
                                                    _modelController.text =
                                                        model.modelName;
                                                    ref
                                                        .read(
                                                            garageCarMakeProvider
                                                                .notifier)
                                                        .fetchTrimsForModel(
                                                            model.modelMakeid,
                                                            model.modelName);
                                                    goBack(context);
                                                  },
                                                );
                                              },
                                            )
                                          : const Center(
                                              child: Text(
                                                  'No car models available.'),
                                            ),
                                )
                              ],
                            ),
                          )));
                }),
                15.sbH,
                TextInputWidget(
                  isTextFieldEnabled: false,
                  hintText: "Trim",
                  controller: _trimController,
                  suffixIcon: Padding(
                    padding: 5.padH,
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          left: BorderSide(color: Palette.strydeOrange),
                        ),
                      ),
                      child: Padding(
                        padding: 10.padH,
                        child: Icon(PhosphorIconsRegular.caretDown, size: 18.h),
                      ),
                    ),
                  ),
                ).tap(onTap: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    enableDrag: true,
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) => Container(
                      height: 600.h,
                      width: width(context),
                      decoration: BoxDecoration(
                        color: Palette.darkBG,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25.r),
                          topRight: Radius.circular(25.r),
                        ),
                      ),
                      child: Padding(
                        padding: 20.padH,
                        child: Column(
                          children: [
                            20.sbH,
                            Container(
                              width: 60.w,
                              height: 4.h,
                              decoration: ShapeDecoration(
                                color: Palette.strydeOrange,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                            20.sbH,
                            SizedBox(
                              height: 550.h,
                              child: carMakeList
                                      .isLoading // Use your loading state for trims
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : carMakeList.trims
                                          .isNotEmpty // Replace with your trims list
                                      ? ListView.builder(
                                          cacheExtent: 600,
                                          physics:
                                              const BouncingScrollPhysics(),
                                          itemCount: carMakeList.trims
                                              .length, // Use the correct list for trims
                                          itemBuilder: (context, index) {
                                            final trim = carMakeList.trims[
                                                index]; // Get the Trim object
                                            return OptionSelectionListTile(
                                              leadingIcon:
                                                  PhosphorIconsFill.carSimple,
                                              interactiveTrailing: false,
                                              titleFontSize: 14.sp,
                                              titleFontWeight: F.w6,
                                              titleLabel: trim.modelTrim == ""
                                                  ? "${trim.modelName} (${trim.modelYear}) (${trim.modelBody})"
                                                  : trim.modelTrim,
                                              onTileTap: () {
                                                _vehicleTypeController.clear();
                                                _trimController.text = (trim
                                                            .modelTrim ==
                                                        ""
                                                    ? "${trim.modelName} (${trim.modelYear}) (${trim.modelBody})"
                                                    : trim.modelTrim);
                                                trim.modelBody == ""
                                                    ? _vehicleTypeController
                                                            .text =
                                                        "Not Available. Select a Vehicle Type."
                                                    : _vehicleTypeController
                                                        .text = trim.modelBody;
                                                goBack(context);
                                              },
                                            );
                                          },
                                        )
                                      : const Center(
                                          child:
                                              Text('No car trims available.'),
                                        ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
                15.sbH,
                TextInputWidget(
                  isTextFieldEnabled: false,
                  hintText: "Vehicle Type",
                  controller: _vehicleTypeController,
                  suffixIcon: Padding(
                    padding: 5.padH,
                    child: Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                left: BorderSide(color: Palette.strydeOrange))),
                        child: Padding(
                          padding: 10.padH,
                          child:
                              Icon(PhosphorIconsRegular.caretDown, size: 18.h),
                        )),
                  ),
                ).tap(onTap: () {
                  showModalBottomSheet(
                      isScrollControlled: true,
                      enableDrag: true,
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (context) => Container(
                          height: 600.h,
                          width: width(context),
                          decoration: BoxDecoration(
                            color: Palette.darkBG,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25.r),
                              topRight: Radius.circular(25.r),
                            ),
                          ),
                          child: Padding(
                            padding: 20.padH,
                            child: Column(
                              children: [
                                20.sbH,
                                Container(
                                  width: 60.w,
                                  height: 4.h,
                                  decoration: ShapeDecoration(
                                    color: Palette.strydeOrange,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                  ),
                                ),
                                20.sbH,
                                SizedBox(
                                  height: 550.h,
                                  child: ListView.builder(
                                      cacheExtent: 600,
                                      shrinkWrap: true,
                                      itemCount: vehicleTypes.length,
                                      itemBuilder: ((context, index) {
                                        final String vehicleTypeDisplay =
                                            vehicleTypes[index];
                                        return OptionSelectionListTile(
                                          leadingIcon:
                                              PhosphorIconsFill.carProfile,
                                          interactiveTrailing: false,
                                          titleFontSize: 14.sp,
                                          titleFontWeight: F.w6,
                                          titleLabel: vehicleTypeDisplay,
                                          onTileTap: () {
                                            _vehicleTypeController.text =
                                                vehicleTypeDisplay;

                                            goBack(context);
                                          },
                                        );
                                      })),
                                ),
                              ],
                            ),
                          )));
                }),
                15.sbH,
                TextInputWidget(
                  isTextFieldEnabled: false,
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
                          child:
                              Icon(PhosphorIconsRegular.caretDown, size: 18.h),
                        )),
                  ),
                ).tap(onTap: () {
                  showModalBottomSheet(
                      isScrollControlled: true,
                      enableDrag: true,
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (context) => Container(
                          height: 600.h,
                          width: width(context),
                          decoration: BoxDecoration(
                            color: Palette.darkBG,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25.r),
                              topRight: Radius.circular(25.r),
                            ),
                          ),
                          child: Padding(
                            padding: 20.padH,
                            child: Column(
                              children: [
                                20.sbH,
                                Container(
                                  width: 60.w,
                                  height: 4.h,
                                  decoration: ShapeDecoration(
                                    color: Palette.strydeOrange,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                  ),
                                ),
                                20.sbH,
                                SizedBox(
                                  height: 550.h,
                                  child: ListView.builder(
                                      cacheExtent: 600,
                                      shrinkWrap: true,
                                      itemCount: fuelTypes.length,
                                      itemBuilder: ((context, index) {
                                        final String fuelTypeDisplay =
                                            fuelTypes[index];
                                        return OptionSelectionListTile(
                                          leadingIcon:
                                              PhosphorIconsFill.gasPump,
                                          interactiveTrailing: false,
                                          titleFontSize: 14.sp,
                                          titleFontWeight: F.w6,
                                          titleLabel: fuelTypeDisplay,
                                          onTileTap: () {
                                            _fuelTypeController.text =
                                                fuelTypeDisplay;

                                            goBack(context);
                                          },
                                        );
                                      })),
                                ),
                              ],
                            ),
                          )));
                }),
                15.sbH,
                TextInputWidget(
                  isTextFieldEnabled: false,
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
                          child:
                              Icon(PhosphorIconsRegular.caretDown, size: 18.h),
                        )),
                  ),
                ).tap(onTap: () {
                  showModalBottomSheet(
                      isScrollControlled: true,
                      enableDrag: true,
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (context) => Container(
                          height: 600.h,
                          width: width(context),
                          decoration: BoxDecoration(
                            color: Palette.darkBG,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25.r),
                              topRight: Radius.circular(25.r),
                            ),
                          ),
                          child: Padding(
                            padding: 20.padH,
                            child: Column(
                              children: [
                                20.sbH,
                                Container(
                                  width: 60.w,
                                  height: 4.h,
                                  decoration: ShapeDecoration(
                                    color: Palette.strydeOrange,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                  ),
                                ),
                                20.sbH,
                                SizedBox(
                                  height: 550.h,
                                  child: ListView.builder(
                                      cacheExtent: 600,
                                      shrinkWrap: true,
                                      itemCount: transmissionTypes.length,
                                      itemBuilder: ((context, index) {
                                        final String transmissionTypeDisplay =
                                            transmissionTypes[index];
                                        return OptionSelectionListTile(
                                          leadingIcon: PhosphorIconsFill.gear,
                                          interactiveTrailing: false,
                                          titleFontSize: 14.sp,
                                          titleFontWeight: F.w6,
                                          titleLabel: transmissionTypeDisplay,
                                          onTileTap: () {
                                            _transmissionController.text =
                                                transmissionTypeDisplay;
                                            goBack(context);
                                          },
                                        );
                                      })),
                                ),
                              ],
                            ),
                          )));
                }),
                30.sbH,
                "Vehicle Images"
                    .txt16(fontW: F.w6, textAlign: TextAlign.left)
                    .alignCenterLeft(),
                5.sbH,
                AppTexts.vehicleImageAttachmentInfo
                    .txt14(textAlign: TextAlign.left)
                    .alignCenterLeft(),
                20.sbH,
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
                      "Attach Vehicle Images".txt16()
                    ],
                  ),
                ).tap(onTap: () {}),
                30.sbH,
                "Features"
                    .txt16(fontW: F.w6, textAlign: TextAlign.left)
                    .alignCenterLeft(),
                20.sbH,
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  decoration: BoxDecoration(
                      color: Palette.buttonBG,
                      borderRadius: BorderRadius.circular(15.r)),
                  child: ValueListenableBuilder<Set<String>>(
                    valueListenable: _selectedFeaturesNotifier,
                    builder: (context, selectedItems, child) {
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: vehicleFeatures.length,
                        itemBuilder: (context, index) {
                          final feature = vehicleFeatures[index];
                          final isSelected =
                              selectedItems.contains(feature['label']);

                          return ListTile(
                            contentPadding: 0.padH,
                            leading: Icon(feature['icon']),
                            title: Text(feature['label']),
                            trailing: Checkbox(
                              fillColor:
                                  WidgetStateProperty.resolveWith<Color?>(
                                (Set<WidgetState> states) {
                                  if (states.contains(WidgetState.selected)) {
                                    return Palette.strydeOrange;
                                  }
                                  return Palette.buttonBG;
                                },
                              ),
                              value: isSelected,
                              onChanged: (bool? value) {
                                final updatedSelectedItems =
                                    Set<String>.from(selectedItems);

                                if (value == true) {
                                  updatedSelectedItems.add(feature['label']);
                                } else {
                                  updatedSelectedItems.remove(feature['label']);
                                }

                                _selectedFeaturesNotifier.value =
                                    updatedSelectedItems;
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                20.sbH,
                "Security"
                    .txt16(fontW: F.w6, textAlign: TextAlign.left)
                    .alignCenterLeft(),
                5.sbH,
                AppTexts.securityDescription
                    .txt14(textAlign: TextAlign.left)
                    .alignCenterLeft(),
                15.sbH,
                ValueListenableBuilder(
                    valueListenable: _insuranceNotifier,
                    builder: (context, value, child) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // ListTile for Yes option
                          ListTile(
                            contentPadding: 10.padH,
                            title: Row(
                              children: [
                                Checkbox(
                                  fillColor:
                                      WidgetStateProperty.resolveWith<Color?>(
                                    (Set<WidgetState> states) {
                                      if (states
                                          .contains(WidgetState.selected)) {
                                        return Palette.strydeOrange;
                                      }
                                      return Palette.buttonBG;
                                    },
                                  ),
                                  value: _insuranceNotifier.value == true,
                                  onChanged: (bool? value) {
                                    if (value == true) {
                                      _insuranceNotifier.value =
                                          true; // Select Yes
                                    } else {
                                      _insuranceNotifier.value =
                                          null; // Deselect both
                                    }
                                  },
                                ),
                                5.sbW,
                                "Yes".txt16(),
                              ],
                            ),
                          ),

                          // Conditionally display a widget between Yes and No based on selection
                          if (_insuranceNotifier.value == true)
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextInputWidget(
                                  isTextFieldEnabled: false,
                                  hintText: "Insurance Type",
                                  controller: _modelYearController,
                                  suffixIcon: Padding(
                                    padding: 5.padH,
                                    child: Container(
                                        decoration: const BoxDecoration(
                                            border: Border(
                                                left: BorderSide(
                                                    color:
                                                        Palette.strydeOrange))),
                                        child: Padding(
                                          padding: 10.padH,
                                          child: Icon(
                                              PhosphorIconsRegular.caretDown,
                                              size: 18.h),
                                        )),
                                  ),
                                ).tap(onTap: () {
                                  showOptionsModal(
                                    context,
                                    selectionOptions: optionSelections
                                        .map((option) =>
                                            option['label'] as String)
                                        .toList(),
                                    leadingIcons: optionSelections
                                        .map((option) =>
                                            option['icon'] as IconData)
                                        .toList(),
                                    titleFontSize: 16.sp,
                                    titleFontColor: Colors.white,
                                    leadingIconColor: Colors.orange,
                                    modalHeight: 200
                                        .h, // Specify the height of the modal
                                    listViewHeight: 150
                                        .h, // Specify the height of the ListView
                                    onOptionTap: (index) {},
                                  );
                                }),
                                15.sbH,
                                TextInputWidget(
                                  hintText: "Insurance Number",
                                  controller: _insuranceNumberController,
                                ),
                                15.sbH,
                                TextInputWidget(
                                  hintText: "Insurance Company",
                                  controller: _insuranceCompanyController,
                                ),
                              ],
                            ),

                          // ListTile for No option
                          ListTile(
                            contentPadding: 10.padH,
                            title: Row(
                              children: [
                                Checkbox(
                                  fillColor:
                                      WidgetStateProperty.resolveWith<Color?>(
                                    (Set<WidgetState> states) {
                                      if (states
                                          .contains(WidgetState.selected)) {
                                        return Palette.strydeOrange;
                                      }
                                      return Palette.buttonBG;
                                    },
                                  ),
                                  value: _insuranceNotifier.value == false,
                                  onChanged: (bool? value) {
                                    if (value == true) {
                                      _insuranceNotifier.value =
                                          false; // Select No
                                    } else {
                                      _insuranceNotifier.value =
                                          null; // Deselect both
                                    }
                                  },
                                ),
                                5.sbW,
                                "No".txt16(),
                              ],
                            ),
                          )
                        ],
                      );
                    }),
                buildSecurityRadioSection(
                    "Do you have a tracker installed?", _trackerNotifier),
                30.sbH,
                Column(
                  children: [
                    AppButton(
                        text: "Proceed",
                        onTap: () {
                          goTo(
                              context: context,
                              view: AdditionalVehicleInformationView());
                        }),
                    20.sbH,
                    Visibility(
                      visible: kycGarageState,
                      child: AppButton(
                        text: "Skip",
                        color: Palette.buttonBG,
                        onTap: () {
                          goTo(context: context, view: BaseNavWrapper());
                        },
                      ),
                    ),
                  ],
                ),
                50.sbH
              ]),
            ],
          ),
        ),
        Positioned.fill(
          child: Visibility(
              visible: carMakeList.isLoading,
              child: FrostedGlassLoader(
                theBorderRadius: BorderRadius.zero,
                theHeight: height(context),
                theWidth: width(context),
              )),
        )
      ],
    );
  }
}
