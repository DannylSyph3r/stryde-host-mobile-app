import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stryde_mobile_app/shared/app_graphics.dart';
import 'package:stryde_mobile_app/theme/palette.dart';
import 'package:stryde_mobile_app/utils/app_extensions.dart';
import 'package:stryde_mobile_app/utils/widgets/row_railer.dart';

class GarageList extends ConsumerWidget {
  final String vehicleBrandName;
  final String vehicleLocation;
  final String vehicleModel;
  final String vehicleDescription;
  final String fuelType;
  final int seatNumber;
  final String gearType;
  final Color primaryColor;
  final Color secondaryColor;
  const GarageList(
      {required this.vehicleBrandName,
      required this.vehicleLocation,
      required this.vehicleModel,
      required this.vehicleDescription,
      required this.fuelType,
      required this.seatNumber,
      required this.gearType,
      required this.primaryColor,
      required this.secondaryColor,
      super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
      child: Row(
        children: [
          Flexible(
            flex: 2,
            child: Column(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(12.r)),
                    child: AppGraphics.carPl.png.myImage())
              ],
            ),
          ),
          20.sbW,
          Flexible(
            flex: 3,
            child: Column(
              children: [
                RowRailer(
                  rowPadding: 0.padH,
                  leading: vehicleBrandName.txt(
                      size: 15.sp,
                      fontW: F.w6,
                      overflow: TextOverflow.ellipsis),
                  middle: 10.sbW,
                  trailing: vehicleLocation.txt(
                      size: 15.sp, overflow: TextOverflow.ellipsis),
                ),
                5.sbH,
                vehicleModel.txt14(textAlign: TextAlign.left).alignCenterLeft(),
                20.sbH,
                vehicleDescription.txt14(
                    maxLines: 3, overflow: TextOverflow.ellipsis),
                20.sbH,
                Container(
                  height: 55.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Palette.buttonBG,
                      borderRadius: BorderRadius.all(Radius.circular(15.r))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            PhosphorIconsRegular.paintBrushHousehold,
                            size: 22.h,
                            color: Palette.strydeOrange,
                          ),
                          10.sbH,
                          Row(
                            children: [
                              Container(
                                width: 9.h,
                                height: 9.h,
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              3.sbW,
                              Container(
                                width: 9.h,
                                height: 9.h,
                                decoration: BoxDecoration(
                                  color: secondaryColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          5.sbH,
                          Icon(
                            PhosphorIconsRegular.gasPump,
                            size: 22.h,
                            color: Palette.strydeOrange,
                          ),
                          5.sbH,
                          Row(
                            children: [fuelType.txt(size: 11.sp)],
                          )
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          5.sbH,
                          Icon(
                            PhosphorIconsRegular.seat,
                            size: 22.h,
                            color: Palette.strydeOrange,
                          ),
                          5.sbH,
                          Row(
                            children: ["$seatNumber Seats".txt12()],
                          )
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          5.sbH,
                          Icon(
                            PhosphorIconsRegular.gear,
                            size: 22.h,
                            color: Palette.strydeOrange,
                          ),
                          5.sbH,
                          Row(
                            children: [gearType.txt12()],
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
