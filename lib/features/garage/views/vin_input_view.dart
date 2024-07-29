import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stryde_mobile_app/features/base_nav/wrapper/base_nav_wrapper.dart';
import 'package:stryde_mobile_app/features/garage/views/car_specfications_input_view.dart';
import 'package:stryde_mobile_app/theme/palette.dart';
import 'package:stryde_mobile_app/utils/app_extensions.dart';
import 'package:stryde_mobile_app/utils/nav.dart';
import 'package:stryde_mobile_app/utils/widgets/appbar.dart';
import 'package:stryde_mobile_app/utils/widgets/button.dart';
import 'package:stryde_mobile_app/utils/widgets/text_input.dart';

class VINInputView extends ConsumerStatefulWidget {
  const VINInputView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VINInputViewState();
}

class _VINInputViewState extends ConsumerState<VINInputView> {
  final TextEditingController _vinController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("Car Details",
          context: context,
          toolbarHeight: 70.h,
          color: Colors.transparent,
          isTitleCentered: true),
      body: Padding(
        padding: 20.padH,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                10.sbH,
                TextInputWidget(
                    hintText: "VIN Number", controller: _vinController),
                30.sbH,
                "Cant Find VIN?".txt18(fontW: F.w6).alignCenterLeft(),
                7.sbH,
                "Check the various places:".txt14().alignCenterLeft(),
                5.sbH,
                "1. Driver's door".txt14().alignCenterLeft(),
                5.sbH,
                "2. Driver's side-dashboard".txt14().alignCenterLeft(),
                5.sbH,
                "3. Documentation".txt14().alignCenterLeft()
              ],
            ),
            Column(
              children: [
                AppButton(
                    text: "Proceed",
                    onTap: () {
                      goTo(
                          context: context, view: CarSpecificationsInputView());
                    }),
                20.sbH,
                AppButton(
                    text: "Skip",
                    color: Palette.buttonBG,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0.r),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Palette.buttonBG,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.r))),
                              height: 220.h,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.w, vertical: 5.h),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    10.sbH,
                                    Container(
                                      height: 5.h,
                                      width: 100.w,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.r),
                                        color: Palette.strydeOrange,
                                      ),
                                    ),
                                    20.sbH,
                                    Row(
                                      children: [
                                        Icon(
                                          PhosphorIconsBold.warningOctagon,
                                          size: 18.h,
                                          color: Palette.strydeOrange,
                                        ).alignCenterLeft(),
                                        5.sbW,
                                        "Note".txt18(fontW: F.w6)
                                      ],
                                    ),
                                    20.sbH,
                                    "Are you sure you want to skip this registration process?"
                                        .txt14(),
                                    10.sbH,
                                    "You can still add cars to your garage on the main app."
                                        .txt14(),
                                    20.sbH,
                                    Padding(
                                      padding: 20.padH,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          "Yes".txt18(
                                              fontW: F.w6,
                                              color: Palette.strydeOrange).tap(onTap: (){
                                                goToAndReplace(context: context, view: BaseNavWrapper());
                                              }),
                                          30.sbW,
                                          "No".txt18(
                                              fontW: F.w6,
                                              color: Palette.strydeOrange).tap(onTap: (){
                                                goBack(context);
                                              })
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }),
                50.sbH
              ],
            )
          ],
        ),
      ),
    );
  }
}
