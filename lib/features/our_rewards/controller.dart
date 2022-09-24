import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_steps_tracker/Models/reward/reward.dart';
import 'package:flutter_steps_tracker/utilities/custom_snackbar.dart';
import 'package:get/get.dart';

class OurRewardsController extends GetxController {
  late FirebaseFirestore _db;
  var _isloading = false;

  List<Reward> _rewards = [];

  OurRewardsController() {
    _db = FirebaseFirestore.instance;
    getData();
  }

  getData() async {
    try {
      _isloading = true;
      update();
      var rewardDocs = await _db
          .collection("rewards")
          .get();
      for (var rewardDoc in rewardDocs.docs) {
        _rewards.add(Reward.fromJson(rewardDoc.data()));
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
