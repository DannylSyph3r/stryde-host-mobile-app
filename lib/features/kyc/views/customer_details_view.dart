import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stryde_mobile_app/features/kyc/views/confirmation_screen.dart';
import 'package:stryde_mobile_app/features/kyc/widgets/doc_picker_modalsheet.dart';
import 'package:stryde_mobile_app/features/kyc/widgets/id_selection_model.dart';
import 'package:stryde_mobile_app/shared/app_graphics.dart';
import 'package:stryde_mobile_app/theme/palette.dart';
import 'package:stryde_mobile_app/utils/app_extensions.dart';
import 'package:stryde_mobile_app/utils/nav.dart';
import 'package:stryde_mobile_app/utils/widgets/appbar.dart';
import 'package:stryde_mobile_app/utils/widgets/button.dart';
import 'package:stryde_mobile_app/utils/widgets/text_input.dart';

class CustomerDetailsView extends ConsumerStatefulWidget {
  const CustomerDetailsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CustomerDetailsViewState();
}

class _CustomerDetailsViewState extends ConsumerState<CustomerDetailsView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: customAppBar("Profile",
          context: context, implyLeading: true, toolbarHeight: 60.h),
      body: ListView(
        children: [
          Padding(
            padding: 20.padH,
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
                    hintText: "Fullname / Company Name",
                    controller: _nameController),
                15.sbH,
                TextInputWidget(
                    hintText: "Full Address", controller: _addressController),
                15.sbH,
                TextInputWidget(
                    hintText: "Email", controller: _emailController),
                15.sbH,
                TextInputWidget(
                    hintText: "Phone Number", controller: _phoneController),
                15.sbH,
                TextInputWidget(
                  isTextFieldEnabled: false,
                  hintText: "Identification Type",
                  controller: _phoneController,
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
                    builder: (context) => const Wrap(
                      children: [IDSelectionBottomsheet()],
                    ),
                  );
                }),
                15.sbH,
                Container(
                  width: double.infinity,
                  height: 55.h,
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
                      children: [
                        DocPickerModalBottomSheet(onTakeDocPicture: () {
                          goBack(context);
                        })
                      ],
                    ),
                  );
                }),
                50.sbH,
                AppButton(
                    text: "Continue",
                    onTap: () {
                      goTo(context: context, view: ProcessConfirmationScreen());
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
