import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stryde_mobile_app/theme/palette.dart';
import 'package:stryde_mobile_app/utils/widgets/appbar.dart';
import 'package:stryde_mobile_app/utils/widgets/sliver_appbar.dart';

class NotificationsView extends ConsumerStatefulWidget {
  const NotificationsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NotificationsViewState();
}

class _NotificationsViewState extends ConsumerState<NotificationsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DefaultTabController(
            length: 3,
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
                          indicatorSize: TabBarIndicatorSize.tab,
                          dividerColor: Colors.transparent,
                          indicator: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 2,
                                color: Palette.strydeOrange,
                              ),
                            ),
                          ),
                          labelColor: Palette.blackColor,
                          unselectedLabelColor: Palette.buttonBG,
                          labelStyle: GoogleFonts.lato(
                            textStyle: TextStyle(
                                fontSize: 15.sp, fontWeight: FontWeight.w600),
                          ),
                          unselectedLabelStyle: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                              fontSize: 15.sp,
                            ),
                          ),
                          tabs: const [
                            Tab(
                              text: 'All',
                            ),
                            Tab(
                              text: 'Requests',
                            ),
                            Tab(
                              text: 'Events',
                            ),
                          ],
                        ),
                      ))
                ];
              },
              body: TabBarView(children: [
                Column(
                  children: [],
                ),
                Column(
                  children: [],
                ),
                Column(
                  children: [],
                ),
              ]),
            )));
  }
}
