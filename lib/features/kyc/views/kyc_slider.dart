import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:stryde_mobile_app/features/garage/views/vin_input_view.dart';
import 'package:stryde_mobile_app/features/kyc/providers/kyc_providers.dart';
import 'package:stryde_mobile_app/features/kyc/views/account_type_selection_view.dart';
import 'package:stryde_mobile_app/features/kyc/views/goal_selection_view.dart';
import 'package:stryde_mobile_app/shared/app_graphics.dart';
import 'package:stryde_mobile_app/shared/app_texts.dart';
import 'package:stryde_mobile_app/theme/palette.dart';
import 'package:stryde_mobile_app/utils/app_extensions.dart';
import 'package:stryde_mobile_app/utils/nav.dart';
import 'package:stryde_mobile_app/utils/widgets/button.dart';

enum SliderContent {
  slide1(AppGraphics.slide1, AppTexts.kycSliderHeader1, AppTexts.kycBody1),
  slide2(AppGraphics.slide2, AppTexts.kycSliderHeader2, AppTexts.kycBody2),
  slide3(AppGraphics.slide3, AppTexts.kycSliderHeader3, AppTexts.kycBody3);

  const SliderContent(this.imagePath, this.slideHeader, this.slideBody);

  final String imagePath;
  final String slideHeader;
  final String slideBody;
}

List<SliderContent> sliderContentList = SliderContent.values;

class KycSliderView extends ConsumerStatefulWidget {
  const KycSliderView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _KycSliderViewState();
}

class _KycSliderViewState extends ConsumerState<KycSliderView> {
  final CarouselController _carouselController = CarouselController();
  late final PageController _pageController;
  late final ValueNotifier<int> _carouselIndexNotifier;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final pageIndexProvider = ref.watch(carouselStateProvider.notifier).state;

    _pageController = PageController(initialPage: pageIndexProvider);
    _carouselIndexNotifier = ValueNotifier<int>(pageIndexProvider);

    _carouselIndexNotifier.addListener(() {
      _pageController.animateToPage(
        _carouselIndexNotifier.value,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _carouselIndexNotifier.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final carouselIndexProvider = ref.watch(carouselStateProvider.notifier);
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Column(
            children: [
              100.sbH,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child:
                    AppTexts.kycMainHeader.txt20(fontW: F.w8).alignCenterLeft(),
              ),
              20.sbH,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: AppTexts.kycMainBody.txt(size: 13.sp),
              ),
              30.sbH,
              ValueListenableBuilder<int>(
                valueListenable: _carouselIndexNotifier,
                builder: (context, currentIndex, child) {
                  return CarouselSlider(
                    options: CarouselOptions(
                      initialPage: carouselIndexProvider.state,
                      scrollPhysics: const NeverScrollableScrollPhysics(),
                      height: constraints.maxHeight * 0.57,
                      aspectRatio: 16 / 9,
                      viewportFraction: 0.78,
                      enlargeCenterPage: true,
                      onPageChanged: (index, reason) {
                        _carouselIndexNotifier.value = index;
                      },
                    ),
                    carouselController: _carouselController,
                    items: sliderContentList.map((slide) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            width: constraints.maxWidth,
                            decoration: BoxDecoration(
                              color: Palette.buttonBG,
                              borderRadius: BorderRadius.circular(20.r),
                              border: Border.all(
                                width: 1.5,
                                color: Palette.strydeOrange,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 20.h),
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child: Image.asset(
                                    slide.imagePath.png,
                                    fit: BoxFit.cover,
                                    height: 200.h,
                                  ),
                                ),
                                30.sbH,
                                slide.slideHeader
                                    .txt16(fontW: F.w8)
                                    .alignCenterLeft(),
                                15.sbH,
                                slide.slideBody.txt(size: 15.sp),
                              ],
                            ),
                          );
                        },
                      );
                    }).toList(),
                  );
                },
              ),
              20.sbH,
              SizedBox(
                height: 1.h,
                child: PageView(
                  controller: _pageController,
                  children: List.generate(sliderContentList.length,
                      (index) => const SizedBox.shrink()),
                ),
              ),
              ValueListenableBuilder<int>(
                valueListenable: _carouselIndexNotifier,
                builder: (context, pageIndex, child) {
                  return SmoothPageIndicator(
                    effect: WormEffect(
                      dotHeight: 12.h,
                      dotWidth: 12.w,
                      spacing: 13.w,
                      dotColor: Palette.whiteColor.withOpacity(0.5),
                      activeDotColor: Palette.strydeOrange,
                    ),
                    controller: _pageController,
                    count: sliderContentList.length,
                  ).alignCenter();
                },
              ),
              40.sbH,
              AppButton(
                text: "Proceed",
                onTap: () {
                  if (carouselIndexProvider.state == 0) {
                    goTo(context: context, view: AccountTypeSelectionView());
                  }
                  if (carouselIndexProvider.state == 1) {
                    goTo(context: context, view: GoalSelectionView());
                  }
                  if (carouselIndexProvider.state == 2) {
                    goTo(context: context, view: VINInputView());
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
