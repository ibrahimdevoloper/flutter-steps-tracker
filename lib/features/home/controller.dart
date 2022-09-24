import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter_steps_tracker/features/home/Services/pedometer_service.dart';
import 'package:flutter_steps_tracker/utilities/custom_snackbar.dart';
import 'package:flutter_steps_tracker/utilities/project_constants.dart';
import 'package:flutter_steps_tracker/utilities/sound_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soundpool/soundpool.dart';

class HomeController extends GetxController {
  int _stepCount = 0;
  PedometerService _pedometerService = PedometerService();
  static const stepCounterTag = 'stepCounter';
  late SoundService _soundService;

  late FirebaseFirestore _db;
  var _isloading = false;
  SharedPreferences pref = Get.find();

  late String? _username;

  HomeController() {
    incrementSteps();
    _soundService = Get.find();
    _db = FirebaseFirestore.instance;
  }

  incrementSteps() {
    _pedometerService.stepCountStream.listen((event) {
      _stepCount = event.steps;
      print(_stepCount);
      if (_stepCount % 20 == 0) {
        _soundService.play();
        AddNewPointSnakebar();
      }
      update([stepCounterTag]);
    });
  }

  getData() async {
    try {
      _isloading = true;
      update();
      _username = pref.getString(ProjectConstants.userId);
      var users = await _db.collection("users").limit(3).orderBy("step_count").get();

      _isloading = false;
      update();
      showNotificationSnakebar("Sign in Success");
    } on FirebaseException catch (e) {
      showErrorSnakebar("Error while getting data");
      _isloading = false;
      update();
    }
  }

  int get stepCount => _stepCount;

  set stepCount(int value) {
    _stepCount = value;
  }
}
