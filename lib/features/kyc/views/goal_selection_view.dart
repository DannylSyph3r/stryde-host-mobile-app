import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stryde_mobile_app/features/kyc/providers/kyc_providers.dart';
import 'package:stryde_mobile_app/features/kyc/views/kyc_slider.dart';
import 'package:stryde_mobile_app/shared/app_texts.dart';
import 'package:stryde_mobile_app/theme/palette.dart';
import 'package:stryde_mobile_app/utils/app_extensions.dart';
import 'package:stryde_mobile_app/utils/nav.dart';
import 'package:stryde_mobile_app/utils/widgets/appbar.dart';
import 'package:stryde_mobile_app/utils/widgets/button.dart';

// Enums for different sections
enum FinancialObjectives { option1, option2, option3 }

enum RentalFrequency { option1, option2, option3, option4 }

enum FinancialGoals { option1, option2, option3 }

enum ServiceTypes { option1, option2 }

enum MinimumTripDuration { option1, option2, option3 }

enum MaximumTripDuration { option1, option2, option3 }

enum DriveOptions { option1, option2, option3 }

class GoalSelectionView extends ConsumerStatefulWidget {
  const GoalSelectionView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _GoalSelectionViewState();
}

class _GoalSelectionViewState extends ConsumerState<GoalSelectionView> {
  final ValueNotifier<FinancialObjectives?> _financialObjectivesNotifier =
      ValueNotifier<FinancialObjectives?>(null);
  final ValueNotifier<RentalFrequency?> _rentalFrequencyNotifier =
      ValueNotifier<RentalFrequency?>(null);
  final ValueNotifier<FinancialGoals?> _financialGoalsNotifier =
      ValueNotifier<FinancialGoals?>(null);
  final ValueNotifier<ServiceTypes?> _serviceTypesNotifier =
      ValueNotifier<ServiceTypes?>(null);
  final ValueNotifier<MinimumTripDuration?> _minimumTripDurationNotifier =
      ValueNotifier<MinimumTripDuration?>(null);
  final ValueNotifier<MaximumTripDuration?> _maximumTripDurationNotifier =
      ValueNotifier<MaximumTripDuration?>(null);
  final ValueNotifier<DriveOptions?> _driveOptionsNotifier =
      ValueNotifier<DriveOptions?>(null);

  @override
  void dispose() {
    _financialObjectivesNotifier.dispose();
    _rentalFrequencyNotifier.dispose();
    _financialGoalsNotifier.dispose();
    _serviceTypesNotifier.dispose();
    _minimumTripDurationNotifier.dispose();
    _maximumTripDurationNotifier.dispose();
    _driveOptionsNotifier.dispose();
    super.dispose();
  }

  final Map<FinancialObjectives, String> financialObjectivesTexts = {
    FinancialObjectives.option1: AppTexts.financialObjectivesOption1,
    FinancialObjectives.option2: AppTexts.financialObjectivesOption2,
    FinancialObjectives.option3: AppTexts.financialObjectivesOption3,
  };

  final Map<RentalFrequency, String> rentalFrequencyTexts = {
    RentalFrequency.option1: AppTexts.rentalFrequencyOption1,
    RentalFrequency.option2: AppTexts.rentalFrequencyOption2,
    RentalFrequency.option3: AppTexts.rentalFrequencyOption3,
    RentalFrequency.option4: AppTexts.rentalFrequencyOption4,
  };

  final Map<FinancialGoals, String> financialGoalsTexts = {
    FinancialGoals.option1: AppTexts.financialGoalsOption1,
    FinancialGoals.option2: AppTexts.financialGoalsOption2,
    FinancialGoals.option3: AppTexts.financialGoalsOption3,
  };

  final Map<ServiceTypes, String> serviceTypesTexts = {
    ServiceTypes.option1: AppTexts.serviceTypesOption1,
    ServiceTypes.option2: AppTexts.serviceTypesOption2,
  };

  final Map<MinimumTripDuration, String> minimumTripDurationTexts = {
    MinimumTripDuration.option1: AppTexts.minimumTripDurationOption1,
    MinimumTripDuration.option2: AppTexts.minimumTripDurationOption2,
    MinimumTripDuration.option3: AppTexts.minimumTripDurationOption3,
  };

  final Map<MaximumTripDuration, String> maximumTripDurationTexts = {
    MaximumTripDuration.option1: AppTexts.maximumTripDurationOption1,
    MaximumTripDuration.option2: AppTexts.maximumTripDurationOption2,
    MaximumTripDuration.option3: AppTexts.maximumTripDurationOption3,
  };

  final Map<DriveOptions, String> driveOptionsTexts = {
    DriveOptions.option1: AppTexts.driveOptions1,
    DriveOptions.option2: AppTexts.driveOptions2,
    DriveOptions.option3: AppTexts.driveOptions3,
  };

  Widget buildRadioSection<T>(String title, ValueNotifier<T?> notifier,
      List<T> options, Map<T, String> optionTexts) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      child: Container(
        padding: 20.padV,
        decoration: BoxDecoration(
            color: Palette.buttonBG,
            borderRadius: BorderRadius.all(Radius.circular(15.r))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: 20.padH,
              child: title.txt(size: 15.sp, fontW: F.w6),
            ),
            for (var option in options)
              SizedBox(
                height: 40.h,
                child: ListTile(
                  contentPadding: 20.padH,
                  title: optionTexts[option]!.txt(size: 12.5.sp),
                  trailing: ValueListenableBuilder<T?>(
                    valueListenable: notifier,
                    builder: (context, value, child) {
                      return Radio<T>(
                        activeColor: Palette.strydeOrange,
                        value: option,
                        groupValue: value,
                        onChanged: (T? newValue) {
                          notifier.value = newValue;
                        },
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("",
          context: context, implyLeading: true, toolbarHeight: 60.h),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            10.sbH,
            Padding(
              padding: 20.padH,
              child: "Set your Goals!".txt16(fontW: F.w6).alignCenterLeft(),
            ),
            10.sbH,
            buildRadioSection(
              AppTexts.financialObjectivesHeaderText,
              _financialObjectivesNotifier,
              FinancialObjectives.values,
              financialObjectivesTexts,
            ),
            buildRadioSection(
              AppTexts.rentalFrequencyHeaderText,
              _rentalFrequencyNotifier,
              RentalFrequency.values,
              rentalFrequencyTexts,
            ),
            buildRadioSection(
              AppTexts.financialGoalsHeaderText,
              _financialGoalsNotifier,
              FinancialGoals.values,
              financialGoalsTexts,
            ),
            buildRadioSection(
              AppTexts.serviceTypesHeaderText,
              _serviceTypesNotifier,
              ServiceTypes.values,
              serviceTypesTexts,
            ),
            buildRadioSection(
              AppTexts.minimumTripHeaderText,
              _minimumTripDurationNotifier,
              MinimumTripDuration.values,
              minimumTripDurationTexts,
            ),
            buildRadioSection(
              AppTexts.maximumTripHeaderText,
              _maximumTripDurationNotifier,
              MaximumTripDuration.values,
              maximumTripDurationTexts,
            ),
            buildRadioSection(
              AppTexts.driveOptionsHeaderText,
              _driveOptionsNotifier,
              DriveOptions.values,
              driveOptionsTexts,
            ),
            30.sbH,
            AppButton(
                text: "Proceed",
                onTap: () {
                  ref.read(carouselStateProvider.notifier).state = 2;
                  goTo(context: context, view: KycSliderView());
                }),
            50.sbH,
          ],
        ),
      ),
    );
  }
}
