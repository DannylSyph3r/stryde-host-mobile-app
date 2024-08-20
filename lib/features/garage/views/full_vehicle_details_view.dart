import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stryde_mobile_app/theme/palette.dart';
import 'package:stryde_mobile_app/utils/app_extensions.dart';
import 'package:stryde_mobile_app/utils/widgets/appbar.dart';

class Slide {
  Slide({
    required this.title,
    required this.height,
    required this.color,
  });

  final Color color;
  final double height;
  final String title;
}

var slides = List.generate(
  6,
  (index) => Slide(
    title: 'Slide ${index + 1}',
    height: 100.0,
    color: Colors.primaries[index % Colors.primaries.length],
  ),
);

final List<Widget> sliders = slides
    .map(
      (item) => Container(
        color: item.color,
        width: double.infinity,
        height: item.height,
        child: Center(
          child: Text(
            item.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    )
    .toList();

class FullVehicleDetailsView extends ConsumerStatefulWidget {
  const FullVehicleDetailsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FullVehicleDetailsViewState();
}

class _FullVehicleDetailsViewState
    extends ConsumerState<FullVehicleDetailsView> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          title: "Mercedes Benz / G-Class",
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
              ),
            )
          ]),
      body: ListView(
        children: [
          Padding(
              padding: 15.padH,
              child: Stack(
                children: [
                  FlutterCarousel(
                    items: sliders,
                    options: CarouselOptions(
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 4),
                      viewportFraction: 1.0,
                      initialPage: 2,
                      showIndicator: false,
                      height: 230.h,
                      onPageChanged:
                          (int index, CarouselPageChangedReason reason) {
                        setState(() {
                          _current = index;
                        });
                      },
                    ),
                  ),
                  Positioned(
                    bottom:
                        10.0, // Adjust the distance from the bottom if needed
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: slides.asMap().entries.map((entry) {
                        return Container(
                          width: _current == entry.key ? 15.0.w : 10.0.w,
                          height: 10.0.w,
                          margin: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 4.0),
                          decoration: BoxDecoration(
                              borderRadius: _current == entry.key
                                  ? BorderRadius.circular(8.r)
                                  : BorderRadius.zero,
                              
                              color: _current == entry.key
                                  ? Palette.strydeOrange
                                  : Palette.whiteColor),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              )),
        ],
      ),
      floatingActionButton: Container(
        height: 50.h,
        width: 135.h,
        decoration: BoxDecoration(
            color: Palette.buttonBG, borderRadius: BorderRadius.circular(25.r)),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                PhosphorIconsBold.listBullets,
                size: 20.h,
              ),
              10.sbW,
              "Waitlist".txt14()
            ],
          ),
        ),
      ).tap(onTap: () {}),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
