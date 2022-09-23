import 'package:flutter/services.dart';
import 'package:flutter_steps_tracker/features/home/Services/pedometer_service.dart';
import 'package:flutter_steps_tracker/utilities/custom_snackbar.dart';
import 'package:flutter_steps_tracker/utilities/sound_service.dart';
import 'package:get/get.dart';
import 'package:soundpool/soundpool.dart';

class HomeController extends GetxController {
  int _stepCount = 0;
  PedometerService _pedometerService = PedometerService();
  static const stepCounterTag = 'stepCounter';
  late SoundService _soundService;

  HomeController() {
    incrementSteps();
    _soundService = Get.find();
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

  int get stepCount => _stepCount;

  set stepCount(int value) {
    _stepCount = value;
  }
}
