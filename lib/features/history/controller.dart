import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_steps_tracker/Models/redeem/redeem.dart';
import 'package:flutter_steps_tracker/Models/steps_number/steps_number.dart';
import 'package:flutter_steps_tracker/utilities/custom_snackbar.dart';
import 'package:flutter_steps_tracker/utilities/project_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryController extends GetxController {
  var _isRedeemLoading = false;
  var _isStepsNumberLoading = false;
  SharedPreferences pref = Get.find();
  late FirebaseFirestore _db;
  late String _userid;
  List<Redeem> _redeems=[];
  List<StepsNumber> _stepsNumbers=[];

  HistoryController(){
    _db = FirebaseFirestore.instance;
  }

  getRedeems() async {
    try {
      _isRedeemLoading = true;
      update();
      _userid = pref.getString(ProjectConstants.userId)!;
      var redeemsDocs = await _db
          .collection("users")
          .doc(_userid)
          .collection("rewards")
          .get();
      for (var redeemsDoc in redeemsDocs.docs) {
        var reward = Redeem.fromJson(redeemsDoc.data());
        _redeems.add(reward);
      }
      _isRedeemLoading = false;
      update();
    } catch (e) {
      showErrorSnakebar("Error while getting data");
      _isRedeemLoading = false;
      update();
    }
  }

  getStepsNumber() async {
    try {
      _isRedeemLoading = true;
      update();
      _userid = pref.getString(ProjectConstants.userId)!;
      var redeemsDocs = await _db
          .collection("users")
          .doc(_userid)
          .collection("steps_record")
          .get();
      for (var redeemsDoc in redeemsDocs.docs) {
        var reward = Redeem.fromJson(redeemsDoc.data());
        _redeems.add(reward);
      }
      _isRedeemLoading = false;
      update();
    } catch (e) {
      showErrorSnakebar("Error while getting data");
      _isRedeemLoading = false;
      update();
    }
  }

  List<Redeem> get redeems => _redeems;

  get isRedeemLoading => _isRedeemLoading;
}
