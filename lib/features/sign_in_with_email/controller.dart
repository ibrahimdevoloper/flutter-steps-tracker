import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_steps_tracker/Models/user_data/user_data.dart';
import 'package:flutter_steps_tracker/features/home/view.dart';
import 'package:flutter_steps_tracker/utilities/custom_snackbar.dart';
import 'package:flutter_steps_tracker/utilities/project_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInWithEmailController extends GetxController {
  String? _email;
  String? _password;

  static const emailTag = "emailTag";
  static const passwordTag = "passwordTag";
  static const registerButtonTag = "registerButtonTag";

  String? _emailErrorMessage;
  String? _passwordErrorMessage;

  bool isPasswordObscure = true;

  late FirebaseAuth _auth;
  late FirebaseFirestore _db;

  var _isloading = false;

  SignInWithEmailController() {
    _auth = Platform.environment.containsKey('FLUTTER_TEST')
        ? MockFirebaseAuth()
        : FirebaseAuth.instance;
    _db = Platform.environment.containsKey('FLUTTER_TEST')
        ? FakeFirebaseFirestore()
        : FirebaseFirestore.instance;
  }

  bool validator() {
    var totalValidation = true;

    if ((_email ?? "").isEmpty) {
      // showErrorSnakebar("E-mail field is empty".tr);
      _emailErrorMessage = "Please, fill this field correctly".tr;
      update([emailTag]);
      totalValidation = false;
    } else if (!EmailValidator.validate(_email ?? "")) {
      // showErrorSnakebar("Incorrect E-mail".tr);
      _emailErrorMessage = "Incorrect E-mail".tr;
      update([emailTag]);
      totalValidation = false;
    }
    if ((_password ?? "").isEmpty) {
      // showErrorSnakebar("Password field is empty".tr);
      _passwordErrorMessage = "Please, fill this field correctly".tr;
      update([passwordTag]);
      totalValidation = false;
    }

    if (!totalValidation) {
      showErrorSnakebar("Please, Fill the form Correctly.".tr);
    }
    return totalValidation;
  }

  void saveUserDataLocally(userDoc, username) {
    SharedPreferences pref = Get.find();
    pref.setString(ProjectConstants.userId, userDoc);
    pref.setString(ProjectConstants.username, username);
  }

  signIn() async {
    try {
      if (validator()) {
        _isloading = true;
        update([registerButtonTag]);
        final userCredential = await _auth.signInWithEmailAndPassword(
          email: _email ?? "",
          password: _password ?? "",
        );
        var userDoc = await _db
            .collection("users")
            .where(
              "user_id",
              isEqualTo: userCredential.user?.uid,
            )
            .withConverter<UserData?>(fromFirestore: (doc, options) {
          UserData? data;
          data = doc.data() != null ? UserData.fromJson(doc.data()!) : null;
          return data;
        }, toFirestore: (data, options) {
          return data?.toJson() ?? {};
        }).get();
        saveUserDataLocally(
            userDoc.docs.first.id, userDoc.docs.first.data()?.name ?? "");
        _isloading = false;
        update([registerButtonTag]);
        Get.offAll(() => HomePage());
        showNotificationSnakebar("Sign in Success".tr);
      } else {
        _isloading = false;
        update([registerButtonTag]);
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          showErrorSnakebar("Auth service is not provided.".tr);
          break;
        default:
          showErrorSnakebar("Unknown error.".tr);
      }
      _isloading = false;
      update([registerButtonTag]);
    }
  }

  switchPasswordObscure() {
    isPasswordObscure = !isPasswordObscure;
    update([passwordTag]);
  }

  get isloading => _isloading;

  set email(String value) {
    _email = value;
    if (_email != null || EmailValidator.validate(value)) {
      _emailErrorMessage = null;
      update([emailTag]);
    }
  }

  set password(String value) {
    _password = value;
    if (_passwordErrorMessage != null) {
      _passwordErrorMessage = null;
      update([passwordTag]);
    }
  }

  set auth(FirebaseAuth value) {
    if (Platform.environment.containsKey('FLUTTER_TEST')) _auth = value;
  }

  set db(FirebaseFirestore value) {
    if (Platform.environment.containsKey('FLUTTER_TEST')) _db = value;
  }

  String? get passwordErrorMessage => _passwordErrorMessage;

  String? get emailErrorMessage => _emailErrorMessage;
}
