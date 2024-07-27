import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stryde_mobile_app/features/garage/views/car_specfications_input_view.dart';
import 'package:stryde_mobile_app/utils/app_extensions.dart';
import 'package:stryde_mobile_app/utils/nav.dart';
import 'package:stryde_mobile_app/utils/widgets/appbar.dart';
import 'package:stryde_mobile_app/utils/widgets/button.dart';
import 'package:stryde_mobile_app/utils/widgets/text_input.dart';

class VINInputView extends ConsumerStatefulWidget {
  const VINInputView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VINInputViewState();
}

class _VINInputViewState extends ConsumerState<VINInputView> {
  final TextEditingController _vinController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("Car Details",
          context: context,
          toolbarHeight: 70.h,
          color: Colors.transparent,
          isTitleCentered: true),
      body: Padding(
        padding: 20.padH,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                10.sbH,
                TextInputWidget(
                    hintText: "VIN Number", controller: _vinController),
              ],
            ),
            Column(
              children: [
                AppButton(
                    text: "Proceed",
                    onTap: () {
                      goTo(
                          context: context, view: CarSpecificationsInputView());
                    }),
                50.sbH
              ],
            )
          ],
        ),
      ),
    );
  }
}
