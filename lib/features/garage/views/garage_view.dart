import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stryde_mobile_app/features/garage/providers/garage_providers.dart';
import 'package:stryde_mobile_app/features/garage/views/vin_input_view.dart';
import 'package:stryde_mobile_app/features/garage/widgets/garage_list.dart';
import 'package:stryde_mobile_app/shared/app_texts.dart';
import 'package:stryde_mobile_app/theme/palette.dart';
import 'package:stryde_mobile_app/utils/app_extensions.dart';
import 'package:stryde_mobile_app/utils/nav.dart';
import 'package:stryde_mobile_app/utils/widgets/appbar.dart';

class GarageView extends ConsumerStatefulWidget {
  const GarageView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GarageViewState();
}

class _GarageViewState extends ConsumerState<GarageView> {
  @override
  Widget build(BuildContext context) {
    final garageListPopulator = ref.watch(garageListProvider);
    return Scaffold(
      appBar: customAppBar("Garage",
          context: context,
          implyLeading: false,
          toolbarHeight: 70.h,
          color: Colors.transparent,
          isTitleCentered: true,
          actions: [
            Padding(
              padding: 10.padH,
              child: Icon(
                PhosphorIconsBold.dotsThreeVertical,
                size: 25.h,
              ),
            )
          ]),
      body: garageListPopulator == 0
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    PhosphorIconsFill.garage,
                    color: Palette.strydeOrange,
                    size: 40.h,
                  ),
                  10.sbH,
                  "Your Garage is empty".txt18(),
                  // 5.sbH,
                  // "Add a Car to get going!".txt16(),
                  // 5.sbH,
                ],
              ),
            )
          : ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: garageListPopulator,
              itemBuilder: (context, index) {
                return const GarageList(
                    vehicleBrandName: "Mercedes Benz",
                    vehicleLocation: "Lagos Ikeja",
                    vehicleModel: "GLE 63",
                    vehicleDescription: AppTexts.carDescriptionPlaceHolder,
                    fuelType: "Fuel",
                    seatNumber: 4,
                    gearType: "Auto",
                    primaryColor: Palette.strydeOrange,
                    secondaryColor: Palette.blackColor);
              }),
      floatingActionButton: Container(
        height: 60.h,
        width: 60.h,
        decoration: const BoxDecoration(
          color: Palette.strydeOrange,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Icon(
            PhosphorIconsBold.plus,
            size: 25.h,
          ),
        ),
      ).tap(onTap: () {
        goTo(context: context, view: VINInputView());
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
