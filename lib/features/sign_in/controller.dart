import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_steps_tracker/core/mixins/privacy_and_terms_mixin.dart';
import 'package:flutter_steps_tracker/core/services/firebase_auth_service.dart';
import 'package:flutter_steps_tracker/core/services/firestore_service.dart';
import 'package:flutter_steps_tracker/core/utilities/custom_snackbar.dart';
import 'package:flutter_steps_tracker/core/utilities/project_constants.dart';
import 'package:flutter_steps_tracker/features/home/view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SignInController extends GetxController with PrivacyAndTermsMixin {
  String? _username;

  // final GoogleSignIn _googleSignIn = GoogleSignIn();
  // late FirebaseAuth _auth;

  // late FirebaseFirestore _db;
  late final FirestoreService _firestoreService;
  late final FirebaseAuthService _firebaseAuthService;

  var _isloading = false;

  SignInController() {
    // _auth = FirebaseAuth.instance;
    // _db = FirebaseFirestore.instance;
    _firestoreService = Get.find<FirestoreService>();
    _firebaseAuthService = Get.find<FirebaseAuthService>();
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

  googleLogin() async {
    try {
      _isloading = true;
      update();
      // final selectedGoogleAccount = await _googleSignIn.signIn();
      // if (selectedGoogleAccount == null) {
      //   _isloading = false;
      //   update();
      //   return;
      // }
      // final googleAuth = await selectedGoogleAccount.authentication;
      // final credentials = GoogleAuthProvider.credential(
      //   accessToken: googleAuth.accessToken,
      //   idToken: googleAuth.idToken,
      // );
      // final userCredential = await _auth.signInWithCredential(credentials);
      final selectedGoogleAccount =
          await _firebaseAuthService.signInWithGoogle();
      if (selectedGoogleAccount == null) {
        _isloading = false;
        update();
        return;
      }
      var usersCount = await _firestoreService.getUsersCount(
        uid: selectedGoogleAccount.uid,
      );

      if (usersCount < 1) {
        var userDoc = await _firestoreService.createUser(
          uid: selectedGoogleAccount.uid ?? "",
          email: selectedGoogleAccount.email ?? "",
          displayName: selectedGoogleAccount.displayName ?? "",
        );
        saveUserDataLocally(userDoc.id, selectedGoogleAccount.displayName);
      } else {
        var userData = await _firestoreService.getUserData(
          uid: selectedGoogleAccount.uid ?? "",
        );
        saveUserDataLocally(userData?.docId ?? "", userData?.name ?? "");
      }
      _isloading = false;
      update();
      Get.off(() => HomePage());
      showNotificationSnakebar("Sign in Success".tr);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          showErrorSnakebar("Auth service is not provided.".tr);
          break;
        default:
          showErrorSnakebar("Unknown error.".tr);
      }
      print(e);
      _isloading = false;
      update();
    } catch (e) {
      print(e);
      _isloading = false;
      update();
    }
  }

  void saveUserDataLocally(userDoc, username) {
    GetStorage().write(
      ProjectConstants.userId,
      userDoc,
    );
    GetStorage().write(
      ProjectConstants.username,
      username,
    );
  }

  // signIn() async {
  //   try {
  //     if (validator()) {
  //       if (await Permission.activityRecognition.request().isGranted) {
  //         _isloading = true;
  //         update();
  //         //TODO:check if user already exists in the database
  //         final userCredential = await _auth.signInWithEmailAndPassword(
  //           email: email,
  //           password: password,
  //         );
  //         var userDoc = await _db.collection("users").add({
  //           "user_id": userCredential.user?.uid,
  //           "name": _username,
  //           "created_at": Timestamp.now(),
  //           "updated_at": Timestamp.now(),
  //           "redeemed_points": 0,
  //           "remaining_points": 0,
  //           "step_count": 0,
  //           "total_points": 0,
  //         });
  //         SharedPreferences pref = Get.find();
  //         pref.setString(ProjectConstants.userId, userDoc.id);
  //         pref.setString(ProjectConstants.username, _username!);
  //         _isloading = false;
  //         update();
  //         Get.off(() => HomePage());
  //         showNotificationSnakebar("Sign in Success".tr);
  //       } else {
  //         showErrorSnakebar("Permission Not Accepted".tr);
  //       }
  //     } else {
  //       _isloading = false;
  //       update();
  //       showErrorSnakebar("Username is empty".tr);
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     switch (e.code) {
  //       case "operation-not-allowed":
  //         showErrorSnakebar("Auth service is not provided.".tr);
  //         break;
  //       default:
  //         showErrorSnakebar("Unknown error.".tr);
  //     }
  //     _isloading = false;
  //     update();
  //   }
  // }

  get isloading => _isloading;

  String get username => _username!;

  set username(String value) {
    _username = value;
    update();
  }
}
