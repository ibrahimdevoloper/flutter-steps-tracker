import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //TODO: Put Logo Image Here
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/icon.png", height: 300,),
            SizedBox(height: 8,),
            GradientText(
              "Steptiper",
              style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold
              ),
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.secondary,

              ],
            ),
          ],
        ),
      ),
    );
  }
}
