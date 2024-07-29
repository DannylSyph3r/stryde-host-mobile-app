import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stryde_mobile_app/features/base_nav/wrapper/base_nav_wrapper.dart';
import 'package:stryde_mobile_app/theme/palette.dart';
import 'package:stryde_mobile_app/utils/app_extensions.dart';

class NavBarWidget extends ConsumerWidget {
  final Nav nav;

  const NavBarWidget({
    Key? key,
    required this.nav,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int indexFromController = ref.watch(baseNavControllerProvider);
    bool isSelected = indexFromController == nav.index;

    return SizedBox(
      width: 50.w,
      child: Column(
        children: [
          // Animated Item Indicator Container
          AnimatedContainer(
            duration: 350.milliseconds,
            height: 5.h,
            width: isSelected ? 50.w : 0,
            decoration: BoxDecoration(
              color: isSelected ? Palette.strydeOrange : Colors.transparent,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25.r),
                bottomRight: Radius.circular(25.r),
              ),
            ),
          ),
          10.sbH,

          //! ICON

          nav.icon.iconPng.myImage(
            color: isSelected ? Palette.strydeOrange : Palette.whiteColor,
            height: 40.h,
            width: 40.h,
          ),
        ],
      ),
    ).gestureTap(
      onTap: () {
        moveToPage(
          context: context,
          ref: ref,
          index: nav.index,
        );
      },
    );
  }
}
