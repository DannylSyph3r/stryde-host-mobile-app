import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stryde_mobile_app/shared/app_graphics.dart';
import 'package:stryde_mobile_app/theme/palette.dart';
import 'package:stryde_mobile_app/utils/app_extensions.dart';
import 'package:stryde_mobile_app/utils/widgets/appbar.dart';

class ChatView extends ConsumerStatefulWidget {
  const ChatView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatViewState();
}

class _ChatViewState extends ConsumerState<ChatView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          isTitleText: false,
          titleWidget: Row(
            children: [
              Container(
                height: 50.h,
                decoration: BoxDecoration(
                  color: Palette.buttonBG.withOpacity(0.5),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Palette.strydeOrange.withOpacity(0.2),
                      spreadRadius: 6,
                      blurRadius: 9,
                    ),
                  ],
                ),
                child: Center(
                  child: AppGraphics.memeoji.png.myImage(fit: BoxFit.contain),
                ),
              ),
              15.sbW,
              Flexible(
                  child: Column(
                children: [
                  SizedBox(
                          width: 160.w,
                          child: "Ogunlana Tobore".txt14(
                              fontW: F.w6,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left))
                      .alignCenterLeft(),
                  5.sbH,
                  "09068781839"
                      .txt14(textAlign: TextAlign.left)
                      .alignCenterLeft(),
                ],
              ))
            ],
          ),
          actions: [
            Padding(
              padding: 10.padH,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    PhosphorIconsFill.phone,
                    size: 22.h,
                  ),
                  10.sbW,
                  Icon(
                    PhosphorIconsBold.dotsThreeVertical,
                    size: 22.h,
                  ),
                ],
              ),
            )
          ],
          context: context),
    );
  }
}
