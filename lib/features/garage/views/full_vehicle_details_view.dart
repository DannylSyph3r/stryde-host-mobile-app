import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:stryde_mobile_app/features/calendar/views/calendar_event_details_view.dart';
import 'package:stryde_mobile_app/features/garage/widgets/vehicle_specs_tab.dart';
import 'package:stryde_mobile_app/features/garage/widgets/waitlist_tile.dart';
import 'package:stryde_mobile_app/shared/app_graphics.dart';
import 'package:stryde_mobile_app/shared/app_texts.dart';
import 'package:stryde_mobile_app/theme/palette.dart';
import 'package:stryde_mobile_app/utils/app_extensions.dart';
import 'package:stryde_mobile_app/utils/custom_modal_bottomsheet.dart';
import 'package:stryde_mobile_app/utils/nav.dart';
import 'package:stryde_mobile_app/utils/option_selection_modal.dart';
import 'package:stryde_mobile_app/utils/widgets/appbar.dart';
import 'package:stryde_mobile_app/utils/widgets/row_railer.dart';

class FullVehicleDetailsView extends ConsumerStatefulWidget {
  final Object heroRouteTag;
  const FullVehicleDetailsView({required this.heroRouteTag, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FullVehicleDetailsViewState();
}

class _FullVehicleDetailsViewState
    extends ConsumerState<FullVehicleDetailsView> {
  final ValueNotifier<int> _currentIndexNotifier = ValueNotifier<int>(0);

  @override
  void dispose() {
    _currentIndexNotifier.dispose();
    super.dispose();
  }

  // Define the list of vehicle specifications
  final List<Map<String, dynamic>> vehicleSpecs = [
    {'icon': PhosphorIconsFill.carProfile, 'label': 'SUV'},
    {'icon': PhosphorIconsFill.gasPump, 'label': 'Petrol'},
    {'icon': PhosphorIconsFill.gear, 'label': 'Automatic'},
    {'icon': PhosphorIconsFill.paintBucket, 'label': 'Red & White'},
    {'icon': PhosphorIconsFill.seat, 'label': '4 Seats'},
    {'icon': PhosphorIconsFill.steeringWheel, 'label': 'Driver & Self Driven'},
  ];

  final List<Map<String, dynamic>> vehicleFeatures = [
    {'icon': PhosphorIconsBold.bluetooth, 'label': 'Bluetooth connectivity'},
    {'icon': PhosphorIconsBold.mapTrifold, 'label': 'GPS navigation'},
    {'icon': PhosphorIconsFill.videoCamera, 'label': 'Backup camera'},
    {'icon': PhosphorIconsFill.doorOpen, 'label': 'Keyless entry'},
    {'icon': PhosphorIconsFill.monitor, 'label': 'Touchscreen display'},
    {'icon': PhosphorIconsFill.sun, 'label': 'Climate control'},
    {'icon': PhosphorIconsFill.lightbulb, 'label': 'LED lighting'},
    {'icon': PhosphorIconsFill.speedometer, 'label': 'Cruise control'},
    {'icon': PhosphorIconsFill.scales, 'label': 'Stability control'},
    {'icon': PhosphorIconsFill.seat, 'label': 'Leather seats'},
    {'icon': PhosphorIconsFill.tire, 'label': 'Tire pressure warning'},
  ];

  final List<Map<String, dynamic>> optionSelections = [
    {'icon': PhosphorIconsBold.trash, 'label': 'Remove Vehicle'},
    {'icon': PhosphorIconsFill.flagBanner, 'label': 'Flag Unavailabale'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: "Mercedes Benz",
        context: context,
        toolbarHeight: 70.h,
        color: Colors.transparent,
        isTitleCentered: true,
        actions: [
          Padding(
            padding: 10.padH,
            child: Icon(
              PhosphorIconsBold.dotsThreeVertical,
              size: 25.h,
            ).tap(onTap: () {
              showOptionsModal(
                context,
                selectionOptions: optionSelections
                    .map((option) => option['label'] as String)
                    .toList(),
                leadingIcons: optionSelections
                    .map((option) => option['icon'] as IconData)
                    .toList(),
                titleFontSize: 16.sp,
                titleFontColor: Colors.white,
                leadingIconColor: Colors.orange,
                modalHeight: 200.h, // Specify the height of the modal
                listViewHeight: 150.h, // Specify the height of the ListView
                onOptionTap: (index) {},
              );
            }),
          )
        ],
      ),
      body: ListView(
        padding: 0.padV,
        children: [
          "G-Class".txt16(textAlign: TextAlign.center).alignCenter(),
          15.sbH,
          Padding(
            padding: 15.padH,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18.r),
              child: Stack(
                children: [
                  Hero(
                    tag: widget.heroRouteTag,
                    child: Material(
                      child: FlutterCarousel(
                        items: List.generate(
                          4,
                          (index) => AppGraphics.fullCarPl.png.myImage(
                            fit: BoxFit.cover,
                            height: 230.h,
                            width: double.infinity,
                          ),
                        ),
                        options: CarouselOptions(
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 4),
                          viewportFraction: 1.0,
                          initialPage: 2,
                          showIndicator: false,
                          height: 230.h,
                          onPageChanged:
                              (int index, CarouselPageChangedReason reason) {
                            _currentIndexNotifier.value = index;
                          },
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10.0,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: ValueListenableBuilder<int>(
                        valueListenable: _currentIndexNotifier,
                        builder: (context, currentIndex, _) {
                          return SmoothPageIndicator(
                            controller:
                                PageController(initialPage: currentIndex),
                            count: 4,
                            effect: CustomizableEffect(
                              activeDotDecoration: DotDecoration(
                                width: 15.w,
                                height: 8.h,
                                color: Palette.strydeOrange,
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                              dotDecoration: DotDecoration(
                                width: 8.w,
                                height: 8.h,
                                color: Palette.whiteColor.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                              spacing: 5.w,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          20.sbH,
          RowRailer(
            rowPadding: 15.padH,
            leading: Row(
              children: [
                Icon(
                  PhosphorIconsFill.mapPin,
                  color: Palette.strydeOrange,
                  size: 18.h,
                ),
                5.sbW,
                "Abuja"
                    .txt14(
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left)
                    .alignCenterLeft(),
              ],
            ),
            trailing: "₦250,000 / day".txt14(fontW: F.w6),
          ),
          10.sbH,
          RowRailer(
            rowPadding: 15.padH,
            leading: Row(children: [
              RatingBar.builder(
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
              5.sbW,
              "(100)".txt14(),
            ]),
            trailing:
                "SNK-123XZ".txt14(fontW: F.w6, color: Palette.strydeOrange),
          ),
          30.sbH,
          Padding(
            padding: 15.padH,
            child: Row(
              children: [
                "Specs & Features".txt18(fontW: F.w6),
                15.sbW,
                Expanded(
                  child: Container(
                    height: 1.h,
                    color: Palette.whiteColor,
                  ),
                ),
              ],
            ),
          ),
          20.sbH,

          // ListView.builder for vehicle specifications
          SizedBox(
            height: 50.h,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: vehicleSpecs.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: 7.5.padH, // Add some padding if necessary
                  child: VehicleSpecificationsTab(
                    tabIcon: vehicleSpecs[index]['icon'] as IconData,
                    tabLabel: vehicleSpecs[index]['label'] as String,
                  ),
                );
              },
            ),
          ),
          25.sbH,
          SizedBox(
            height: 50.h,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: vehicleFeatures.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: 7.5.padH, // Add some padding if necessary
                  child: VehicleSpecificationsTab(
                    tabIcon: vehicleFeatures[index]['icon'] as IconData,
                    tabLabel: vehicleFeatures[index]['label'] as String,
                  ),
                );
              },
            ),
          ),

          30.sbH,
          Padding(
            padding: 15.padH,
            child: Row(
              children: [
                "Description".txt18(fontW: F.w6),
                15.sbW,
                Expanded(
                  child: Container(
                    height: 1.h,
                    color: Palette.whiteColor,
                  ),
                ),
              ],
            ),
          ),
          20.sbH,
          Padding(
            padding: 15.padH,
            child: Container(
              padding: 15.0.padA,
              width: double.infinity,
              height: 200.h,
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
              child: AppTexts.carDescriptionPlaceHolder
                  .txt(size: 13.sp, textAlign: TextAlign.justify),
            ),
          ),
          50.sbH
        ],
      ),
      floatingActionButton: Container(
        height: 50.h,
        width: 135.h,
        decoration: BoxDecoration(
          color: Palette.strydeOrange,
          borderRadius: BorderRadius.circular(25.r),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                PhosphorIconsBold.listBullets,
                size: 20.h,
              ),
              10.sbW,
              "Waitlist".txt14(),
            ],
          ),
        ),
      ).tap(onTap: () {
        showCustomModal(
          context,
          modalHeight: 500.h,
          child: Column(
            children: [
              SizedBox(height: 10.h),
              Expanded(
                child: ListView.builder(
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return WaitlistTile(
                      renterName: "Kazato Kirigaya",
                      dateFrom: "27 July",
                      timeFrom: "8:00 AM",
                      dateTo: "1 August",
                      timeTo: "12:00 PM",
                      onWaitListTap: () {
                        goTo(
                            context: context, view: CalendarEventDetailsView());
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
