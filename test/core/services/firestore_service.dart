//write a test for the FirestoreService class
//write a test for the FirestoreService class

import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_steps_tracker/core/services/firestore_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FirestoreService', () {
    late FirestoreService _firestoreService;

    setUp(() {
      _firestoreService = FirestoreService(FakeFirebaseFirestore());
    });

    //test for createUser
    test('createUser', () async {
      var userDoc = await _firestoreService.createUser(
        uid: '123',
        email: '',
        displayName: '',
      );
      expect(userDoc, isNotNull);
    });

    //test for getUsersCount with empty collections
    test('getUsersCount with empty collections', () async {
      var usersCount = await _firestoreService.getUsersCount(uid: '123');
      expect(usersCount, 0);
    });

    //test for getUsersCount with non-empty collections
    test('getUsersCount with non-empty collections', () async {
      await _firestoreService.createUser(
        uid: '123',
        email: '',
        displayName: '',
      );
      var usersCount = await _firestoreService.getUsersCount(uid: '123');
      expect(usersCount, 1);
    });

    //test for getUserData with empty collections
    test('getUserData ', () async {
      var userData = await _firestoreService.getUserData(uid: '123');
      expect(userData, isNull);
    });

    //test for getUserData with non-empty collections
    test('getUserData with non-empty collections', () async {
      await _firestoreService.createUser(
        uid: '123',
        email: '',
        displayName: '',
      );
      var userData = await _firestoreService.getUserData(uid: '123');
      expect(userData, isNotNull);
    });
  });
}
