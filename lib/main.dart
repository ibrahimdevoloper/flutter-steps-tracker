import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_steps_tracker/features/home/view.dart';
import 'package:flutter_steps_tracker/features/splash/view.dart';
import 'package:flutter_steps_tracker/utilities/project_constants.dart';
import 'package:flutter_steps_tracker/utilities/sound_service.dart';
import 'package:flutter_steps_tracker/utilities/translation.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/sign_in/view.dart';
import 'firebase_options.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        translations: Messages(),
        locale: Get.deviceLocale,
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          colorScheme: ColorScheme.fromSwatch().copyWith(
            brightness: Brightness.dark,
            primary: const Color(0xFF5BB318),
            secondary: const Color(0xFFEAE509),
          ),
          textTheme: GoogleFonts.cairoTextTheme(),
        ),
        theme: ThemeData(
            brightness: Brightness.light,
            colorScheme: ColorScheme.fromSwatch().copyWith(
              brightness: Brightness.light,
              primary: const Color(0xFF5BB318),
              secondary: const Color(0xFFEAE509),
            ),
            textTheme: GoogleFonts.cairoTextTheme()),
        home: FutureBuilder<List>(
          future: Future.wait([
            Firebase.initializeApp(
              options: DefaultFirebaseOptions.currentPlatform,
            ),
            SharedPreferences.getInstance(),
            Future.delayed(const Duration(seconds: 3)),
          ]),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SplashPage();
            } else if (snapshot.hasData) {
              SharedPreferences pref = snapshot.data![1];
              Get.put(pref);

              // var localeLang = pref.getString(ProjectConstants.isArabic)??"en";
              // var locale = Locale(localeLang);
              // Get.updateLocale(locale);

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
                      style: Theme.of(context).textTheme.displaySmall),
                ),
              );
            }
          },
        ));
  }

  changeToDefaultLocale() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var localeLang = pref.getString(ProjectConstants.isArabic) ?? "en";
    var locale = Locale(localeLang);
    await Get.updateLocale(locale);
  }
}
