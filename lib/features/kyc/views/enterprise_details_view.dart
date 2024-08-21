import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stryde_mobile_app/features/kyc/views/selfie_demand_view.dart';
import 'package:stryde_mobile_app/shared/app_graphics.dart';
import 'package:stryde_mobile_app/theme/palette.dart';
import 'package:stryde_mobile_app/utils/app_extensions.dart';
import 'package:stryde_mobile_app/utils/nav.dart';
import 'package:stryde_mobile_app/utils/option_selection_modal.dart';
import 'package:stryde_mobile_app/utils/widgets/appbar.dart';
import 'package:stryde_mobile_app/utils/widgets/button.dart';
import 'package:stryde_mobile_app/utils/widgets/text_input.dart';

class EnterpriseDetailsView extends ConsumerStatefulWidget {
  const EnterpriseDetailsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EnterpriseDetailsViewState();
}

class _EnterpriseDetailsViewState extends ConsumerState<EnterpriseDetailsView> {
  final List<String> idTypes = [
    "Drivers License",
    "International Passport",
    "National Identification Number"
  ];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _cacController = TextEditingController();
  final TextEditingController _idTypeController = TextEditingController();
  final TextEditingController _idNumberController = TextEditingController();
  final ValueNotifier<String> _idTypeSelection = "".notifier;

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _cacController.dispose();
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
          title: "Enterprise Profile",
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
                    hintText: "Full Company/Business Name",
                    controller: _nameController),
                15.sbH,
                TextInputWidget(
                    hintText: "Company/Business Address",
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
                    hintText: "CAC Number", controller: _cacController),
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
                  showOptionsModal(
                    context,
                    selectionOptions: idTypes,
                    leadingIcons: List.generate(
                      idTypes.length,
                      (index) => PhosphorIconsFill.identificationCard,
                    ),
                    titleFontSize: 14.sp,
                    onOptionTap: (index) {
                      final selectedIdType = idTypes[index];
                      _idTypeController.text = selectedIdType;
                      goBack(context);
                    },
                    modalHeight: 270.h,
                    listViewHeight: 200.h,
                  );
                }),
                15.sbH,
                _idTypeSelection.sync(builder: (context, isVisible, child) {
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
                }),
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
                ).tap(onTap: () {}),
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
