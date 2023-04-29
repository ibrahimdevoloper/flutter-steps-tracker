import 'package:flutter/material.dart';
import 'package:flutter_steps_tracker/features/sign_up/controller.dart';
import 'package:flutter_steps_tracker/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());

  group("Testing the password validation function", () {
    test('All fields are filled and correct.', () {
      var controller = SignUpController();
      controller.fullName = 'John Doe';
      controller.email = 'johndoe@example.com';
      controller.password = 'password123';
      controller.confirmPassword = 'password123';
      expect(controller.passwordValidator(), true);
    });
    test('Password field is empty', () {
      var controller = SignUpController();
      controller.fullName = 'John Doe';
      controller.email = 'johndoe@example.com';
      controller.password = '';
      controller.confirmPassword = 'password123';

      expect(controller.passwordValidator(), false);
    });
    test('Passwords are not equal', () {
      var controller = SignUpController();
      controller.fullName = 'John Doe';
      controller.email = 'johndoe@example.com';
      controller.password = '45554';
      controller.confirmPassword = 'password123';

      expect(controller.passwordValidator(), false);
    });
  });
  group("Testing the validation function", () {
    test('All fields are filled and correct.', () {
      var controller = SignUpController();
      controller.fullName = 'John Doe';
      controller.email = 'johndoe@example.com';
      controller.password = 'password123';
      controller.confirmPassword = 'password123';
      expect(controller.validator(), true);
    });
    test('Full Name field is empty', () {
      var controller = SignUpController();
      controller.fullName = '';
      controller.email = 'johndoe@example.com';
      controller.password = 'password123';
      controller.confirmPassword = 'password123';

      expect(controller.validator(), false);
      expect(
          controller.fullNameErrorMessage, 'Please, fill this field correctly');
    });
    test('E-mail field is empty', () {
      var controller = SignUpController();
      controller.fullName = 'John Doe';
      controller.email = '';
      controller.password = 'password123';
      controller.confirmPassword = 'password123';

      expect(controller.validator(), false);
      expect(controller.emailErrorMessage, 'Please, fill this field correctly');
    });
    test('Incorrect E-mail', () {
      var controller = SignUpController();
      controller.fullName = 'John Doe';
      controller.email = 'johndoexample.com';
      controller.password = 'password123';
      controller.confirmPassword = 'password123';

      expect(controller.validator(), false);
      expect(controller.emailErrorMessage, 'Incorrect E-mail');
    });
    test('Password field is empty', () {
      var controller = SignUpController();
      controller.fullName = 'John Doe';
      controller.email = 'johndoe@example.com';
      controller.password = '';
      controller.confirmPassword = 'password123';

      expect(controller.validator(), false);
      expect(
          controller.passwordErrorMessage, 'Please, fill this field correctly');
    });
    test('Confirm Password field is empty', () {
      var controller = SignUpController();
      controller.fullName = 'John Doe';
      controller.email = 'johndoe@example.com';
      controller.password = 'password123';
      controller.confirmPassword = '';

      expect(controller.validator(), false);
      expect(controller.confirmPasswordErrorMessage,
          'Please, fill this field correctly');
    });
    test('Password fields do NOT match', () {
      var controller = SignUpController();
      controller.fullName = 'John Doe';
      controller.email = 'johndoe@example.com';
      controller.password = 'password123';
      controller.confirmPassword = 'password';

      expect(controller.validator(), false);
      expect(controller.confirmPasswordErrorMessage,
          'Please, fill this field correctly');
    });
    test('Some fields are filled and others are incorrect.', () {
      var controller = SignUpController();
      controller.fullName = 'John Doe';
      controller.email = 'johndoe';
      controller.password = 'password123';
      controller.confirmPassword = 'password321';
      expect(
        controller.validator(),
        false,
      );
      expect(controller.fullNameErrorMessage, null);
      expect(controller.emailErrorMessage, 'Incorrect E-mail');
      expect(controller.passwordErrorMessage, null);
      expect(controller.confirmPasswordErrorMessage,
          'Please, fill this field correctly');
    });

    test('Some fields are filled and others are empty.', () {
      var controller = SignUpController();
      controller.fullName = 'John Doe';
      controller.email = "";
      controller.password = 'password123';
      controller.confirmPassword = "";
      expect(
        controller.validator(),
        false,
      );
      expect(controller.fullNameErrorMessage, null);
      expect(controller.emailErrorMessage, 'Please, fill this field correctly');
      expect(controller.passwordErrorMessage, null);
      expect(controller.confirmPasswordErrorMessage,
          'Please, fill this field correctly');
    });
  });
  // group("Testing the SignUp function", () {
  //   test('All fields are filled and correct.', () {
  //     final mockAuth = MockFirebaseAuth(
  //         mockUser: MockUser(
  //       email: 'johndoe@example.com',
  //       displayName: 'John Doe',
  //     ));
  //     final mockdb = FakeFirebaseFirestore();
  //
  //     var controller = SignUpController();
  //     when(() => mockAuth.createUserWithEmailAndPassword(email: 'johndoe@example.com', password: "12345674")).thenAnswer((_)=>"signUP");
  //     controller.auth = mockAuth;
  //     controller.db = mockdb;
  //
  //     controller.fullName = 'John Doe';
  //     controller.email = 'johndoe@example.com';
  //     controller.password = 'password123';
  //     controller.confirmPassword = 'password123';
  //
  //     controller.signUp();
  //
  //     verify(() => controller.signUp()).called(1);
  //   });
  //   test('Password field is empty', () {
  //     var controller = SignUpController();
  //     controller.fullName = 'John Doe';
  //     controller.email = 'johndoe@example.com';
  //     controller.password = '';
  //     controller.confirmPassword = 'password123';
  //
  //     expect(controller.passwordValidator(), false);
  //   });
  //   test('Passwords are not equal', () {
  //     var controller = SignUpController();
  //     controller.fullName = 'John Doe';
  //     controller.email = 'johndoe@example.com';
  //     controller.password = '45554';
  //     controller.confirmPassword = 'password123';
  //
  //     expect(controller.passwordValidator(), false);
  //   });
  // });
}
