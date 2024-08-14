import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stryde_mobile_app/features/kyc/views/selfie_demand_view.dart';
import 'package:stryde_mobile_app/shared/app_graphics.dart';
import 'package:stryde_mobile_app/theme/palette.dart';
import 'package:stryde_mobile_app/utils/app_constants.dart';
import 'package:stryde_mobile_app/utils/app_extensions.dart';
import 'package:stryde_mobile_app/utils/nav.dart';
import 'package:stryde_mobile_app/utils/widgets/appbar.dart';
import 'package:stryde_mobile_app/utils/widgets/button.dart';
import 'package:stryde_mobile_app/utils/widgets/list_tile.dart';
import 'package:stryde_mobile_app/utils/widgets/text_input.dart';

class IndividualDetailsView extends ConsumerStatefulWidget {
  const IndividualDetailsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _IndividualDetailsViewState();
}

class _IndividualDetailsViewState extends ConsumerState<IndividualDetailsView> {
  final List<String> idTypes = [
    "Drivers License",
    "International Passport",
    "National Identification Number"
  ];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _idTypeController = TextEditingController();
  final TextEditingController _idNumberController = TextEditingController();
  final ValueNotifier<String> _idTypeSelection = "".notifier;

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _idTypeController.dispose();
    _idNumberController.dispose();
    _idTypeSelection.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: customAppBar(
          title: "Individual Profile",
          context: context,
          implyLeading: true,
          toolbarHeight: 60.h),
      body: ListView(
        children: [
          Padding(
            padding: 15.padH,
            child: Column(
              children: [
                30.sbH,
                Container(
                  height: 120.h,
                  decoration: BoxDecoration(
                    color: Palette.buttonBG.withOpacity(0.5),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Palette.strydeOrange.withOpacity(0.2),
                        spreadRadius: 10,
                        blurRadius: 15,
                      ),
                    ],
                  ),
                  child: Center(
                      child:
                          AppGraphics.memeoji.png.myImage(fit: BoxFit.contain)),
                ),
                50.sbH,
                TextInputWidget(
                    hintText: "Fullname", controller: _nameController),
                15.sbH,
                TextInputWidget(
                    hintText: "Full Address Line",
                    controller: _addressController),
                15.sbH,
                TextInputWidget(
                    hintText: "Email", controller: _emailController),
                15.sbH,
                TextInputWidget(
                    hintText: "Phone Number",
                    prefix: Padding(
                      padding: 12.5.padA,
                      child: Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                right:
                                    BorderSide(color: Palette.strydeOrange))),
                        height: 26.h,
                        width: 55.w,
                        child: Center(
                            child: Padding(
                          padding: 4.0.padH,
                          child: "+234".txt16().alignCenterLeft(),
                        )),
                      ),
                    ),
                    controller: _phoneController,
                    keyboardType: TextInputType.number),
                15.sbH,
                TextInputWidget(
                  isTextFieldEnabled: false,
                  hintText: "Identification Type",
                  controller: _idTypeController,
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
                          height: 280.h,
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
                                  height: 200.h,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: idTypes.length,
                                      itemBuilder: ((context, index) {
                                        final String idTypesDisplay =
                                            idTypes[index];
                                        return OptionSelectionListTile(
                                          interactiveTrailing: false,
                                          titleFontSize: 14.sp,
                                          titleLabel: idTypesDisplay,
                                          onTileTap: () {
                                            _idTypeController.text =
                                                idTypesDisplay;
                                            goBack(context);
                                            _idTypeSelection.value = idTypesDisplay;
                                          },
                                        );
                                      })),
                                ),
                              ],
                            ),
                          )));
                }),
                15.sbH,
                _idTypeSelection.sync(
                  builder: (context, isVisible, child) {
                    return Visibility(
                      visible: isVisible != "",
                      child: Column(
                        children: [
                          TextInputWidget(
                              hintText: "Identification Number",
                              controller: _idNumberController),
                          15.sbH,
                        ],
                      ),
                    );
                  }
                ),
                Container(
                  width: double.infinity,
                  height: 53.h,
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
                      "Attach ID Document".txt16()
                    ],
                  ),
                ).tap(onTap: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    enableDrag: true,
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) => Wrap(
                      children: [],
                    ),
                  );
                }),
                50.sbH,
                AppButton(
                    text: "Continue",
                    onTap: () {
                      goTo(context: context, view: SelfieDemandView());
                    }),
                30.sbH
              ],
            ),
          ),
        ],
      ),
    );
  }
}
