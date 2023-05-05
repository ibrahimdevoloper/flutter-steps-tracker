import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_steps_tracker/core/models/privacy_and_terms/privacy_and_terms.dart';
import 'package:flutter_steps_tracker/features/html_display_page/view.dart';
import 'package:get/get.dart';

mixin PrivacyAndTermsMixin on GetxController {
  FirebaseFirestore _db = Platform.environment.containsKey('FLUTTER_TEST')
      ? FakeFirebaseFirestore()
      : FirebaseFirestore.instance;

  goToPrivacyPolicy() async {
    var privacyPolicies = await _db
        .collection("policies")
        .limit(1)
        .orderBy("created_at", descending: true)
        .withConverter<PrivacyAndTerms>(
            fromFirestore: _fromFirestore, toFirestore: _toFirestore)
        .get();
    var privacyPolicy = privacyPolicies.docs[0].data();
    if (Get.locale?.languageCode == "ar") {
      Get.to(HtmlDisplayPagePage(
          title: privacyPolicy.titleAr, content: privacyPolicy.contentAr));
    } else {
      Get.to(HtmlDisplayPagePage(
          title: privacyPolicy.titleEn, content: privacyPolicy.contentEn));
    }
  }

  goToTermsAndCondition() async {
    var terms = await _db
        .collection("terms")
        .limit(1)
        .orderBy("created_at", descending: true)
        .withConverter<PrivacyAndTerms>(
            fromFirestore: _fromFirestore, toFirestore: _toFirestore)
        .get();
    var term = terms.docs[0].data();
    if (Get.locale?.languageCode == "ar") {
      Get.to(HtmlDisplayPagePage(title: term.titleAr, content: term.contentAr));
    } else {
      Get.to(HtmlDisplayPagePage(title: term.titleEn, content: term.contentEn));
    }
  }

  PrivacyAndTerms _fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    return PrivacyAndTerms.fromJson(snapshot.data()!);
  }

  Map<String, Object?> _toFirestore(
      PrivacyAndTerms value, SetOptions? options) {
    return value.toJson();
  }
}
