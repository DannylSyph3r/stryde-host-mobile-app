import 'package:stryde_mobile_app/shared/app_graphics.dart';
import 'package:stryde_mobile_app/shared/app_texts.dart';

enum SliderContent {
  slide1(AppGraphics.slide1, AppTexts.kycSliderHeader1, AppTexts.kycBody1),
  slide2(AppGraphics.slide2, AppTexts.kycSliderHeader2, AppTexts.kycBody2),
  slide3(AppGraphics.slide3, AppTexts.kycSliderHeader3, AppTexts.kycBody3);

  const SliderContent(this.imagePath, this.slideHeader, this.slideBody);

  final String imagePath;
  final String slideHeader;
  final String slideBody;
}
