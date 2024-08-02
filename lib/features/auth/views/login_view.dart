import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:stryde_mobile_app/features/auth/providers/auth_providers.dart';
import 'package:stryde_mobile_app/features/auth/views/create_account_view.dart';
import 'package:stryde_mobile_app/features/base_nav/wrapper/base_nav_wrapper.dart';
import 'package:stryde_mobile_app/shared/app_graphics.dart';
import 'package:stryde_mobile_app/shared/app_texts.dart';
import 'package:stryde_mobile_app/theme/palette.dart';
import 'package:stryde_mobile_app/utils/app_extensions.dart';
import 'package:stryde_mobile_app/utils/nav.dart';
import 'package:stryde_mobile_app/utils/widgets/appbar.dart';
import 'package:stryde_mobile_app/utils/widgets/button.dart';
import 'package:stryde_mobile_app/utils/widgets/text_input.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView>
    with SingleTickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _emailPasswordController =
      TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _phoneNumberPasswordController =
      TextEditingController();
  final ValueNotifier _passwordVisible = false.notifier;
  late TabController _loginTabController;

  void passwordVisibility() => _passwordVisible.value = !_passwordVisible.value;

  @override
  void initState() {
    super.initState();
    _loginTabController = TabController(length: 2, vsync: this);
    _loginTabController.addListener(_handleTabChange);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ref.watch(loginTabStateProvider);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _emailPasswordController.dispose();
    _phoneNumberController.dispose();
    _phoneNumberPasswordController.dispose();
    _loginTabController.dispose();
    super.dispose();
  }

  void _handleTabChange() {
    if (_loginTabController.indexIsChanging) {
      // This is called when the tab is changing
      final currentIndex = _loginTabController.index;
      // Do something based on the current tab index
      ref.read(loginTabStateProvider.notifier).state = currentIndex.toInt();
      "Tab $currentIndex selected".log();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          title: "", context: context, implyLeading: true, toolbarHeight: 60.h),
      body: SingleChildScrollView(
        child: Padding(
          padding: 20.0.padV,
          child: Column(children: [
            Padding(
              padding: 15.padH,
              child: "Login".txt24(fontW: F.w6).alignCenterLeft(),
            ),
            15.sbH,
            DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    TabBar(
                      controller: _loginTabController,
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
                            fontSize: 17.sp, fontWeight: FontWeight.w600),
                      ),
                      unselectedLabelStyle: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          fontSize: 17.sp,
                        ),
                      ),
                      tabs: const [
                        Tab(
                          text: 'Email',
                        ),
                        Tab(
                          text: 'Phone Number',
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 170.h,
                      child: TabBarView(
                          controller: _loginTabController,
                          children: [
                            Column(
                              children: [
                                20.sbH,
                                Padding(
                                  padding: 15.padH,
                                  child: TextInputWidget(
                                      hintText: "Email",
                                      controller: _emailController),
                                ),
                                10.sbH,
                                _passwordVisible.sync(
                                    builder: (context, passwordVisible, child) {
                                  return Padding(
                                    padding: 15.padH,
                                    child: TextInputWidget(
                                      hintText: "Password",
                                      controller: _emailPasswordController,
                                      obscuretext: !_passwordVisible.value,
                                      suffixIcon: Padding(
                                          padding: 15.padH,
                                          child: Icon(
                                            passwordVisible
                                                ? PhosphorIconsBold.eyeSlash
                                                : PhosphorIconsBold.eye,
                                            size: 20.h,
                                            color:
                                                _passwordVisible.value == false
                                                    ? Palette.strydeOrange
                                                    : Palette.whiteColor,
                                          )).tap(onTap: () {
                                        passwordVisibility();
                                      }),
                                    ),
                                  );
                                }),
                              ],
                            ),
                            Column(
                              children: [
                                20.sbH,
                                Padding(
                                  padding: 15.padH,
                                  child: TextInputWidget(
                                      hintText: "Phone Number",
                                      controller: _phoneNumberController),
                                ),
                                10.sbH,
                                _passwordVisible.sync(
                                    builder: (context, passwordVisible, child) {
                                  return Padding(
                                    padding: 15.padH,
                                    child: TextInputWidget(
                                      hintText: "Password",
                                      controller:
                                          _phoneNumberPasswordController,
                                      obscuretext: !_passwordVisible.value,
                                      suffixIcon: Padding(
                                          padding: 15.padH,
                                          child: Icon(
                                            passwordVisible
                                                ? PhosphorIconsBold.eyeSlash
                                                : PhosphorIconsBold.eye,
                                            size: 20.h,
                                            color:
                                                _passwordVisible.value == false
                                                    ? Palette.strydeOrange
                                                    : Palette.whiteColor,
                                          )).tap(onTap: () {
                                        passwordVisibility();
                                      }),
                                    ),
                                  );
                                }),
                              ],
                            )
                          ]),
                    )
                  ],
                )),
            10.sbH,
            "or login with".txt(size: 17.sp, color: Palette.whiteColor),
            20.sbH,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 47.h,
                  width: 120.w,
                  decoration: BoxDecoration(
                      color: Palette.buttonBG,
                      borderRadius: BorderRadius.all(Radius.circular(21.r))),
                  child: Center(
                      child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AppGraphics.googleIcon.iconSvg,
                          height: 27.h,
                        ),
                        10.sbW,
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            3.sbH,
                            "Google".txt14(fontW: F.w6),
                          ],
                        )
                      ],
                    ),
                  )),
                ),
                // 15.sbW,
                // Container(
                //   height: 47.h,
                //   width: 120.w,
                //   decoration: BoxDecoration(
                //       color: Palette.buttonBG,
                //       borderRadius: BorderRadius.all(Radius.circular(21.r))),
                //   child: Center(
                //       child: Padding(
                //     padding:
                //         EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         SvgPicture.asset(
                //           AppGraphics.appleIcon.iconSvg,
                //           height: 27.h,
                //         ),
                //         10.sbW,
                //         Column(
                //           mainAxisSize: MainAxisSize.min,
                //           children: [
                //             3.sbH,
                //             "Apple".txt14(fontW: F.w6),
                //           ],
                //         )
                //       ],
                //     ),
                //   )),
                // )
              ],
            ),
            20.sbH,
            AppTexts.forgotPassword
                .txt(size: 17.sp, color: Palette.strydeOrange),
            20.sbH,
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: AppTexts.noAccount,
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    fontSize: 13.sp,
                  ),
                ),
                children: [
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        goToAndReplace(
                            context: context, view: const CreateAccountView());
                      },
                    text: AppTexts.signUp,
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                        color: Palette.strydeOrange,
                        fontSize: 13.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            170.sbH,
            AppButton(
                text: "Login",
                onTap: () {
                  goTo(context: context, view: BaseNavWrapper());
                })
          ]),
        ),
      ),
    );
  }
}
