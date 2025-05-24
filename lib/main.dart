import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_steps_tracker/core/models/version_information/version_information.dart';
import 'package:flutter_steps_tracker/core/services/firebase_auth_service.dart';
import 'package:flutter_steps_tracker/core/services/firestore_service.dart';
import 'package:flutter_steps_tracker/core/utilities/project_constants.dart';
import 'package:flutter_steps_tracker/core/utilities/translation.dart';
import 'package:flutter_steps_tracker/features/home/view.dart';
import 'package:flutter_steps_tracker/features/splash/view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/sign_in/view.dart';
import 'firebase_options.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      future: Future.wait([
        SharedPreferences.getInstance(),
        getLatestVersionCode(),
        Future.delayed(const Duration(seconds: 3)),
      ]),
      builder: (context, snapshot) {
        VersionInformation? versionInformation;
        if (snapshot.hasData) {
          SharedPreferences pref = snapshot.data![0];
          versionInformation = snapshot.data![1];
          Get.put(pref);
          Get.put(FirestoreService(FirebaseFirestore.instance));
          Get.put(FirebaseAuthService(FirebaseAuth.instance, GoogleSignIn()));

          // var soundService = SoundService();
          // Get.put(soundService);
        } else if (snapshot.hasError) {
          print(snapshot.error);
        }

        return MainMaterialApp(
            child: (versionInformation?.isMandatory ?? false)
                ? VersionBlockPage(versionInformation: versionInformation!)
                : snapshot.hasData
                    ? const UserStreamBuilder()
                    : snapshot.connectionState == ConnectionState.waiting
                        ? const SplashPage()
                        : const DefaultErrorWidget());
      },
    );
  }

  changeToDefaultLocale() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var localeLang = pref.getString(ProjectConstants.isArabic) ?? "en";
    var locale = Locale(localeLang);
    await Get.updateLocale(locale);
  }

  Future<VersionInformation?> getLatestVersionCode() async {
    final info = await PackageInfo.fromPlatform();
    var currentVersionNumber = info.buildNumber;
    VersionInformation? versionInformation;
    var versionInformationQuary = await FirebaseFirestore.instance
        .collection("versions")
        .limit(1)
        .where("version_number",
            isGreaterThan: int.tryParse(currentVersionNumber) ?? 1)
        .orderBy("version_number", descending: true)
        .withConverter<VersionInformation?>(
          fromFirestore: (snapshot, options) => snapshot.data() != null
              ? VersionInformation.fromJson(snapshot.data()!)
              : null,
          toFirestore: (value, options) => {},
        )
        .get();
    if (versionInformationQuary.docs.isNotEmpty) {
      versionInformation = versionInformationQuary.docs.first.data();
    }
    return versionInformation;
  }
}

class DefaultErrorWidget extends StatelessWidget {
  const DefaultErrorWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Error", style: Theme.of(context).textTheme.displaySmall),
      ),
    );
  }
}

class UserStreamBuilder extends StatelessWidget {
  const UserStreamBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          SharedPreferences pref = Get.find();
          var username = pref.getString(ProjectConstants.username) ?? "";
          if (snapshot.data == null || username.isEmpty) {
            return SignInPage();
          } else {
            return HomePage();
          }
        });
  }
}

class MainMaterialApp extends StatelessWidget {
  final Widget child;

  const MainMaterialApp({super.key, required this.child});

  ThemeMode _getThemeMode() {
    final box = Get.find<SharedPreferences>();
    final isDarkMode = box.getBool('isDarkMode');
    if (isDarkMode == null) {
      return ThemeMode.system;
    }
    return isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        translations: Messages(),
        //TODO: get the user's preferred language from GetStorage.
        locale: Get.deviceLocale,
        //TODO: get the user's preferred theme from GetStorage.
        themeMode: ThemeMode.dark,
        // themeMode: _getThemeMode(),
        darkTheme: ThemeData(
          scaffoldBackgroundColor: Colors.grey[800],
          dialogTheme: DialogTheme(
            backgroundColor: Colors.grey[800],
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            titleTextStyle: GoogleFonts.cairo(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
            contentTextStyle: GoogleFonts.cairo(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          brightness: Brightness.dark,
          colorScheme: ColorScheme.fromSwatch().copyWith(
            brightness: Brightness.dark,
            primary: const Color(0xFF5BB318),
            secondary: const Color(0xFFEAE509),
          ),
          textTheme: GoogleFonts.cairoTextTheme(
              ThemeData(brightness: Brightness.dark).textTheme),
        ),
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.white60,
            brightness: Brightness.light,
            dialogTheme: DialogTheme(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            colorScheme: ColorScheme.fromSwatch().copyWith(
              brightness: Brightness.light,
              primary: const Color(0xFF5BB318),
              secondary: const Color(0xFFEAE509),
            ),
            textTheme: GoogleFonts.cairoTextTheme()),
        home: child);
  }
}

class VersionBlockPage extends StatelessWidget {
  final VersionInformation versionInformation;
  late List<String> features;
  late List<String> bugFixes;

  VersionBlockPage({
    super.key,
    required this.versionInformation,
  }) {
    features = Get.locale?.languageCode == "ar"
        ? versionInformation.newFeaturesAr
        : versionInformation.newFeaturesEn;
    bugFixes = Get.locale?.languageCode == "ar"
        ? versionInformation.bugFixesAr
        : versionInformation.bugFixesEn;
  }

  // _launchURL(String url) async {
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   }
  //   else {
  //     showErrorSnakebar(message)
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Version ${versionInformation.versionName}',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(
                  Icons.warning,
                  color: Colors.red,
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    'This version contains important changes. Please update to the latest version.',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              'Release Date: ${versionInformation.releaseDate}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              Get.locale?.languageCode == "ar"
                  ? versionInformation.descriptionAr
                  : versionInformation.descriptionEn,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'New Features:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            for (var feature in features) Text('• $feature'),
            SizedBox(height: 16.0),
            Text(
              'Bug Fixes:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            for (var bugFix in bugFixes) Text('• $bugFix'),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Redirect to app store link
              },
              child: Text('Update Now'),
            ),
          ],
        ),
      ),
    );
  }
}
