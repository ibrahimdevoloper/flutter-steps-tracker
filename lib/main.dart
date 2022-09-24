import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_steps_tracker/features/home/view.dart';
import 'package:flutter_steps_tracker/features/splash/view.dart';
import 'package:flutter_steps_tracker/utilities/sound_service.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/sign_in/view.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
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
            // primaryColor: Color(0xFF5BB318),
            colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: Color(0xFF5BB318),
              secondary: Color(0xFFEAE509),
            ),
            textTheme: GoogleFonts.cairoTextTheme()),
        home: FutureBuilder<List>(
          future: Future.wait([
            Firebase.initializeApp(
              options: DefaultFirebaseOptions.currentPlatform,
            ),
            SharedPreferences.getInstance(),
            Future.delayed(Duration(seconds: 3)),
          ]),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SplashPage();
            } else if (snapshot.hasData) {
              SharedPreferences pref = snapshot.data![1];
              Get.put(pref);

              var soundService = SoundService();
              Get.put(soundService);

              return StreamBuilder<User?>(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (context, snapshot) {
                    SharedPreferences pref = Get.find();
                    var username = pref.getString("username") ?? "";
                    if (snapshot.data == null || username.isEmpty) {
                      return SignInPage();
                    } else {
                      return HomePage();
                    }
                  });
            } else {
              return Scaffold(
                body: Center(
                  child: Text("Error",
                      style: Theme.of(context).textTheme.headline3),
                ),
              );
            }
          },
        ));
  }
}
