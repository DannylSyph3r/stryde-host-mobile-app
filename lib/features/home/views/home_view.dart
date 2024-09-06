import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stryde_mobile_app/features/calendar/views/calendar_event_details_view.dart';
import 'package:stryde_mobile_app/features/home/providers/home_providers.dart';
import 'package:stryde_mobile_app/features/home/widgets/ad_display_card.dart';
import 'package:stryde_mobile_app/features/home/widgets/quick_action_pills.dart';
import 'package:stryde_mobile_app/features/home/widgets/vertical_bar.dart';
import 'package:stryde_mobile_app/features/reviews/views/full_review_view.dart';
import 'package:stryde_mobile_app/features/notifications/views/notifications_view.dart';
import 'package:stryde_mobile_app/features/home/views/user_account_view.dart';
import 'package:stryde_mobile_app/shared/app_graphics.dart';
import 'package:stryde_mobile_app/theme/palette.dart';
import 'package:stryde_mobile_app/utils/app_extensions.dart';
import 'package:stryde_mobile_app/utils/nav.dart';
import 'package:stryde_mobile_app/features/reviews/widgets/review_card.dart';
import 'package:stryde_mobile_app/utils/widgets/row_railer.dart';
import 'package:video_player/video_player.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  final List<Map<String, dynamic>> quickActions = [
    {'icon': PhosphorIconsBold.uploadSimple, 'label': 'Withdraw'},
    {'icon': PhosphorIconsFill.mapPin, 'label': 'Tracker'},
    {'icon': PhosphorIconsFill.identificationCard, 'label': 'Insurance'},
  ];
  final ValueNotifier<int> _currentIndexNotifier = ValueNotifier<int>(0);
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _videoController =
        VideoPlayerController.asset('lib/assets/images/car_ad.mp4')
          ..initialize().then((_) {
            setState(() {
              _videoController.play();
              _videoController.setLooping(true);
            });
          }).catchError((error) {
            // Handle video loading error
            'Error loading video: $error'.log();
          });
  }

  @override
  void dispose() {
    _currentIndexNotifier.dispose();
    _videoController.dispose(); // Dispose of the video controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        30.sbH,
        Padding(
          padding: 15.padH,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 270.w,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 50.h,
                          decoration: BoxDecoration(
                            color: Palette.buttonBG.withOpacity(0.5),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Palette.strydeOrange.withOpacity(0.2),
                                spreadRadius: 10,
                                blurRadius: 15,
                              ),
                            ],
                          ),
                          child: Center(
                              child: AppGraphics.memeoji.png
                                  .myImage(fit: BoxFit.contain)),
                        ).tap(onTap: () {
                          goTo(context: context, view: UserAccountView());
                        }),
                        10.sbW,
                        Flexible(
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: "Hello, ",
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                  fontSize: 15.sp,
                                ),
                              ),
                              children: [
                                TextSpan(
                                  text: "Slethware Kageyama",
                                  style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            maxLines: 1, // Set the maximum number of lines
                            overflow: TextOverflow
                                .ellipsis, // Specify the overflow behavior
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 40.h,
                    width: 40.h,
                    decoration: BoxDecoration(
                      color: Palette.greyColor.withOpacity(0.3),
                      borderRadius: BorderRadius.all(Radius.circular(8.r)),
                    ),
                    child: const Icon(
                      PhosphorIconsRegular.bellSimple,
                      color: Palette.whiteColor,
                    ),
                  ).tap(onTap: () {
                    goTo(context: context, view: NotificationsView());
                  }),
                ],
              ),
              30.sbH,
              Container(
                padding: 20.0.padA,
                decoration: BoxDecoration(
                  color: Palette.buttonBG,
                  borderRadius: BorderRadius.all(Radius.circular(15.r)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      offset: const Offset(0, 4),
                      blurRadius: 8.0,
                      spreadRadius: 5.0,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              PhosphorIconsFill.chartBar,
                              size: 20.h,
                              color: Palette.strydeOrange,
                            ),
                            5.sbW,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "Earnings".txt16(fontW: F.w6),
                                "Monthly".txt12()
                              ],
                            )
                          ],
                        ),
                        "₦1,000,000".txt20(fontW: F.w6),
                      ],
                    ),
                    30.sbH,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomVerticalBar(
                              percentage: 50.0,
                              width: 35.w,
                              height: 200.h,
                            ),
                            10.sbH,
                            "0%".txt14(fontW: F.w6)
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomVerticalBar(
                              percentage: 75.0,
                              width: 35.w,
                              height: 200.h,
                            ),
                            10.sbH,
                            "10%".txt14(fontW: F.w6)
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomVerticalBar(
                              percentage: 60.0,
                              width: 35.w,
                              height: 200.h,
                            ),
                            10.sbH,
                            "-5%".txt14(fontW: F.w6)
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomVerticalBar(
                              percentage: 85.0,
                              width: 35.w,
                              height: 200.h,
                            ),
                            10.sbH,
                            "20%".txt14(fontW: F.w6)
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomVerticalBar(
                              percentage: 95.0,
                              width: 35.w,
                              height: 200.h,
                            ),
                            10.sbH,
                            "25%".txt14(fontW: F.w6)
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ).tap(onTap: () {
                goTo(context: context, view: CalendarEventDetailsView());
              }),
            ],
          ),
        ),
        20.sbH,
        FlutterCarousel(
          items: List.generate(10, (index) {
            if (index % 2 == 0) {
              // Even index, show video
              return Padding(
                padding: 15.padH,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.r),
                  child: SizedBox(
                    width: double.infinity,
                    height: 190.h,
                    child: _videoController.value.isInitialized
                        ? FittedBox(
                            fit: BoxFit.cover,
                            child: SizedBox(
                              width: _videoController.value.size.width,
                              height: _videoController.value.size.height,
                              child: VideoPlayer(_videoController),
                            ),
                          )
                        : const Center(
                            child: CircularProgressIndicator(),
                          ),
                  ).tap(onTap: () {
                    if (_videoController.value.isPlaying) {
                      _videoController.pause();
                    } else {
                      _videoController.play();
                    }
                  }),
                ),
              );
            } else {
              // Odd index, show ad
              return Padding(
                padding: 15.padH,
                child: const AdDisplayCard(),
              );
            }
          }),
          options: CarouselOptions(
            physics: const NeverScrollableScrollPhysics(),
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 30),
            viewportFraction: 1.0,
            initialPage: 0,
            showIndicator: false,
            height: 190.h,
            onPageChanged: (int index, CarouselPageChangedReason reason) {
              _currentIndexNotifier.value = index;
              if (index % 2 == 0) {
                // Video is in view, resume playback
                _videoController.play();
              } else {
                // Video is not in view, pause playback
                _videoController.pause();
              }
            },
          ),
        ),
        30.sbH,
        Padding(
          padding: 15.padH,
          child: "Quick Actions".txt18(fontW: F.w6),
        ),
        20.sbH,
        SizedBox(
          height: 85.h,
          child: ListView.builder(
            padding: 7.5.padH,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: quickActions.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding: 7.5.padH,
                  child: QuickActionPills(
                      pillIcon: quickActions[index]['icon'] as IconData,
                      pillLabel: quickActions[index]['label'] as String));
            },
          ),
        ),
        30.sbH,
        RowRailer(
          rowPadding: 15.padH,
          leading: Row(children: [
            "Reviews".txt18(fontW: F.w6),
            10.sbW,
            Container(
              height: 40.h,
              width: 75.w,
              decoration: BoxDecoration(
                  color: Palette.buttonBG,
                  borderRadius: BorderRadius.all(Radius.circular(15.r))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  "4.5".txt16(textAlign: TextAlign.left, fontW: F.w4),
                  5.sbW,
                  Icon(
                    PhosphorIconsFill.star,
                    size: 20.h,
                    color: Palette.strydeOrange,
                  )
                ],
              ),
            )
          ]),
          trailing: "View All"
              .txt(size: 17.sp, fontW: F.w6, color: Palette.strydeOrange)
              .tap(onTap: () {
            ref.read(reviewVisibilityProvider.notifier).state = true;
            goTo(context: context, view: FullReviewView());
          }),
        ),
        20.sbH,
        SizedBox(
          height: 260.h,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: 10.padH,
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return const ReviewCard();
            },
          ),
        ),
        30.sbH
      ],
    ));
  }
}
