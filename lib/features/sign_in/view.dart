import 'package:flutter/material.dart';
import 'package:flutter_steps_tracker/features/home/view.dart';
import 'package:get/get.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import 'controller.dart';

class SignInPage extends StatelessWidget {
  final controller = Get.put(SignInController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Welcome",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme
                    .of(context)
                    .colorScheme
                    .primary),
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
                    SizedBox(
                      height: 8,
                    ),
                    GradientText(
                      "Steptiper",
                      style: TextStyle(
                          fontSize: 40.0, fontWeight: FontWeight.bold),
                      colors: [
                        Theme
                            .of(context)
                            .colorScheme
                            .primary,
                        Theme
                            .of(context)
                            .colorScheme
                            .secondary,
                      ],
                    ),
                    Text(
                      "TIP YOURSELF WITH YOUR STEPS",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme
                              .of(context)
                              .colorScheme
                              .primary),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Expanded(
                flex: 3,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            hintText: 'Enter your name',
                          ),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme
                                  .of(context)
                                  .colorScheme
                                  .primary),
                          onChanged: (value){
                            controller.username=value;
                          },
                        ),
                      ),
                      GetBuilder<SignInController>(
                        init: controller,
                          builder: (controller) {
                        return controller.isloading?
                            CircularProgressIndicator():
                        ElevatedButton(
                          onPressed: () {
                            controller.SignIn();
                          },
                          child: Text("Enter"),
                        );
                      }),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
