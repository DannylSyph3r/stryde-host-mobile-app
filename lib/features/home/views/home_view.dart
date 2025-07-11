import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stryde_mobile_app/features/calendar/views/calendar_event_details_view.dart';
import 'package:stryde_mobile_app/features/home/providers/home_providers.dart';
import 'package:stryde_mobile_app/features/home/views/drivers_invite_view.dart';
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
import 'package:stryde_mobile_app/utils/widgets/animated_linear_ticker.dart';
import 'package:stryde_mobile_app/utils/widgets/row_railer.dart';
import 'package:video_player/video_player.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView>
    with WidgetsBindingObserver {
  final FocusNode _focusNode = FocusNode();
  final List<Map<String, dynamic>> quickActions = [
    {'icon': PhosphorIconsBold.uploadSimple, 'label': 'Withdraw'},
    {'icon': PhosphorIconsFill.mapPin, 'label': 'Tracker'},
    {'icon': PhosphorIconsFill.identificationCard, 'label': 'Insurance'},
    {'icon': PhosphorIconsFill.user, 'label': 'Driver'},
  ];
  final ValueNotifier<int> _currentReviewsCarouselIndexNotifier =
      ValueNotifier<int>(0);
  final ValueNotifier<int> _currentAdvertIndexNotifier = ValueNotifier<int>(0);
  final ValueNotifier<double> _volumeNotifier =
      ValueNotifier<double>(0); // Notifier for volume control
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _videoController =
        VideoPlayerController.asset('lib/assets/images/car_ad.mp4')
          ..initialize().then((_) {
            setState(() {
              _videoController.play();
              _videoController.setLooping(true);
              _videoController.setVolume(0); // Set initial volume to 0
            });
          }).catchError((error) {
            'Error loading video: $error'.log();
          });
  }

  @override
  void dispose() {
    _currentAdvertIndexNotifier.dispose();
    _currentReviewsCarouselIndexNotifier.dispose();
    _volumeNotifier.dispose(); // Dispose of volume notifier
    _videoController.dispose(); // Dispose of the video controller
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      _muteVideo();
    }
  }

  void _muteVideo() {
    if (_videoController.value.volume > 0) {
      _videoController.setVolume(0);
      _volumeNotifier.value = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _focusNode,
      onFocusChange: (hasFocus) {
        if (!hasFocus) {
          _muteVideo();
        }
      },
      child: Scaffold(
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
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                ),
                              ],
                            ),
                            child: Center(
                                child: AppGraphics.memeoji.png
                                    .myImage(fit: BoxFit.contain)),
                          ).tap(onTap: () {
                            _muteVideo();
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
                      _muteVideo();
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
                  _muteVideo();
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
                      child: Stack(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 190.h,
                            child: _videoController.value.isInitialized
                                ? FittedBox(
                                    fit: BoxFit.cover,
                                    child: SizedBox(
                                      width: _videoController.value.size.width,
                                      height:
                                          _videoController.value.size.height,
                                      child: VideoPlayer(_videoController),
                                    ),
                                  )
                                : const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                          ).tap(onTap: () {
                            if (_videoController.value.isPlaying) {
                              _videoController.pause();
                              ref.read(pauseAnimationProvider.notifier).state =
                                  true;
                            } else {
                              _videoController.play();
                              ref.read(pauseAnimationProvider.notifier).state =
                                  false;
                            }
                          }),
                          const Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child: AnimatedTicker(
                                  animationDurationInSeconds: 30),
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            right: 10,
                            child: ValueListenableBuilder<double>(
                              valueListenable: _volumeNotifier,
                              builder: (context, volume, child) {
                                return Container(
                                  padding: const EdgeInsets.all(7.5),
                                  decoration: BoxDecoration(
                                    color: Palette.greyColor.withOpacity(0.3),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Icon(
                                      volume == 0
                                          ? PhosphorIconsFill.speakerSimpleX
                                          : PhosphorIconsFill.speakerHigh,
                                      color: Palette.whiteColor,
                                      size: 20.h,
                                    ),
                                  ),
                                ).tap(onTap: () {
                                  if (volume == 0) {
                                    _videoController.setVolume(1);
                                    _volumeNotifier.value = 1;
                                  } else {
                                    _muteVideo();
                                  }
                                });
                              },
                            ),
                          ),
                        ],
                      )),
                );
              } else {
                // Odd index, show ad
                return Padding(
                  padding: 15.padH,
                  child: Stack(
                    children: [
                      // AdDisplayCard(),
                      AppGraphics.insuranceAd.jpg.myImage(fit: BoxFit.cover),
                      const Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: AnimatedTicker(animationDurationInSeconds: 30),
                        ),
                      ),
                    ],
                  ),
                );
              }
            }),
            options: CarouselOptions(
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 30),
              viewportFraction: 1.0,
              initialPage: 0,
              showIndicator: false,
              height: 190.h,
              onPageChanged: (int index, CarouselPageChangedReason reason) {
                _currentAdvertIndexNotifier.value = index;
                // Reset the animation when the page changes
                ref.read(resetAnimationProvider.notifier).state = true;
                // Ensure the animation is not paused when changing pages
                ref.read(pauseAnimationProvider.notifier).state = false;
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
                        onPillTap: () {
                          if (index == 3) {
                            goTo(context: context, view: DriversInviteView());
                          } else {}
                        },
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
              _muteVideo();
              goTo(context: context, view: FullReviewView());
            }),
          ),
          20.sbH,
          Padding(
            padding: 10.padH,
            child: FlutterCarousel(
              items: List.generate(10, (index) => const ReviewCard()),
              options: CarouselOptions(
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 4),
                viewportFraction: 1.0,
                initialPage: 2,
                showIndicator: false,
                height: 230.h,
                onPageChanged: (int index, CarouselPageChangedReason reason) {
                  _currentReviewsCarouselIndexNotifier.value = index;
                },
              ),
            ),
          ),
          30.sbH
        ],
      )),
    );
  }
}
