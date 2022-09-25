import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_steps_tracker/features/home/view.dart';
import 'package:flutter_steps_tracker/utilities/custom_snackbar.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_steps_tracker/utilities/project_constants.dart';

class SignInController extends GetxController {
  String? _username;
  late FirebaseAuth _auth;
  late FirebaseFirestore _db;

  var _isloading = false;

  SignInController() {
    _auth = FirebaseAuth.instance;
    _db = FirebaseFirestore.instance;
  }

  validator() {
    if (_username != null) {
      if (_username!.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  requestPermission(){

  }

  SignIn() async {
    try {
      if(validator()) {
        if (await Permission.activityRecognition.request().isGranted) {
          _isloading=true;
          update();
          final userCredential = await _auth.signInAnonymously();
          //TODO: USERDATA CLASS
          var userDoc = await _db.collection("users").add({
            "user_id":userCredential.user?.uid,
            "name":_username,
            "created_at":Timestamp.now(),
            "updated_at":Timestamp.now(),
            "redeemed_points":0,
            "remaining_points":0,
            "step_count":0,
            "total_points":0,
          });
          SharedPreferences pref = Get.find();
          pref.setString(ProjectConstants.userId, userDoc.id);
          pref.setString(ProjectConstants.username, _username!);
          _isloading=false;
          update();
          Get.off(() => HomePage());
          showNotificationSnakebar("Sign in Success");
        }else {
          showErrorSnakebar("Permission Not Accepted");
        }
      }else{
        _isloading=false;
        update();
        showErrorSnakebar("Username is empty");
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          showErrorSnakebar("Auth service is not provided.");
          break;
        default:
          showErrorSnakebar("Unknown error.");
      }
      _isloading=false;
      update();
    }
  }

  get isloading => _isloading;

  String get username => _username!;

  set username(String value) {
    _username = value;
    update();
  }
}
