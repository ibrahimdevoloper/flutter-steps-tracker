import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import 'controller.dart';

class SignUpPage extends StatelessWidget {
  final controller = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Sign up".tr,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GradientText(
                  "Steptiper",
                  style: const TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary,
                  ],
                ),
                Text(
                  "Register for new account".tr,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(
                  height: 56,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: GetBuilder<SignUpController>(
                      id: SignUpController.fullNameTag,
                      init: controller,
                      builder: (controller) {
                        return TextField(
                          decoration: InputDecoration(
                            errorText: controller.fullNameErrorMessage,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondary, // Active border color
                                width: 2.0, // Optional: Adjust the border width
                              ),
                            ),
                            hintText: "Full Name".tr,
                          ),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary),
                          onChanged: (value) {
                            controller.fullName = value;
                          },
                        );
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: GetBuilder<SignUpController>(
                      id: SignUpController.emailTag,
                      init: controller,
                      builder: (controller) {
                        return TextField(
                          decoration: InputDecoration(
                            errorText: controller.emailErrorMessage,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondary, // Active border color
                                width: 2.0, // Optional: Adjust the border width
                              ),
                            ),
                            hintText: "E-mail".tr,
                          ),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary),
                          onChanged: (value) {
                            controller.email = value;
                          },
                        );
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: GetBuilder<SignUpController>(
                      id: SignUpController.passwordTag,
                      init: controller,
                      builder: (controller) {
                        return TextField(
                          obscureText: controller.isPasswordObscure,
                          decoration: InputDecoration(
                            suffix: IconButton(
                              onPressed: () {
                                controller.switchPasswordObscure();
                              },
                              icon: Icon(
                                controller.isPasswordObscure
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                            errorText: controller.passwordErrorMessage,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondary, // Active border color
                                width: 2.0, // Optional: Adjust the border width
                              ),
                            ),
                            hintText: "Password".tr,
                          ),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary),
                          onChanged: (value) {
                            controller.password = value;
                          },
                        );
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: GetBuilder<SignUpController>(
                      id: SignUpController.confirmPasswordTag,
                      init: controller,
                      builder: (controller) {
                        return TextField(
                          obscureText: controller.isConfirmPasswordObscure,
                          decoration: InputDecoration(
                            suffix: IconButton(
                              onPressed: () {
                                controller.switchConfirmPasswordObscure();
                              },
                              icon: Icon(
                                controller.isConfirmPasswordObscure
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                            errorText: controller.confirmPasswordErrorMessage,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondary, // Active border color
                                width: 2.0, // Optional: Adjust the border width
                              ),
                            ),
                            hintText: "Confirm Password".tr,
                          ),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary),
                          onChanged: (value) {
                            controller.confirmPassword = value;
                          },
                        );
                      }),
                ),
                const SizedBox(
                  height: 8,
                ),
                GetBuilder<SignUpController>(
                    id: SignUpController.registerButtonTag,
                    init: controller,
                    builder: (controller) {
                      return controller.isloading
                          ? const CircularProgressIndicator()
                          : ElevatedButton(
                              onPressed: () {
                                controller.signUp();
                              },
                              child: Text("Enter".tr),
                            );
                    }),
              ],
            ),
          ),
        ));
  }
}
