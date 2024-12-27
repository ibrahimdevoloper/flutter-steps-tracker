import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_steps_tracker/core/models/user_data/user_data.dart';

class FirestoreService {
  final FirebaseFirestore _db;

  FirestoreService(this._db);

  Future<int> getUsersCount({required String? uid}) async {
    var usersCount = await _db
        .collection("users")
        .where(
          "user_id",
          isEqualTo: uid,
        )
        .count()
        .get();
    return usersCount.count ?? 0;
  }

  Future createUser({
    required String uid,
    required String email,
    required String displayName,
  }) async {
    var userDoc = await _db.collection("users").add({
      "user_id": uid,
      "email": email,
      "name": displayName,
      "created_at": Timestamp.now(),
      "updated_at": Timestamp.now(),
      "redeemed_points": 0,
      "remaining_points": 0,
      "step_count": 0,
      "total_points": 0,
    });
    return userDoc;
  }

  Future<UserData?> getUserData({String? uid}) async {
    var doc = await _db
        .collection("users")
        .where(
          "user_id",
          isEqualTo: uid,
        )
        .withConverter<UserData?>(fromFirestore: (doc, options) {
      UserData? data;
      data = doc.data() != null ? UserData.fromJson(doc.data()!) : null;
      return data;
    }, toFirestore: (data, options) {
      return data?.toJson() ?? {};
    }).get();
    if (doc.docs.isNotEmpty) {
      UserData? user = doc.docs.first.data();
      user!.docId = doc.docs.first.id;
      return user;
    } else {
      return null;
    }
  }
}
