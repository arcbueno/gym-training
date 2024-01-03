import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
// ignore: depend_on_referenced_packages
import 'package:get_storage/get_storage.dart';
import 'package:gym_training/models/session.dart';
import 'package:gym_training/utils/shared_keys.dart';

class FirebaseRepository {
  late final GetStorage sharedPreferences;
  late final FirebaseAuth firebaseAuth;

  FirebaseRepository({
    required this.sharedPreferences,
    required this.firebaseAuth,
  }) {
    _startListener();
  }

  _startListener() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        log('User is currently signed out!');
        // logOut();
      } else {
        log('User is signed in!');
      }
    });
  }

  login(String emailAddress, String password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      _createNewSession(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  _createNewSession(UserCredential userCredential) {
    if (userCredential.user == null) return;
    var newSession = Session(
      userEmail: userCredential.user!.email!,
      userName: userCredential.user!.displayName!,
      userId: userCredential.user!.uid,
    );

    sharedPreferences.write(SharedKeys.userDataKey, newSession);
  }
}
