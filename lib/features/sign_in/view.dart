import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_steps_tracker/core/utilities/project_constants.dart';
import 'package:flutter_steps_tracker/features/sign_in_with_email/view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sign_button/sign_button.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'controller.dart';

class SignInPage extends StatelessWidget {
  final controller = Get.put(SignInController());

  SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Welcome".tr,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Image.asset(
                      "assets/images/icon.png",
                      fit: BoxFit.contain,
                    )),
                    const SizedBox(
                      height: 8,
                    ),
                    GradientText(
                      "Steptiper",
                      style: const TextStyle(
                          fontSize: 40.0, fontWeight: FontWeight.bold),
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context).colorScheme.secondary,
                      ],
                    ),
                    Text(
                      "TIP YOURSELF WITH YOUR STEPS".tr,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: ToggleSwitch(
                        minWidth: 90.0,
                        minHeight: 34.0,
                        fontSize: 16.0,
                        initialLabelIndex:
                            Get.locale!.languageCode == "ar" ? 1 : 0,
                        activeBgColor: [Theme.of(context).colorScheme.primary],
                        activeFgColor: Colors.white,
                        inactiveBgColor: Colors.grey,
                        inactiveFgColor: Colors.grey[900],
                        totalSwitches: 2,
                        labels: ["English", "عربي"],
                        onToggle: (index) {
                          print('switched to: $index');
                          var locale = index == 0
                              ? const Locale('en')
                              : const Locale('ar');
                          Get.updateLocale(locale);
                          GetStorage().write(
                            ProjectConstants.isArabic,
                            locale.languageCode,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Expanded(
                flex: 3,
                child: Center(
                  child: GetBuilder<SignInController>(
                      init: controller,
                      builder: (controller) {
                        if (controller.isloading) {
                          return const CircularProgressIndicator();
                        } else {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SignInButton(
                                buttonType: ButtonType.googleDark,
                                btnText: "Sign in with Google".tr,
                                onPressed: () {
                                  controller.googleLogin();
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                      8,
                                    ),
                                  ),
                                ),
                              ),
                              SignInButton(
                                buttonType: ButtonType.mail,
                                btnText: "Sign in with E-mail".tr,
                                btnColor: Get.theme.colorScheme.primary,
                                onPressed: () {
                                  Get.to(() => SignInWithEmailPage());
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                      8,
                                    ),
                                  ),
                                ),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.symmetric(
                              //     horizontal: 16,
                              //     vertical: 8,
                              //   ),
                              //   child: TextField(
                              //     decoration: InputDecoration(
                              //       border: OutlineInputBorder(
                              //         borderRadius: BorderRadius.circular(16),
                              //       ),
                              //       hintText: "Enter your name".tr,
                              //     ),
                              //     style: TextStyle(
                              //         fontWeight: FontWeight.bold,
                              //         color: Theme.of(context).colorScheme.primary),
                              //     onChanged: (value) {
                              //       controller.username = value;
                              //     },
                              //   ),
                              // ),
                              // GetBuilder<SignInController>(
                              //     init: controller,
                              //     builder: (controller) {
                              //       return controller.isloading
                              //           ? const CircularProgressIndicator()
                              //           : ElevatedButton(
                              //               onPressed: () {
                              //                 controller.signIn();
                              //               },
                              //               child: Text("Enter".tr),
                              //             );
                              //     }),
                            ],
                          );
                        }
                      }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "By Signing in You Are Agreeing to Our\n".tr,
                    style: GoogleFonts.cairo(
                      color: Get.isDarkMode ? Colors.white : Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: "Terms and Conditions".tr,
                        style: GoogleFonts.cairo(
                          color: Get.theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            controller.goToTermsAndCondition();
                          },
                      ),
                      TextSpan(
                        text: " and ".tr,
                        style: GoogleFonts.cairo(
                          color: Get.isDarkMode ? Colors.white : Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: "Privacy Policy".tr,
                        style: GoogleFonts.cairo(
                          color: Get.theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            controller.goToPrivacyPolicy();
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
