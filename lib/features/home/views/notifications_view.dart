import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stryde_mobile_app/features/calendar/views/calendar_event_details_view.dart';
import 'package:stryde_mobile_app/features/home/views/rental_request_details_view.dart';
import 'package:stryde_mobile_app/features/home/widgets/notification_display_tile.dart';
import 'package:stryde_mobile_app/theme/palette.dart';
import 'package:stryde_mobile_app/utils/app_extensions.dart';
import 'package:stryde_mobile_app/utils/nav.dart';
import 'package:stryde_mobile_app/utils/widgets/sliver_appbar.dart';
import 'dart:math';

class NotificationsView extends ConsumerStatefulWidget {
  const NotificationsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NotificationsViewState();
}

class _NotificationsViewState extends ConsumerState<NotificationsView> {
  final Random _random = Random();

  List<NotificationDisplayTile> _generateNotifications() {
    List<NotificationDisplayTile> notifications = [];

    for (int i = 0; i < 15; i++) {
      String vehicleName = "Vehicle ${i + 1}";
      NotificationType notificationType;

      if (i < 5) {
        notificationType = NotificationType.rentalRequest;
      } else {
        notificationType = _random.nextBool()
            ? NotificationType.pickup
            : NotificationType.dropOff;
      }

      String notificationDate = _getRandomDate();
      String notificationTime = _getRandomTime();
      String scheduledDate =
          (notificationType == NotificationType.rentalRequest)
              ? ""
              : notificationDate;
      String scheduledTime =
          (notificationType == NotificationType.rentalRequest)
              ? ""
              : notificationTime;

      String? fromName;
      if (notificationType == NotificationType.rentalRequest) {
        fromName = "User ${_random.nextInt(100)}"; // Random user name
      }

      notifications.add(NotificationDisplayTile(
        notificationType: notificationType,
        vehicleName: vehicleName,
        scheduledDate: scheduledDate,
        scheduledTime: scheduledTime,
        notificationDate: notificationDate,
        notificationTime: notificationTime,
        fromName: fromName,
        viewDetailsTap: () {
          // Navigate to the appropriate details view
          if (notificationType == NotificationType.rentalRequest) {
            goTo(context: context, view: RentalRequestDetailsView());
          } else {
            goTo(context: context, view: CalendarEventDetailsView());
          }
        },
      ));
    }

    return notifications;
  }

  String _getRandomDate() {
    List<String> dates = ["Today", "Tomorrow", "22/07/2024"];
    return dates[_random.nextInt(dates.length)];
  }

  String _getRandomTime() {
    List<String> times = ["7:42 AM", "6:54 PM", "1:30 PM", "10:15 AM"];
    return times[_random.nextInt(times.length)];
  }

  @override
  Widget build(BuildContext context) {
    final notifications = _generateNotifications(); // Generate notifications

    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverwareAppBar(
                appBarToolbarheight: 55.h,
                sliverCollapseMode: CollapseMode.parallax,
                isPinned: true,
                canStretch: false,
                isFloating: true,
                customizeLeadingWidget: false,
                showLeadingIconOrWidget: true,
                titleCentered: true,
                isTitleAWidget: false,
                title: "Notifications",
                titleFontSize: 20.sp,
                titleFontWeight: FontWeight.w100,
                sliverBottom: AppBar(
                  centerTitle: true,
                  automaticallyImplyLeading: false,
                  scrolledUnderElevation: 0,
                  title: TabBar(
                    padding: EdgeInsets.zero,
                    tabAlignment: TabAlignment.fill,
                    indicatorSize: TabBarIndicatorSize.label,
                    dividerColor: Colors.transparent,
                    indicator: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 2,
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
                              "All".txt(size: 13.sp),
                              5.sbW,
                              "${notifications.length}".txt(
                                  size: 13.sp,
                                  color: Palette.strydeOrange,
                                  fontW: F.w6),
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
                              "Requests".txt(size: 13.sp),
                              3.5.sbW,
                              "${notifications.where((n) => n.notificationType == NotificationType.rentalRequest).length}"
                                  .txt(
                                      size: 13.sp, color: Palette.strydeOrange),
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
                              "Events".txt(size: 13.sp),
                              5.sbW,
                              "${notifications.where((n) => n.notificationType != NotificationType.rentalRequest).length}"
                                  .txt(
                                      size: 13.sp, color: Palette.strydeOrange),
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
            Padding(
              padding: 15.padH,
              child: ListView.separated(
                padding: 15.padV,
                itemCount: notifications.length,
                separatorBuilder: (context, index) {
                  return 20.sbH;
                },
                itemBuilder: (context, index) {
                  return notifications[index];
                },
              ),
            ),
            Padding(
              padding: 15.padH,
              child: ListView.separated(
                padding: 15.padV,
                itemCount: notifications
                    .where((n) =>
                        n.notificationType == NotificationType.rentalRequest)
                    .length,
                separatorBuilder: (context, index) {
                  return 20.sbH;
                },
                itemBuilder: (context, index) {
                  final rentalRequests = notifications
                      .where((n) =>
                          n.notificationType == NotificationType.rentalRequest)
                      .toList();
                  return rentalRequests[index];
                },
              ),
            ),
            Padding(
              padding: 15.padH,
              child: ListView.separated(
                padding: 15.padV,
                itemCount: notifications
                    .where((n) =>
                        n.notificationType != NotificationType.rentalRequest)
                    .length,
                separatorBuilder: (context, index) {
                  return 20.sbH;
                },
                itemBuilder: (context, index) {
                  final events = notifications
                      .where((n) =>
                          n.notificationType != NotificationType.rentalRequest)
                      .toList();
                  return events[index];
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
