import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_steps_tracker/core/models/user_data/user_data.dart';
import 'package:flutter_steps_tracker/core/utilities/custom_snackbar.dart';
import 'package:get/get.dart';

class LeaderboardController extends GetxController {
  late FirebaseFirestore _db;
  var _isloading = false;

  final List<UserData> _users = [];

  LeaderboardController() {
    _db = FirebaseFirestore.instance;
    getData();
  }

  getData() async {
    try {
      _isloading = true;
      update();
      var userDocs = await _db
          .collection("users")
          .orderBy("step_count", descending: true)
          .get();
      for (var userDoc in userDocs.docs) {
        _users.add(UserData.fromJson(userDoc.data()));
      }
      _isloading = false;
      update();
    } catch (e) {
      showErrorSnakebar("Error while getting data".tr);
      _isloading = false;
      update();
    }
  }

  List<UserData> get users => _users;

  get isloading => _isloading;
}
