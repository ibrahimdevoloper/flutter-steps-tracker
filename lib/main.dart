import 'package:flutter/material.dart';
import 'package:flutter_steps_tracker/features/splash/view.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder<List>(
          future: Future.wait([
            Firebase.initializeApp(
              options: DefaultFirebaseOptions.currentPlatform,
            ),
            SharedPreferences.getInstance(),
            Future.delayed(Duration(seconds: 3)),
          ]),
          builder: (context, snapshot) {
            if(snapshot.connectionState==ConnectionState.waiting){
              return SplashPage();
            }else if(snapshot.hasData){
              SharedPreferences pref = snapshot.data![1];
              Get.put(pref);

            }else{
              return Scaffold(
                body: Center(
                  child: Text("Error",style: Theme.of(context).textTheme.headline3),
                ),
              );
            }
          },
        ));
  }
}
