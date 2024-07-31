import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stryde_mobile_app/shared/app_graphics.dart';
import 'package:stryde_mobile_app/theme/palette.dart';
import 'package:stryde_mobile_app/utils/app_extensions.dart';

class RentalDisplayCard extends StatelessWidget {
  const RentalDisplayCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(12.r)),
        child: Container(
          width: 170.w,
          decoration: const BoxDecoration(
            color: Palette.buttonBG,
          ),
          child: Column(
            children: [
              AppGraphics.carPl.png.myImage(width: 170.w, height: 185.w, fit: BoxFit.cover),
              10.sbH,
              Padding(
                padding: 10.padH,
                child: "Mercedes Benz".txt16(textAlign: TextAlign.left, fontW: F.w6, overflow: TextOverflow.ellipsis).alignCenterLeft(),
              ),
              5.sbH,
              Padding(
                padding: 10.padH,
                child: "Abuja".txt14(textAlign: TextAlign.left, overflow: TextOverflow.ellipsis).alignCenterLeft(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
