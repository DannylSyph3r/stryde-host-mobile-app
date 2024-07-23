import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stryde_mobile_app/shared/app_graphics.dart';
import 'package:stryde_mobile_app/shared/app_texts.dart';
import 'package:stryde_mobile_app/theme/palette.dart';
import 'package:stryde_mobile_app/utils/app_constants.dart';
import 'package:stryde_mobile_app/utils/app_extensions.dart';
import 'package:stryde_mobile_app/utils/snack_bar.dart';
import 'package:stryde_mobile_app/utils/utils.dart';

class DocPickerModalBottomSheet extends ConsumerStatefulWidget {
  final VoidCallback onTakeDocPicture;

  const DocPickerModalBottomSheet({
    super.key,
    required this.onTakeDocPicture,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DocPickerModalBottomSheetState();
}

class _DocPickerModalBottomSheetState
    extends ConsumerState<DocPickerModalBottomSheet> {
  File? docPicture;
  File? selectedPicture;

  //! Camera view void function activator
  void takeDocPicture() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) {
        return;
      } else {
        widget.onTakeDocPicture();
      }

      final imageTemp = File(image.path);

      setState(() => docPicture = imageTemp);
    } on PlatformException catch (e) {
      'Failed to pick image file :(: $e'.log();
      // ignore: use_build_context_synchronously
      showSnackBar(
        context: context,
        text: 'An error occurred',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400.h,
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
            "Profile Photo".txt18(fontW: F.w7),
            20.sbH,
            AppTexts.profileImageInstruction.txt14(),
            60.sbH,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 150.h,
                  width: 150.h,
                  decoration: BoxDecoration(
                      color: Palette.strydeOrange,
                      borderRadius: BorderRadius.all(Radius.circular(15.r))),
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppGraphics.camera.iconPng.myImage(),
                      10.sbH,
                      "Take Photo".txt12()
                    ],
                  )),
                ).tap(onTap: () {
                  takeDocPicture();
                }),
                30.sbW,
                Container(
                  height: 150.h,
                  width: 150.h,
                  decoration: BoxDecoration(
                      color: Palette.buttonBG,
                      borderRadius: BorderRadius.all(Radius.circular(15.r))),
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppGraphics.files.iconPng.myImage(),
                      10.sbH,
                      "Choose File".txt12()
                    ],
                  )),
                ).tap(onTap: () {
                  pickImage();
                })
              ],
            )
          ],
        ),
      ),
    );
  }
}
