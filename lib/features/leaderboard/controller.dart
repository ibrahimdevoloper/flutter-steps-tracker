import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_steps_tracker/Models/user_data/user_data.dart';
import 'package:flutter_steps_tracker/utilities/custom_snackbar.dart';
import 'package:get/get.dart';

class LeaderboardController extends GetxController {
  late FirebaseFirestore _db;
  var _isloading = false;

  List<UserData> _users = [];

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
      showNotificationSnakebar("Sign in Success");
    } catch (e) {
      showErrorSnakebar("Error while getting data");
      _isloading = false;
      update();
    }
  }

  List<UserData> get users => _users;

  get isloading => _isloading;
}
