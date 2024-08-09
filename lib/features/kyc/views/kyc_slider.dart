import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:stryde_mobile_app/features/garage/providers/garage_providers.dart';
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
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.73);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(carouselStateProvider);

    // Jump to the current page index only if it's not already set
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_pageController.hasClients) {
        _pageController.jumpToPage(currentIndex);
      }
    });
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Column(
            children: [
              100.sbH,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child:
                    AppTexts.kycMainHeader.txt20(fontW: F.w8).alignCenterLeft(),
              ),
              20.sbH,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: AppTexts.kycMainBody.txt(size: 13.sp),
              ),
              30.sbH,
              SizedBox(
                height: constraints.maxHeight * 0.57,
                child: PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  itemCount: sliderContentList.length,
                  itemBuilder: (context, index) {
                    double scale = currentIndex == index ? 1.0 : 0.9;
                    return TweenAnimationBuilder(
                      tween: Tween<double>(begin: scale, end: scale),
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeOutCubic,
                      builder: (context, value, child) {
                        return Transform.scale(
                          scale: value,
                          child: child,
                        );
                      },
                      child: _buildSliderItem(sliderContentList[index]),
                    );
                  },
                ),
              ),
              20.sbH,
              SmoothPageIndicator(
                effect: WormEffect(
                  dotHeight: 12.h,
                  dotWidth: 12.w,
                  spacing: 13.w,
                  dotColor: Palette.whiteColor.withOpacity(0.5),
                  activeDotColor: Palette.strydeOrange,
                ),
                controller: _pageController,
                count: sliderContentList.length,
              ).alignCenter(),
              40.sbH,
              AppButton(
                text: "Proceed",
                onTap: () {
                  final currentPage = ref.read(carouselStateProvider);
                  if (currentPage == 0) {
                    goTo(context: context, view: AccountTypeSelectionView());
                  } else if (currentPage == 1) {
                    goTo(context: context, view: GoalSelectionView());
                  } else if (currentPage == 2) {
                    ref.read(kycGarageProvider.notifier).state = true;
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

  Widget _buildSliderItem(SliderContent content) {
    return Container(
      width: 300.w,
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      padding: EdgeInsets.symmetric(horizontal: 20.w),
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
              content.imagePath.png,
              fit: BoxFit.cover,
              height: 180.h,
            ),
          ),
          30.sbH,
          content.slideHeader.txt16(fontW: F.w8).alignCenterLeft(),
          15.sbH,
          content.slideBody.txt(size: 15.sp),
        ],
      ),
    );
  }
}
