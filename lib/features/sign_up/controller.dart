import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_steps_tracker/core/utilities/custom_snackbar.dart';
import 'package:flutter_steps_tracker/core/utilities/project_constants.dart';
import 'package:flutter_steps_tracker/features/home/view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SignUpController extends GetxController {
  String? _fullName;
  String? _email;
  String? _password;
  String? _confirmPassword;

  static const fullNameTag = "fullNameTag";
  static const emailTag = "emailTag";
  static const passwordTag = "passwordTag";
  static const confirmPasswordTag = "confirmPasswordTag";
  static const registerButtonTag = "registerButtonTag";

  String? _fullNameErrorMessage;
  String? _emailErrorMessage;
  String? _passwordErrorMessage;
  String? _confirmPasswordErrorMessage;

  bool isPasswordObscure = true;
  bool isConfirmPasswordObscure = true;

  late FirebaseAuth _auth;
  late FirebaseFirestore _db;

  var _isloading = false;

  SignUpController() {
    _auth = Platform.environment.containsKey('FLUTTER_TEST')
        ? MockFirebaseAuth()
        : FirebaseAuth.instance;
    _db = Platform.environment.containsKey('FLUTTER_TEST')
        ? FakeFirebaseFirestore()
        : FirebaseFirestore.instance;
  }

  bool validator() {
    var totalValidation = true;
    if ((_fullName ?? "").isEmpty) {
      // showErrorSnakebar("Full Name field is empty".tr);
      _fullNameErrorMessage = "Please, fill this field correctly".tr;
      update([fullNameTag]);
      totalValidation = false;
    }
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
    if ((_confirmPassword ?? "").isEmpty) {
      // showErrorSnakebar("Confirm Password field is empty".tr);
      _confirmPasswordErrorMessage = "Please, fill this field correctly".tr;
      update([confirmPasswordTag]);
      totalValidation = false;
    }
    if (!passwordValidator()) {
      // showErrorSnakebar("Password fields do NOT match".tr);
      _confirmPasswordErrorMessage = "Please, fill this field correctly".tr;
      update([confirmPasswordTag]);
      totalValidation = false;
    }

    if (!totalValidation) {
      showErrorSnakebar("Please, Fill the form Correctly.".tr);
    }
    return totalValidation;
  }

  bool passwordValidator() {
    return (_password ?? "") == (_confirmPassword ?? "");
  }

  void saveUserDataLocally(userDoc, username) {
    GetStorage().write(ProjectConstants.userId, userDoc);
    GetStorage().write(ProjectConstants.username, username);
  }

  signUp() async {
    try {
      if (validator()) {
        _isloading = true;
        update([registerButtonTag]);
        final userCredential = await _auth.createUserWithEmailAndPassword(
          email: _email ?? "",
          password: _password ?? "",
        );
        var userDoc = await _db.collection("users").add({
          "user_id": userCredential.user?.uid,
          "email": _email,
          "name": _fullName,
          "created_at": Timestamp.now(),
          "updated_at": Timestamp.now(),
          "redeemed_points": 0,
          "remaining_points": 0,
          "step_count": 0,
          "total_points": 0,
        });
        saveUserDataLocally(userDoc.id, _fullName);
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

  switchConfirmPasswordObscure() {
    isConfirmPasswordObscure = !isConfirmPasswordObscure;
    update([confirmPasswordTag]);
  }

  get isloading => _isloading;

  set fullName(String value) {
    _fullName = value;
    if (_fullNameErrorMessage != null) {
      _fullNameErrorMessage = null;
      update([fullNameTag]);
    }
  }

  set email(String value) {
    _email = value;
    if (_emailErrorMessage != null || EmailValidator.validate(value)) {
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

  set confirmPassword(String value) {
    _confirmPassword = value;
    if (_confirmPasswordErrorMessage != null || passwordValidator()) {
      _confirmPasswordErrorMessage = null;
      update([confirmPasswordTag]);
    }
  }

  set auth(FirebaseAuth value) {
    if (Platform.environment.containsKey('FLUTTER_TEST')) _auth = value;
  }

  set db(FirebaseFirestore value) {
    if (Platform.environment.containsKey('FLUTTER_TEST')) _db = value;
  }

  String? get confirmPasswordErrorMessage => _confirmPasswordErrorMessage;

  String? get passwordErrorMessage => _passwordErrorMessage;

  String? get emailErrorMessage => _emailErrorMessage;

  String? get fullNameErrorMessage => _fullNameErrorMessage;
}
