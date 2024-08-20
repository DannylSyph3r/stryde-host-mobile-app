import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stryde_mobile_app/features/garage/providers/garage_providers.dart';
import 'package:stryde_mobile_app/theme/palette.dart';
import 'package:stryde_mobile_app/utils/app_extensions.dart';
import 'package:stryde_mobile_app/utils/widgets/appbar.dart';
import 'package:stryde_mobile_app/utils/widgets/button.dart';
import 'package:stryde_mobile_app/utils/widgets/text_input.dart';

class CarPricingView extends ConsumerStatefulWidget {
  const CarPricingView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CarPricingViewState();
}

class _CarPricingViewState extends ConsumerState<CarPricingView> {
  final TextEditingController _carPriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          title: "Car Rental Pricinga",
          context: context,
          toolbarHeight: 70.h,
          color: Colors.transparent,
          isTitleCentered: true),
      body: Padding(
        padding: 15.padH,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                10.sbH,
                // "Car Rental Pricing"
                //     .txt16(fontW: F.w6, textAlign: TextAlign.left)
                //     .alignCenterLeft(),
                // 10.sbH,
                "Set a daily rental price of your choosing"
                    .txt14(textAlign: TextAlign.left)
                    .alignCenterLeft(),
                30.sbH,
                TextInputWidget(
                    hintText: "00000",
                    prefix: Padding(
                      padding: 12.5.padA,
                      child: Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                right:
                                    BorderSide(color: Palette.strydeOrange))),
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
              ],
            ),
            Column(
              children: [
                AppButton(
                  text: "Proceed",
                  onTap: () {
                    ref.invalidate(kycGarageProvider);
                    
                        
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
