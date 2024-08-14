// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:stryde_mobile_app/features/base_nav/wrapper/base_nav_wrapper.dart';
// import 'package:stryde_mobile_app/features/garage/providers/garage_providers.dart';
// import 'package:stryde_mobile_app/features/garage/views/basic_vehicle_info_view.dart';
// import 'package:stryde_mobile_app/theme/palette.dart';
// import 'package:stryde_mobile_app/utils/app_extensions.dart';
// import 'package:stryde_mobile_app/utils/nav.dart';
// import 'package:stryde_mobile_app/utils/snack_bar.dart';
// import 'package:stryde_mobile_app/utils/type_defs.dart';
// import 'package:stryde_mobile_app/utils/widgets/appbar.dart';
// import 'package:stryde_mobile_app/utils/widgets/button.dart';
// import 'package:stryde_mobile_app/utils/widgets/text_input.dart';

// // final scanningProvider = StateProvider<bool>((ref) {
// //   return false;
// // });

// // final recognizedTextProvider = StateProvider<String>((ref) {
// //   return "";
// // });

// // final isBusyProvider = StateProvider<bool>((ref) {
// //   return false;
// // });

// class VINInputView extends ConsumerStatefulWidget {
//   const VINInputView({super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _VINInputViewState();
// }

// class _VINInputViewState extends ConsumerState<VINInputView> {
//   final TextEditingController _vinController = TextEditingController();
//   // late final TextRecognizer _textRecognizer;

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   _textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
//   // }

//   // @override
//   // void dispose() {
//   //   _textRecognizer.close();
//   //   _vinController.dispose();
//   //   super.dispose();
//   // }

//   // Future<void> performTextRecognition(BuildContext context) async {
//   //   final picker = ImagePicker();
//   //   try {
//   //     final XFile? pickedImage =
//   //         await picker.pickImage(source: ImageSource.camera);
//   //     if (pickedImage == null) {
//   //       "No image was picked".log();
//   //       return;
//   //     }

//   //     ref.read(scanningProvider.notifier).state = true;
//   //     ref.read(isBusyProvider.notifier).state = true;

//   //     // Route to image cropper view
//   //     final croppedImagePath =
//   //         // ignore: use_build_context_synchronously
//   //         await imageCropperView(pickedImage.path, context);
//   //     if (croppedImagePath.isEmpty) {
//   //       ref.read(scanningProvider.notifier).state = false;
//   //       ref.read(isBusyProvider.notifier).state = false;
//   //       "Image cropping was cancelled".log();
//   //       return;
//   //     }

//   //     final inputImage = InputImage.fromFilePath(croppedImagePath);
//   //     await _processImage(inputImage);
//   //   } catch (e) {
//   //     'Failed to recognize text: $e'.log();
//   //   } finally {
//   //     ref.read(scanningProvider.notifier).state = false;
//   //     ref.read(isBusyProvider.notifier).state = false;
//   //     "Provider Value: ${ref.read(recognizedTextProvider.notifier).state}"
//   //         .log();
//   //   }
//   // }

//   // Future<void> _processImage(InputImage inputImage) async {
//   //   if (ref.read(isBusyProvider.notifier).state) {
//   //     return; // Prevent processing if busy
//   //   }
//   //   ref.read(isBusyProvider.notifier).state = true; // Set busy state

//   //   final recognizedText = await _textRecognizer.processImage(inputImage);

//   //   // Update the recognizedTextProvider with the new text
//   //   ref.read(recognizedTextProvider.notifier).state = recognizedText.text;

//   //   // Update the VIN input field with the recognized text
//   //   _vinController.text = recognizedText.text;

//   //   ref.read(isBusyProvider.notifier).state = false; // End busy state
//   // }

//   @override
//   Widget build(BuildContext context) {
//     final kycGarageState = ref.watch(kycGarageProvider);

//     return Scaffold(
//       appBar: customAppBar(
//           title: "Car Details",
//           context: context,
//           toolbarHeight: 70.h,
//           color: Colors.transparent,
//           isTitleCentered: true),
//       body: Padding(
//         padding: 15.padH,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               children: [
//                 10.sbH,
//                 TextInputWidget(
//                   hintText: "VIN Number",
//                   controller: _vinController,
//                   // suffixIcon: Padding(
//                   //   padding: 5.padH,
//                   //   child: Container(
//                   //     decoration: const BoxDecoration(
//                   //         border: Border(
//                   //             left: BorderSide(color: Palette.strydeOrange))),
//                   //     child: Padding(
//                   //       padding: 10.padH,
//                   //       child: isScanning || isBusy
//                   //           ? SizedBox(
//                   //               width: 25.h,
//                   //               height: 25.h,
//                   //               child: const CircularProgressIndicator(
//                   //                   strokeWidth: 2),
//                   //             )
//                   //           : Icon(PhosphorIconsRegular.scan, size: 25.h).tap(
//                   //               onTap: () {
//                   //               performTextRecognition(context);
//                   //             }),
//                   //     ),
//                   //   ),
//                   // ),
//                 ),
//                 30.sbH,
//                 Padding(
//                   padding: 15.padH,
//                   child: Column(
//                     children: [
                     
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             Column(
//               children: [
//                 AppButton(
//                   text: "Proceed",
//                   onTap: () {
//                     if (_vinController.text.isNotEmpty) {
//                       goTo(
//                           context: context, view: BasicVehicleInformationView());
//                     } else {
//                       showFlushBanner(
//                           context: context,
//                           theMessage: "Please input a valid VIN",
//                           theType: NotificationType.info);
//                     }
//                   },
//                 ),
//                 20.sbH,
//                 Visibility(
//                   visible: kycGarageState,
//                   child: AppButton(
//                     text: "Skip",
//                     color: Palette.buttonBG,
//                     onTap: () {
//                       goTo(context: context, view: BaseNavWrapper());
//                     },
//                   ),
//                 ),
//                 30.sbH,
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Future<String> imageCropperView(String? path, BuildContext context) async {
// //   CroppedFile? croppedFile = await ImageCropper().cropImage(
// //     sourcePath: path!,
// //     aspectRatioPresets: [
// //       CropAspectRatioPreset.square,
// //       CropAspectRatioPreset.ratio3x2,
// //       CropAspectRatioPreset.original,
// //       CropAspectRatioPreset.ratio4x3,
// //       CropAspectRatioPreset.ratio16x9
// //     ],
// //     uiSettings: [
// //       AndroidUiSettings(
// //           toolbarTitle: 'Crop Image',
// //           toolbarColor: Colors.blue,
// //           toolbarWidgetColor: Colors.white,
// //           initAspectRatio: CropAspectRatioPreset.original,
// //           lockAspectRatio: false),
// //       IOSUiSettings(
// //         title: 'Crop Image',
// //       ),
// //       WebUiSettings(
// //         context: context,
// //       ),
// //     ],
// //   );

// //   if (croppedFile != null) {
// //     log("Image cropped");
// //     return croppedFile.path;
// //   } else {
// //     log("Do nothing");
// //     return '';
// //   }
// // }
