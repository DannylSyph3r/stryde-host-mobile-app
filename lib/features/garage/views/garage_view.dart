import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stryde_mobile_app/features/garage/providers/garage_providers.dart';
import 'package:stryde_mobile_app/features/garage/views/basic_vehicle_info_view.dart';
import 'package:stryde_mobile_app/features/garage/views/full_vehicle_details_view.dart';
import 'package:stryde_mobile_app/features/garage/widgets/garage_list.dart';
import 'package:stryde_mobile_app/theme/palette.dart';
import 'package:stryde_mobile_app/utils/app_extensions.dart';
import 'package:stryde_mobile_app/utils/nav.dart';
import 'package:stryde_mobile_app/utils/widgets/sliver_appbar.dart';

class GarageView extends ConsumerStatefulWidget {
  const GarageView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GarageViewState();
}

class _GarageViewState extends ConsumerState<GarageView> {
  @override
  Widget build(BuildContext context) {
    final garageListPopulator = ref.watch(garageListProvider);
    return Scaffold(
      body: garageListPopulator == 0
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icon(
                  //   PhosphorIconsFill.garage,
                  //   color: Palette.strydeOrange,
                  //   size: 40.h,
                  // ),
                  // 10.sbH,
                  "Your Garage is empty".txt16(),
                ],
              ),
            )
          : DefaultTabController(
              length: 2,
              child: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverwareAppBar(
                      appBarToolbarheight: 55.h,
                      sliverCollapseMode: CollapseMode.parallax,
                      isPinned: true,
                      canStretch: false,
                      isFloating: true,
                      customizeLeadingWidget: false,
                      showLeadingIconOrWidget: false,
                      titleCentered: true,
                      isTitleAWidget: false,
                      title: "Garage",
                      titleFontSize: 20.sp,
                      titleFontWeight: FontWeight.w100,
                      sliverBottom: AppBar(
                        centerTitle: true,
                        automaticallyImplyLeading: false,
                        scrolledUnderElevation: 0,
                        toolbarHeight: 60.h,
                        title: TabBar(
                          padding: EdgeInsets.zero,
                          tabAlignment: TabAlignment.center,
                          indicatorSize: TabBarIndicatorSize.label,
                          dividerColor: Colors.transparent,
                          indicator: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 4,
                                color: Palette.strydeOrange,
                              ),
                            ),
                          ),
                          labelColor: Palette.strydeOrange,
                          unselectedLabelColor: Palette.whiteColor,
                          labelStyle: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.w600),
                          ),
                          unselectedLabelStyle: GoogleFonts.montserrat(
                            textStyle: TextStyle(fontSize: 16.sp),
                          ),
                          tabs: [
                            Tab(
                              child: SizedBox(
                                width: 100.w,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    "Active".txt(size: 14.sp),
                                    // 5.sbW,
                                    // "8".txt(
                                    //     size: 14.sp,
                                    //     color: Palette.strydeOrange,
                                    //     fontW: F.w6),
                                  ],
                                ),
                              ),
                            ),
                            Tab(
                              child: SizedBox(
                                width: 100.w,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    "On Rent".txt(size: 14.sp),
                                    // 5.sbW,
                                    // "5".txt(
                                    //     size: 14.sp,
                                    //     color: Palette.strydeOrange),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ];
                },
                body: TabBarView(children: [
                  ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: 10.padV,
                      itemCount: garageListPopulator,
                      itemBuilder: (context, index) {
                        return GarageList(
                          vehicleBrandName: "Mercedes Benz",
                          vehicleLocation: "Lagos",
                          vehicleModel: "GLK",
                          vehicleTrim: "GLK 4L",
                          rentalRate: "₦250,000 / day",
                          onGarageListTap: () {
                            goTo(
                                context: context,
                                view: FullVehicleDetailsView());
                          },
                        );
                      }),
                  ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: 10.padV,
                      itemCount: garageListPopulator,
                      itemBuilder: (context, index) {
                        return GarageList(
                          vehicleBrandName: "Mercedes Benz",
                          vehicleLocation: "Abuja",
                          vehicleModel: "GLK",
                          vehicleTrim: "GLK 4L",
                          rentalRate: "₦250,000 / day",
                          onGarageListTap: () {
                            goTo(
                                context: context,
                                view: FullVehicleDetailsView());
                          },
                        );
                      }),
                ]),
              ),
            ),
      floatingActionButton: Container(
        height: 50.h,
        width: 110.h,
        decoration: BoxDecoration(
            color: Palette.strydeOrange,
            borderRadius: BorderRadius.circular(25.r)),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                PhosphorIconsBold.plus,
                size: 20.h,
              ),
              10.sbW,
              "Add".txt14()
            ],
          ),
        ),
      ).tap(onTap: () {
        ref.read(kycGarageProvider.notifier).state = false;
        goTo(context: context, view: BasicVehicleInformationView());
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
