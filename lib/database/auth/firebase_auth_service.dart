import 'package:datn/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import 'package:flutter/material.dart';

class FirebaseAuthService extends ChangeNotifier {
  final firebase_auth.FirebaseAuth _firebaseAuth =
      firebase_auth.FirebaseAuth.instance;

  String? uid;
  String? email;

  get auth => _firebaseAuth;

  User? userFromFirebase(firebase_auth.User? user) {
    if (user == null) {
      return null;
    } else {
      uid = user.uid;
      email = user.email;
      return User(uid: user.uid, email: user.email!);
    }
  }

  //dung kieu stream builder
  Stream<User?>? get user {
    return _firebaseAuth
        .authStateChanges()
        .map((user) => userFromFirebase(user));
  }
  Future<bool> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      firebase_auth.UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on firebase_auth.FirebaseAuthException catch (e) {
      return false;
    }
  }

  Future<User?> createUserWithEmailAndPassword(
      String email, String password) async {
    firebase_auth.UserCredential userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    return userFromFirebase(userCredential.user);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> resetPassword(String email, BuildContext context) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            'Mail đã được gửi tới bạn,vui lòng kiểm tra email để tiến hành khôi phục mật khẩu')));
    Navigator.of(context).pop();
  }
}
