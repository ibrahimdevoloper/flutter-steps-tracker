import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_steps_tracker/Models/reward/reward.dart';
import 'package:flutter_steps_tracker/Models/user_data/user_data.dart';
import 'package:flutter_steps_tracker/features/home/Services/pedometer_service.dart';
import 'package:flutter_steps_tracker/utilities/custom_snackbar.dart';
import 'package:flutter_steps_tracker/utilities/project_constants.dart';
import 'package:flutter_steps_tracker/utilities/sound_service.dart';
import 'package:get/get.dart';
import 'package:pedometer/pedometer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soundpool/soundpool.dart';

class HomeController extends GetxController {
  PedometerService _pedometerService = PedometerService();
  static const stepCounterTag = 'stepCounter';
  static const heathPointsTag = 'heathPoints';
  late SoundService _soundService;

  late FirebaseFirestore _db;
  var _isloading = false;
  SharedPreferences pref = Get.find();

  late String _userid;
  UserData? _userData;
  List<UserData> _users = [];
  List<Reward> _rewards = [];
  int _stepCount = 0;
  int _healthPoints = 0;
  PedestrianStatus? pedoStatus= null;

  static var main="main";

  HomeController() {
    _db = FirebaseFirestore.instance;
    getData();
    _soundService = Get.find();
  }

  incrementSteps() {
    _pedometerService.pedestrianStatusStream.listen((event) {
      pedoStatus = event;
    });
    _pedometerService.stepCountStream.listen((event) {
      _stepCount = event.steps;
      print(_stepCount);
      if (_stepCount % 20 == 0 && pedoStatus?.status.compareTo("walking")==0) {
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
      var userData = this._userData;
      userData!.stepCount=stepCount.toDouble();
      userData.totalPoints = healthPoints.toDouble();
          await _db.collection("users").doc(_userid).set(userData.toJson());
          //TODO: send history
    } catch (e) {
      showErrorSnakebar("Error while sending data");
      _isloading = false;
      update();
    }
  }

  void addNewPointSnakebar() {
    Get.snackbar(
      "New Point",
      "New point were added",
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.black38,
      colorText: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      borderRadius: 16,
      duration: Duration(seconds: 3),
    );
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
      showNotificationSnakebar("Sign in Success");
    } catch (e) {
      showErrorSnakebar("Error while getting data");
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
