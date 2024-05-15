import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
// ignore: depend_on_referenced_packages
import 'package:get_storage/get_storage.dart';
import 'package:gym_training/models/session.dart';
import 'package:gym_training/utils/shared_keys.dart';
import 'package:result_dart/result_dart.dart';

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
    firebaseAuth.authStateChanges().listen((User? user) {
      if (user == null) {
        log('User is currently signed out!');
        // logOut();
      } else {
        log('User is signed in!');
      }
    });
  }

  Future<String?> login(String emailAddress, String password) async {
    String? error;
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      await _createNewSession(credential);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        error = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        error = 'The account already exists for that email.';
      } else if (e.code == 'invalid-credential') {
        error = 'Email or password is invalid';
      }
      log(error ?? '');
    } catch (e) {
      log(e.toString());
      error = e.toString();
    }
    return error;
  }

  Future<void> _createNewSession(UserCredential userCredential) async {
    if (userCredential.user == null) return;
    var newSession = Session(
      userEmail: userCredential.user!.email!,
      userName: userCredential.user?.displayName ?? '',
      userId: userCredential.user!.uid,
    );

    await sharedPreferences.write(SharedKeys.userDataKey, newSession.toJson());
  }

  Future<bool> logout() async {
    try {
      await sharedPreferences.remove(SharedKeys.userDataKey);
      await firebaseAuth.signOut();
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<Result<bool, Exception>> createUser(
      String email, String password) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return const Result.success(true);
    } catch (e) {
      if (e is FirebaseAuthException) {
        return Result.failure(Exception(e.message));
      }

      return Result.failure(Exception(e.toString()));
    }
  }
}
