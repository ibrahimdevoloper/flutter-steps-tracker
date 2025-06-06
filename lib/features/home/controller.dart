import 'package:app_settings/app_settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_steps_tracker/core/mixins/privacy_and_terms_mixin.dart';
import 'package:flutter_steps_tracker/core/models/redeem/redeem.dart';
import 'package:flutter_steps_tracker/core/models/reward/reward.dart';
import 'package:flutter_steps_tracker/core/models/steps_number/steps_number.dart';
import 'package:flutter_steps_tracker/core/models/user_data/user_data.dart';
import 'package:flutter_steps_tracker/core/services/pedometer_service.dart';
import 'package:flutter_steps_tracker/core/utilities/custom_snackbar.dart';
import 'package:flutter_steps_tracker/core/utilities/project_constants.dart';
import 'package:flutter_steps_tracker/features/home/dialogs/confirmation_dialog.dart';
import 'package:flutter_steps_tracker/features/sign_in/view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeController extends GetxController with PrivacyAndTermsMixin {
  final PedometerService _pedometerService = PedometerService();
  static const stepCounterTag = 'stepCounter';
  static const heathPointsTag = 'heathPoints';

  // late SoundService _soundService;

  late FirebaseFirestore _db;
  var _isloading = false;

  late String _userid;
  UserData? _userData;
  final List<UserData> _users = [];
  final List<Reward> _rewards = [];
  int _stepCount = 0;
  int _healthPoints = 0;
  PedestrianStatus? pedoStatus;

  static var main = "main";

  HomeController() {
    _userid = GetStorage().read(ProjectConstants.userId);
    _db = FirebaseFirestore.instance;
    requestPermission().then((value) {
      if (value) getData();
    });
    // getData();
    // _soundService = Get.find();
  }

  @override
  void onReady() {
    var isDarkMode = GetStorage().read(ProjectConstants.userId) ??
        ThemeMode.system == ThemeMode.dark;
    Get.changeThemeMode(isDarkMode ? ThemeMode.light : ThemeMode.dark);
  }

  Future<bool> requestPermission() async {
    var activityRecognitionPermission = Permission.activityRecognition;
    await activityRecognitionPermission.request();

    var status = await activityRecognitionPermission.status;

    if (status.isGranted) {
      print("isGranted: ${status.isGranted}");
      return true;
    } else if ((await activityRecognitionPermission
        .shouldShowRequestRationale)) {
      print(
          "shouldShowRequestRationale: ${await activityRecognitionPermission.shouldShowRequestRationale}");
      await showConfirmationDialog("Enabling Permission".tr,
          "In order to use the app you need to accept the requested permission.\nThis permission is only for counting steps."
              .tr);
      return await requestPermission();
    } else if (status.isPermanentlyDenied || status.isDenied) {
      print("isPermanentlyDenied: ${status.isPermanentlyDenied}");
      var isConfirmed = await showConfirmationDialog("Enabling Permission".tr,
          "In order to use the app you need to accept the requested permission.\nif you accept, you will be redirected to the app setting, otherwise you will sign out."
              .tr);
      if (isConfirmed == true) {
        print("opening app setting");
        await AppSettings.openAppSettings();
        print("closing app setting");
        return await requestPermission();
      } else {
        print("sign out");
        await signOut();
        return false;
      }
    } else {
      return false;
    }
  }

  incrementSteps() {
    _pedometerService.pedestrianStatusStream.listen((event) {
      pedoStatus = event;
    });
    _pedometerService.stepCountStream.listen((event) {
      _stepCount = event.steps;
      if (_stepCount % 20 == 0 &&
          pedoStatus?.status.compareTo("walking") == 0) {
        // _soundService.play();
        _healthPoints++;
        update([heathPointsTag]);
        incrementFirestoreSteps();
        addNewPointSnakebar();
      }
      update([stepCounterTag]);
    });
  }

  incrementFirestoreSteps() async {
    try {
      var userData = _userData;
      userData?.stepCount = stepCount.toDouble();
      userData?.totalPoints = healthPoints.toDouble();
      userData?.remainingPoints =
          userData.totalPoints - userData.redeemedPoints;
      await _db.collection("users").doc(_userid).update(userData!.toJson());
      var stepsNumber = StepsNumber(stepCount.toDouble(),
          Timestamp.now().millisecondsSinceEpoch, 1, null);
      await _db
          .collection("users")
          .doc(_userid)
          .collection("steps_record")
          .add(stepsNumber.toJson());
    } catch (e) {
      _isloading = false;
      update();
    }
  }

  void addNewPointSnakebar() {
    Get.snackbar(
      "New Point".tr,
      "New point were added".tr,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.black38,
      colorText: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      borderRadius: 16,
      duration: const Duration(seconds: 3),
    );
  }

  redeemPoints(Reward reward) async {
    var userDoc = await _db.collection("users").doc(_userid).get();
    var userData = UserData.fromJson(userDoc.data()!);
    var remainingPoints = userData.remainingPoints.toInt();
    if ((remainingPoints - reward.redeemPoints) >= 0) {
      var redeem = Redeem(reward.id ?? reward.brand, reward.brand,
          reward.imageUrl, reward.nameAr, reward.nameEn, reward.redeemPoints);
      userData.redeemedPoints += reward.redeemPoints;
      userData.remainingPoints = remainingPoints - reward.redeemPoints;
      await _db.collection("users").doc(_userid).update(userData.toJson());
      await _db
          .collection("users")
          .doc(_userid)
          .collection('redeems')
          .add(redeem.toJson());
      showNotificationSnakebar("Redeem Successful".tr);
    } else {
      showErrorSnakebar("You don't have enough points".tr,
          title: "Redeem Unsuccessful".tr);
    }
  }

  getData() async {
    try {
      _isloading = true;
      update([main]);
      // _userid = pref.getString(ProjectConstants.userId) ?? "";
      var userDocs = await _db
          .collection("users")
          .limit(3)
          .orderBy("step_count", descending: true)
          .get();
      for (var userDoc in userDocs.docs) {
        _users.add(UserData.fromJson(userDoc.data()));
      }
      var rewardDocs = await _db.collection("rewards").limit(10).get();
      for (var rewardDoc in rewardDocs.docs) {
        _rewards.add(Reward.fromJson(rewardDoc.data()));
      }
      var userDoc = await _db.collection("users").doc(_userid).get();
      _userData = UserData.fromJson(userDoc.data()!);
      _healthPoints = _userData!.totalPoints.toInt();
      _isloading = false;
      update([main]);
      incrementSteps();
    } catch (e) {
      showErrorSnakebar("Error while getting data".tr);
      _isloading = false;
      update([main]);
    }
  }

  signOutDialog() async {
    Get.back();
    var isConfirmed =
        await showConfirmationDialog("Sign Out".tr, "Are you sure?".tr);
    if (isConfirmed == true) {
      await signOut();
    } else {
      Get.back();
      Get.back();
    }
  }

  Future<void> signOut() async {
    GetStorage().remove(ProjectConstants.username);
    GetStorage().remove(ProjectConstants.userId);
    await FirebaseAuth.instance.signOut();
    Get.offAll(() => SignInPage());
  }

  deleteAccountDialog() async {
    Get.back();
    var isConfirmed =
        await showConfirmationDialog("Delete Account".tr, "Are you sure?".tr);
    if (isConfirmed == true) {
      await deleteAccount();
    } else {
      Get.back();
      Get.back();
    }
  }

  Future<void> deleteAccount() async {
    await _db.collection("users").doc(_userid).delete();
    signOut();
  }

  int get stepCount => _stepCount;

  int get healthPoints => _healthPoints;

  List<Reward> get rewards => _rewards;

  List<UserData> get users => _users;

  UserData? get userData => _userData;

  get isloading => _isloading;
}
