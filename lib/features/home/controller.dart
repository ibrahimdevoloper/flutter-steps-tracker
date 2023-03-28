import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_steps_tracker/Models/redeem/redeem.dart';
import 'package:flutter_steps_tracker/Models/reward/reward.dart';
import 'package:flutter_steps_tracker/Models/steps_number/steps_number.dart';
import 'package:flutter_steps_tracker/Models/user_data/user_data.dart';
import 'package:flutter_steps_tracker/features/home/Services/pedometer_service.dart';
import 'package:flutter_steps_tracker/utilities/custom_snackbar.dart';
import 'package:flutter_steps_tracker/utilities/project_constants.dart';
import 'package:flutter_steps_tracker/utilities/sound_service.dart';
import 'package:get/get.dart';
import 'package:pedometer/pedometer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  final PedometerService _pedometerService = PedometerService();
  static const stepCounterTag = 'stepCounter';
  static const heathPointsTag = 'heathPoints';
  late SoundService _soundService;

  late FirebaseFirestore _db;
  var _isloading = false;
  SharedPreferences pref = Get.find();

  late String _userid;
  UserData? _userData;
  final List<UserData> _users = [];
  final List<Reward> _rewards = [];
  int _stepCount = 0;
  int _healthPoints = 0;
  PedestrianStatus? pedoStatus;

  static var main = "main";

  HomeController() {
    _db = FirebaseFirestore.instance;
    getData();
    _soundService = Get.find();
  }

  @override
  void onReady() {
    var isDarkMode = pref.getBool(ProjectConstants.isDarkMode) ??
        ThemeMode.system == ThemeMode.dark;
    Get.changeThemeMode(isDarkMode ? ThemeMode.light : ThemeMode.dark);
  }

  incrementSteps() {
    _pedometerService.pedestrianStatusStream.listen((event) {
      pedoStatus = event;
    });
    _pedometerService.stepCountStream.listen((event) {
      _stepCount = event.steps;
      if (_stepCount % 20 == 0 &&
          pedoStatus?.status.compareTo("walking") == 0) {
        _soundService.play();
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
      userData!.stepCount = stepCount.toDouble();
      userData.totalPoints = healthPoints.toDouble();
      userData.remainingPoints = userData.totalPoints - userData.redeemedPoints;
      await _db.collection("users").doc(_userid).update(userData.toJson());
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
    _userid = pref.getString(ProjectConstants.userId)!;
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
      _userid = pref.getString(ProjectConstants.userId)!;
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

  int get stepCount => _stepCount;

  int get healthPoints => _healthPoints;

  List<Reward> get rewards => _rewards;

  List<UserData> get users => _users;

  UserData get userData => _userData!;

  get isloading => _isloading;
}
