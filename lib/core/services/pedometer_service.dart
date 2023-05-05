import 'package:pedometer/pedometer.dart';

class PedometerService {
  late Stream<StepCount> stepCountStream;
  late Stream<PedestrianStatus> pedestrianStatusStream;

  PedometerService() {
    pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    stepCountStream = Pedometer.stepCountStream;
  }
}
