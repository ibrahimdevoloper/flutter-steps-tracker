import 'package:pedometer/pedometer.dart';

class PedometerService {

  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  PedometerService() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _stepCountStream =  Pedometer.stepCountStream;
  }

  Stream<PedestrianStatus> get pedestrianStatusStream =>
      _pedestrianStatusStream;

  set pedestrianStatusStream(Stream<PedestrianStatus> value) {
    _pedestrianStatusStream = value;
  }

  Stream<StepCount> get stepCountStream => _stepCountStream;

  set stepCountStream(Stream<StepCount> value) {
    _stepCountStream = value;
  }
}