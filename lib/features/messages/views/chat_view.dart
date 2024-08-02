import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stryde_mobile_app/features/messages/models/chat_message_model.dart';
import 'package:stryde_mobile_app/features/messages/views/messges_review_view.dart';
import 'package:stryde_mobile_app/features/messages/widgets/bottom_chat_field.dart';
import 'package:stryde_mobile_app/features/messages/widgets/reciever_message_bubble.dart';
import 'package:stryde_mobile_app/features/messages/widgets/sender_message_bubble.dart';
import 'package:stryde_mobile_app/shared/app_graphics.dart';
import 'package:stryde_mobile_app/theme/palette.dart';
import 'package:stryde_mobile_app/utils/app_extensions.dart';
import 'package:stryde_mobile_app/utils/nav.dart';
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
                          child: "Makiado Kizunami".txt14(
                              fontW: F.w6,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left))
                      .alignCenterLeft(),
                  5.sbH,
                  "08034567821"
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
                  // Icon(
                  //   PhosphorIconsBold.dotsThreeVertical,
                  //   size: 22.h,
                  // ),
                ],
              ),
            )
          ],
          bottom: PreferredSize(
              preferredSize: Size(double.infinity, 40.h),
              child: Padding(
                padding: 10.padV,
                child: Center(
                    child: "View Reviews"
                        .txt16(color: Palette.strydeOrange)
                        .tap(onTap: () {
                  goTo(context: context, view: MessagesReviewView());
                })),
              )),
          context: context),
      body: Column(
        children: [
          Expanded(
            child: GroupedListView<ChatMessage, DateTime>(
              elements: chatMessages,
              groupBy: (ChatMessage chatMessageDisplay) {
                return DateTime(
                  chatMessageDisplay.postDate.year,
                  chatMessageDisplay.postDate.month,
                  chatMessageDisplay.postDate.day,
                );
              },
              groupHeaderBuilder: (ChatMessage chatMessages) => Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: DateFormat.yMMMd()
                    .format(chatMessages.postDate)
                    .txt12()
                    .alignCenter(),
              ),
              itemBuilder:
                  (BuildContext context, ChatMessage chatMessageDisplay) {
                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  child: Align(
                    alignment:
                        chatMessageDisplay.messageTag == MessageTypee.receiver
                            ? Alignment.bottomRight
                            : Alignment.topLeft,
                    child:
                        chatMessageDisplay.messageTag == MessageTypee.receiver
                            ? ReceiverMessageBubble(
                                messageContent: chatMessageDisplay.messageBody,
                                messageTimeStamp: DateFormat.jm()
                                    .format(chatMessageDisplay.postDate),
                              )
                            : SenderMessageBubble(
                                messageContent: chatMessageDisplay.messageBody,
                                messageTimeStamp: DateFormat.jm()
                                    .format(chatMessageDisplay.postDate),
                              ),
                  ),
                );
              },
            ),
          ),
          const BottomChatField(),
        ],
      ),
    );
  }
}
