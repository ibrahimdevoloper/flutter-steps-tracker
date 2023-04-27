import 'package:flutter/material.dart';
import 'package:flutter_steps_tracker/utilities/project_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
                    ToggleSwitch(
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
                        SharedPreferences pref = Get.find();
                        pref.setString(
                            ProjectConstants.isArabic, locale.languageCode);
                      },
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SignInButton(
                        buttonType: ButtonType.googleDark,
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
                        btnColor: Get.theme.colorScheme.primary,
                        onPressed: () {
                          print('click');
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
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
