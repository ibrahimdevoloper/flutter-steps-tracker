import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_steps_tracker/Models/redeem/redeem.dart';
import 'package:flutter_steps_tracker/Models/reward/reward.dart';
import 'package:flutter_steps_tracker/Models/user_data/user_data.dart';
import 'package:flutter_steps_tracker/utilities/custom_snackbar.dart';
import 'package:flutter_steps_tracker/utilities/project_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OurRewardsController extends GetxController {
  late FirebaseFirestore _db;
  var _isloading = false;

  late String _userid;
  SharedPreferences pref = Get.find();

  List<Reward> _rewards = [];

  OurRewardsController() {
    _db = FirebaseFirestore.instance;
    getData();
  }

  redeemPoints(Reward reward) async {
    _userid = pref.getString(ProjectConstants.userId)!;
    var userDoc = await _db.collection("users").doc(_userid).get();
    var userData = UserData.fromJson(userDoc.data()!);
    var remainingPoints = userData.remainingPoints.toInt();
    if ((remainingPoints - reward.redeemPoints) >= 0) {
      var redeem = Redeem(reward.id??reward.brand, reward.brand, reward.imageUrl,
          reward.nameAr, reward.nameEn, reward.redeemPoints);
      userData.redeemedPoints += reward.redeemPoints;
      userData.remainingPoints = remainingPoints - reward.redeemPoints;
      await _db.collection("users").doc(_userid).update(userData.toJson());
      await _db
          .collection("users")
          .doc(_userid)
          .collection('redeems')
          .add(redeem.toJson());
      showNotificationSnakebar("Redeem Successful");
    }else{
      showErrorSnakebar("You don't have enough points",title: "Redeem Unsuccessful");
    }
  }

  getData() async {
    try {
      _isloading = true;
      update();
      var rewardDocs = await _db.collection("rewards").get();
      for (var rewardDoc in rewardDocs.docs) {
        var reward = Reward.fromJson(rewardDoc.data());
        reward.id = rewardDoc.id;
        _rewards.add(reward);
      }
      _isloading = false;
      update();
    } catch (e) {
      showErrorSnakebar("Error while getting data");
      _isloading = false;
      update();
    }
  }

  List<Reward> get rewards => _rewards;

  get isloading => _isloading;
}
