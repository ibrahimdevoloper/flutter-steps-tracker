import 'package:flutter_steps_tracker/features/home/Services/pedometer_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {

  int _stepCount =0;
  PedometerService _pedometerService = PedometerService();
  static const stepCounterTag= 'stepCounter';


  HomeController(){
    incrementSteps();
  }

  incrementSteps(){
    _pedometerService.stepCountStream.listen((event) {
      _stepCount = event.steps;
      print(_stepCount);
      update([stepCounterTag]);
    });
  }

  int get stepCount => _stepCount;

  set stepCount(int value) {
    _stepCount = value;
  }
}
