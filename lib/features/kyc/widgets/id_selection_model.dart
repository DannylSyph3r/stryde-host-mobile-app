import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stryde_mobile_app/theme/palette.dart';
import 'package:stryde_mobile_app/utils/app_constants.dart';
import 'package:stryde_mobile_app/utils/app_extensions.dart';
import 'package:stryde_mobile_app/utils/widgets/list_tile.dart';

class IDSelectionBottomsheet extends ConsumerStatefulWidget {
  final VoidCallback onTileTapOne;
  final VoidCallback onTileTapTwo;
  final VoidCallback onTileTapThree;
  const IDSelectionBottomsheet(
      {required this.onTileTapOne,
      required this.onTileTapTwo,
      required this.onTileTapThree,
      super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _IDSelectionBottomsheetState();
}

class _IDSelectionBottomsheetState
    extends ConsumerState<IDSelectionBottomsheet> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: 500.milliseconds,
        height: 250.h,
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
              const OptionSelectionListTile(
                      interactiveTrailing: false, titleLabel: "Drivers License")
                  .tap(onTap: widget.onTileTapOne),
              const OptionSelectionListTile(
                      interactiveTrailing: false,
                      titleLabel: "International Passport")
                  .tap(onTap: widget.onTileTapTwo),
              const OptionSelectionListTile(
                      interactiveTrailing: false, titleLabel: "NIN")
                  .tap(onTap: widget.onTileTapThree ),
            ],
          ),
        ));
  }
}
