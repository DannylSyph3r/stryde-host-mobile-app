import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stryde_mobile_app/features/base_nav/widgets/nav_bar_widgets.dart';
import 'package:stryde_mobile_app/features/calendar/views/calendar_view.dart';
import 'package:stryde_mobile_app/features/garage/views/garage_view.dart';
import 'package:stryde_mobile_app/features/home/views/home_view.dart';
import 'package:stryde_mobile_app/features/messages/views/messages_view.dart';
import 'package:stryde_mobile_app/theme/palette.dart';
import 'package:stryde_mobile_app/utils/app_constants.dart';
part 'base_nav_wrapper_controller.dart';

class BaseNavWrapper extends ConsumerWidget {
  const BaseNavWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int indexFromController = ref.watch(baseNavControllerProvider);
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Palette.darkBG,
        body: pages[indexFromController],
        bottomNavigationBar: Material(
          elevation: 40,
          shadowColor: Palette.blackColor,
          child: Container(
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            color: Palette.darkBG,
            height: 60.h,
            width: width(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                nav.length,
                (index) => NavBarWidget(nav: nav[index]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}