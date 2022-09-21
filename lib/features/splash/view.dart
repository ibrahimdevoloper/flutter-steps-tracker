import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //TODO: Put Logo Image Here
    return const Scaffold(
      body: Center(child: FlutterLogo(size: 200),),
    );
  }
}
