import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_steps_tracker/core/models/redeem/redeem.dart';
import 'package:flutter_steps_tracker/core/models/steps_number/steps_number.dart';
import 'package:flutter_steps_tracker/core/utilities/custom_snackbar.dart';
import 'package:flutter_steps_tracker/core/utilities/project_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryController extends GetxController {
  var _isRedeemLoading = false;
  var _isStepsNumberLoading = false;
  SharedPreferences pref = Get.find();
  late FirebaseFirestore _db;
  late String _userid;
  final List<Redeem> _redeems = [];
  final List<StepsNumber> _stepsNumbers = [];

  HistoryController() {
    _db = FirebaseFirestore.instance;
    getRedeems();
    getStepsNumber();
  }

  getRedeems() async {
    try {
      _isRedeemLoading = true;
      update();
      _userid = pref.getString(ProjectConstants.userId)!;
      var redeemsDocs = await _db
          .collection("users")
          .doc(_userid)
          .collection("redeems")
          .get();
      for (var redeemsDoc in redeemsDocs.docs) {
        var reward = Redeem.fromJson(redeemsDoc.data());
        _redeems.add(reward);
      }
      _isRedeemLoading = false;
      update();
    } catch (e) {
      showErrorSnakebar("Error while getting data".tr);
      _isRedeemLoading = false;
      update();
    }
  }

  getStepsNumber() async {
    try {
      _isStepsNumberLoading = true;
      update();
      _userid = pref.getString(ProjectConstants.userId)!;
      var stepsNumberDocs = await _db
          .collection("users")
          .doc(_userid)
          .collection("steps_record")
          .orderBy("at_step", descending: true)
          .get();
      for (var stepsNumbersDoc in stepsNumberDocs.docs) {
        var stepsNumber = StepsNumber.fromJson(stepsNumbersDoc.data());
        _stepsNumbers.add(stepsNumber);
      }
      _isStepsNumberLoading = false;
      update();
    } catch (e) {
      showErrorSnakebar("Error while getting data".tr);
      _isStepsNumberLoading = false;
      update();
    }
  }

  List<Redeem> get redeems => _redeems;

  get isRedeemLoading => _isRedeemLoading;

  List<StepsNumber> get stepsNumbers => _stepsNumbers;

  get isStepsNumberLoading => _isStepsNumberLoading;
}
