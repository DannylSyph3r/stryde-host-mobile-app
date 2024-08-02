import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stryde_mobile_app/features/calendar/views/calendar_event_details_view.dart';
import 'package:stryde_mobile_app/features/home/providers/home_providers.dart';
import 'package:stryde_mobile_app/features/reviews/views/full_review_view.dart';
import 'package:stryde_mobile_app/features/notifications/views/notifications_view.dart';
import 'package:stryde_mobile_app/features/home/views/user_account_view.dart';
import 'package:stryde_mobile_app/features/home/widgets/rental_display_card.dart';
import 'package:stryde_mobile_app/shared/app_graphics.dart';
import 'package:stryde_mobile_app/theme/palette.dart';
import 'package:stryde_mobile_app/utils/app_extensions.dart';
import 'package:stryde_mobile_app/utils/nav.dart';
import 'package:stryde_mobile_app/utils/widgets/container_list_tile.dart';
import 'package:stryde_mobile_app/features/reviews/widgets/review_card.dart';
import 'package:stryde_mobile_app/utils/widgets/row_railer.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
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
              "Today".txt18(fontW: F.w6),
              20.sbH,
              Container(
                height: 250.h,
                padding: 10.0.padA,
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
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment
                      .start, // Aligns the children to the start of the Row
                  children: [
                    Flexible(
                      flex: 2,
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.r)),
                            child: AppGraphics.carPl.png
                                .myImage(height: 220.h, fit: BoxFit.cover),
                          ),
                        ],
                      ),
                    ),
                    15.sbW, // Spacing between image and text
                    Flexible(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment
                            .start, // Aligns text to the start
                        children: [
                          "Mercedes Benz".txt18(
                              fontW: F.w6, overflow: TextOverflow.ellipsis),
                          5.sbH, // Spacing between the name and model
                          "GLE 63".txt16(overflow: TextOverflow.ellipsis),
                          10.sbH,
                          "Abuja".txt16(
                              fontW: F.w6, overflow: TextOverflow.ellipsis),
                          10.sbH,
                          OptionSelectionContainerTile(
                            horizontalContentPadding: 5.w,
                            leadingIcon: PhosphorIconsFill.circle,
                            leadingIconColor: Palette.whiteColor,
                            leadingIconSize: 15.h,
                            titleLabel: "Drop-off",
                            titleFontWeight: F.w6,
                            subtitleLabel: "9:00 AM",
                            subtitleFontSize: 14.sp,
                            interactiveTrailing: false,
                          ),
                          OptionSelectionContainerTile(
                            horizontalContentPadding: 5.w,
                            leadingIcon: PhosphorIconsFill.circle,
                            leadingIconColor: Palette.strydeOrange,
                            leadingIconSize: 15.h,
                            titleLabel: "Pick-up",
                            titleFontWeight: F.w6,
                            subtitleLabel: "5:00 PM",
                            subtitleFontSize: 14.sp,
                            interactiveTrailing: false,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ).tap(onTap: () {
                goTo(context: context, view: CalendarEventDetailsView());
              }),
              30.sbH,
              "On Rent".txt18(fontW: F.w6),
            ],
          ),
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
              return const RentalDisplayCard();
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
