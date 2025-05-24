// test the FirebaseAuthService class

import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_steps_tracker/core/services/firebase_auth_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';

main() {
  group('FirebaseAuthService', () {
    late FirebaseAuthService _firebaseAuthService;
    late MockFirebaseAuth _auth;
    late MockGoogleSignIn _googleSignIn;

    setUp(() {
      final user = MockUser(
        isAnonymous: false,
        uid: 'someuid',
        email: 'bob@somedomain.com',
        displayName: 'Bob',
      );
      _auth = MockFirebaseAuth(mockUser: user);
      _googleSignIn = MockGoogleSignIn();
      _firebaseAuthService = FirebaseAuthService(_auth, _googleSignIn);
    });

    //test for signInWithGoogle
    test('signInWithGoogle', () async {
      var user = await _firebaseAuthService.signInWithGoogle();
      expect(user, isNotNull);
    });

    //test for signInWithGoogle with null
    // test('signInWithGoogle with null', () async {
    //   var user = await _firebaseAuthService.signInWithGoogle();
    //   expect(user, isNull);
    // });
  });
}
