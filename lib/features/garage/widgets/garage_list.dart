import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
  final String vehicleTrim;
  final String rentalRate;
  final VoidCallback onGarageListTap;
  // final String fuelType;
  // final int seatNumber;
  // final String gearType;
  // final Color primaryColor;
  // final Color secondaryColor;
  const GarageList(
      {required this.vehicleBrandName,
      required this.vehicleLocation,
      required this.vehicleModel,
      required this.vehicleTrim,
      required this.rentalRate,
      required this.onGarageListTap,
      // required this.vehicleDescription,
      // required this.fuelType,
      // required this.seatNumber,
      // required this.gearType,
      // required this.primaryColor,
      // required this.secondaryColor,
      super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      child: Container(
        decoration: BoxDecoration(
          color: Palette.buttonBG,
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: const Offset(0, 4),
              blurRadius: 8.0,
              spreadRadius: 5.0,
            ),
          ],
        ),
        child: Row(
          children: [
            Flexible(
              flex: 2,
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                          15.r), // Adjust the radius value as needed
                      bottomLeft: Radius.circular(15.r),
                    ),
                    child: AppGraphics.fullCarPl.png.myImage(
                      height: 150.h,
                      width: 140.h,
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
            ),
            10.sbW,
            Flexible(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: Column(
                  children: [
                    Row(
                      children: [
                        vehicleBrandName
                            .txt(
                                size: 15.sp,
                                fontW: F.w6,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left)
                            .alignCenterLeft(),
                        5.sbW,
                        "/".txt16(),
                        5.sbW,
                        vehicleModel
                            .txt14(
                              textAlign: TextAlign.left,
                              fontW: F.w6,
                            )
                            .alignCenterLeft(),
                      ],
                    ),
                    5.sbH,
                    vehicleTrim
                        .txt(size: 13.sp, textAlign: TextAlign.left)
                        .alignCenterLeft(),
                    15.sbH,
                    Row(
                      children: [
                        Icon(
                          PhosphorIconsFill.mapPin,
                          color: Palette.strydeOrange,
                          size: 18.h,
                        ),
                        5.sbW,
                        vehicleLocation
                            .txt(
                                size: 13.sp,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left)
                            .alignCenterLeft(),
                      ],
                    ),
                    20.sbH,
                    RowRailer(
                      rowPadding: 0.padH,
                      leading: RatingBar.builder(
                        itemSize: 14.w,
                        initialRating: 3.5,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: 1.padH,
                        unratedColor: Colors.grey.withOpacity(0.8),
                        itemBuilder: (context, _) => Icon(
                          PhosphorIconsFill.star,
                          color: Palette.strydeOrange,
                          size: 14.sp,
                        ),
                        onRatingUpdate: (rating) {
                          rating.log();
                        },
                      ),
                      trailing: rentalRate.txt12(fontW: F.w6),
                    ),
                    // vehicleDescription.txt14(
                    //     maxLines: 3, overflow: TextOverflow.ellipsis),
                    // 20.sbH,
                    // Container(
                    //   height: 55.h,
                    //   width: double.infinity,
                    //   decoration: BoxDecoration(
                    //       color: Palette.buttonBG,
                    //       borderRadius: BorderRadius.all(Radius.circular(15.r))),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //     children: [
                    //       Column(
                    //         mainAxisSize: MainAxisSize.min,
                    //         children: [
                    //           Icon(
                    //             PhosphorIconsRegular.paintBrushHousehold,
                    //             size: 22.h,
                    //             color: Palette.strydeOrange,
                    //           ),
                    //           10.sbH,
                    //           Row(
                    //             children: [
                    //               Container(
                    //                 width: 9.h,
                    //                 height: 9.h,
                    //                 decoration: BoxDecoration(
                    //                   color: primaryColor,
                    //                   shape: BoxShape.circle,
                    //                 ),
                    //               ),
                    //               3.sbW,
                    //               Container(
                    //                 width: 9.h,
                    //                 height: 9.h,
                    //                 decoration: BoxDecoration(
                    //                   color: secondaryColor,
                    //                   shape: BoxShape.circle,
                    //                 ),
                    //               ),
                    //             ],
                    //           )
                    //         ],
                    //       ),
                    //       Column(
                    //         mainAxisSize: MainAxisSize.min,
                    //         children: [
                    //           5.sbH,
                    //           Icon(
                    //             PhosphorIconsRegular.gasPump,
                    //             size: 22.h,
                    //             color: Palette.strydeOrange,
                    //           ),
                    //           5.sbH,
                    //           Row(
                    //             children: [fuelType.txt(size: 11.sp)],
                    //           )
                    //         ],
                    //       ),
                    //       Column(
                    //         mainAxisSize: MainAxisSize.min,
                    //         children: [
                    //           5.sbH,
                    //           Icon(
                    //             PhosphorIconsRegular.seat,
                    //             size: 22.h,
                    //             color: Palette.strydeOrange,
                    //           ),
                    //           5.sbH,
                    //           Row(
                    //             children: ["$seatNumber Seats".txt12()],
                    //           )
                    //         ],
                    //       ),
                    //       Column(
                    //         mainAxisSize: MainAxisSize.min,
                    //         children: [
                    //           5.sbH,
                    //           Icon(
                    //             PhosphorIconsRegular.gear,
                    //             size: 22.h,
                    //             color: Palette.strydeOrange,
                    //           ),
                    //           5.sbH,
                    //           Row(
                    //             children: [gearType.txt12()],
                    //           )
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // )
                  ],
                ),
              ),
            ),
          ],
        ),
      ).tap(onTap: onGarageListTap),
    );
  }
}
