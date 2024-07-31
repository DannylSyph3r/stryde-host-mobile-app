import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stryde_mobile_app/theme/palette.dart';
import 'package:stryde_mobile_app/utils/app_extensions.dart';
import 'package:stryde_mobile_app/utils/widgets/sliver_appbar.dart';

class MessagesView extends ConsumerStatefulWidget {
  const MessagesView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MessagesViewState();
}

class _MessagesViewState extends ConsumerState<MessagesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
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
                showLeadingIconOrWidget: false,
                titleCentered: true,
                isTitleAWidget: false,
                title: "Messages",
                titleFontSize: 20.sp,
                titleFontWeight: FontWeight.w100,
                sliverBottom: AppBar(
                  centerTitle: true,
                  automaticallyImplyLeading: false,
                  scrolledUnderElevation: 0,
                  title: TabBar(
                    padding: EdgeInsets.zero,
                    tabAlignment: TabAlignment.center,
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
                              "All".txt(size: 14.sp),
                              5.sbW,
                              "8".txt(
                                  size: 14.sp,
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
                              "On Rent".txt(size: 14.sp),
                              5.sbW,
                              "5".txt(size: 14.sp, color: Palette.strydeOrange),
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
                child: Column(
                  children: [],
                )),
            Padding(
                padding: 15.padH,
                child: Column(
                  children: [],
                )),
          ]),
        ),
      ),
    );
  }
}
