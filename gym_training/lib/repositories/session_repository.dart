import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
// ignore: depend_on_referenced_packages
import 'package:get_storage/get_storage.dart';
import 'package:gym_training/models/session.dart';
import 'package:gym_training/utils/shared_keys.dart';

class SessionRepository {
  late final GetStorage sharedPreferences;
  late final FirebaseAuth firebaseAuth;

  SessionRepository({
    required this.sharedPreferences,
    required this.firebaseAuth,
  }) {
    _startListener();
  }

  Session? getCurrentSession() {
    var sessionString = sharedPreferences.read<String>(SharedKeys.userDataKey);

    if (sessionString == null) return null;
    return Session.fromJson(sessionString);
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

  Future<bool> login(String emailAddress, String password) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      await _createNewSession(credential);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
      }
    } catch (e) {
      log(e.toString());
    }
    return false;
  }

  Future<void> _createNewSession(UserCredential userCredential) async {
    if (userCredential.user == null) return;
    var newSession = Session(
      userEmail: userCredential.user!.email!,
      userName: userCredential.user?.displayName ?? '',
      userId: userCredential.user!.uid,
    );

    await sharedPreferences.write(SharedKeys.userDataKey, newSession);
  }

  Future<bool> logout() async {
    try {
      await sharedPreferences.remove(SharedKeys.userDataKey);
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
