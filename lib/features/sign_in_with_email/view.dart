import 'package:flutter/material.dart';
import 'package:flutter_steps_tracker/features/sign_up/view.dart';
import 'package:get/get.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import 'controller.dart';

class SignInWithEmailPage extends StatelessWidget {
  final controller = Get.put(SignInWithEmailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Sign in".tr,
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
                      ),
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
                      "Sign in with E-mail".tr,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 5,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: GetBuilder<SignInWithEmailController>(
                            id: SignInWithEmailController.emailTag,
                            init: controller,
                            builder: (controller) {
                              return TextField(
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  errorText: controller.emailErrorMessage,
                                  // make the border color same as primary color
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary, // Active border color
                                      width:
                                          2.0, // Optional: Adjust the border width
                                    ),
                                  ),
                                  hintText: "E-mail".tr,
                                ),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                onChanged: (value) {
                                  controller.email = value;
                                },
                              );
                            }),
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: GetBuilder<SignInWithEmailController>(
                            id: SignInWithEmailController.passwordTag,
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
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary, // Active border color
                                      width:
                                          2.0, // Optional: Adjust the border width
                                    ),
                                  ),
                                  hintText: "Password".tr,
                                ),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                onChanged: (value) {
                                  controller.password = value;
                                },
                              );
                            }),
                      ),
                      Align(
                          alignment: Get.locale?.languageCode == "en"
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: TextButton(
                              onPressed: () {
                                Get.to(() => SignUpPage());
                              },
                              child: Text("Register for new account".tr),
                            ),
                          )),
                      Spacer(
                        flex: 2,
                      ),
                      GetBuilder<SignInWithEmailController>(
                          id: SignInWithEmailController.registerButtonTag,
                          init: controller,
                          builder: (controller) {
                            return controller.isloading
                                ? const CircularProgressIndicator()
                                : ElevatedButton(
                                    onPressed: () {
                                      controller.signIn();
                                    },
                                    child: Text("Enter".tr),
                                  );
                          }),
                      Spacer(
                        flex: 4,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
