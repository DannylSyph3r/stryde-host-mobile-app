import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stryde_mobile_app/shared/app_graphics.dart';
import 'package:stryde_mobile_app/theme/palette.dart';
import 'package:stryde_mobile_app/utils/app_constants.dart';
import 'package:stryde_mobile_app/utils/app_extensions.dart';
import 'package:stryde_mobile_app/utils/snack_bar.dart';

class DocPickerModalBottomSheet extends ConsumerStatefulWidget {
  final String headerText;
  final String descriptionText;
  final StateProvider<File?>? fileProvider; // Make fileProvider optional
  final VoidCallback onTakeDocPicture;

  const DocPickerModalBottomSheet({
    super.key,
    required this.headerText,
    required this.descriptionText,
    this.fileProvider, // Optional parameter
    required this.onTakeDocPicture,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DocPickerModalBottomSheetState();
}

class _DocPickerModalBottomSheetState
    extends ConsumerState<DocPickerModalBottomSheet> {
  File? docPicture;

  void takeDocPicture() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) {
        return;
      }

      final imageTemp = File(image.path);
      // Check if the provider is provided before updating the state
      if (widget.fileProvider != null) {
        ref.read(widget.fileProvider!.notifier).state =
            imageTemp; // Save to the specific provider
      }
      widget.onTakeDocPicture();

      setState(() => docPicture = imageTemp);
    } on PlatformException catch (e) {
      'Failed to pick image file :(: $e'.log();
      showSnackBar(
        // ignore: use_build_context_synchronously
        context: context,
        text: 'An error occurred',
      );
    }
  }

  Future<void> pickImage() async {
    try {
      final result = await FilePicker.platform
          .pickFiles(type: FileType.image, allowMultiple: false);

      if (result == null || result.files.isEmpty) {
        return;
      }

      final fileTemp = File(result.files.single.path!);
      // Check if the provider is provided before updating the state
      if (widget.fileProvider != null) {
        ref.read(widget.fileProvider!.notifier).state =
            fileTemp; // Save to the specific provider
      }
      widget.onTakeDocPicture();

      setState(() => docPicture = fileTemp);
    } catch (e) {
      showSnackBar(
        context: context,
        text: 'An error occurred while picking the file',
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
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
                widget.headerText.txt18(fontW: F.w7),
                20.sbH,
                widget.descriptionText.txt14(maxLines: 4, overflow: TextOverflow.ellipsis),
              ],
            ),
            Column(
              children: [
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
                ),
                40.sbH
              ],
            )
          ],
        ),
      ),
    );
  }
}
