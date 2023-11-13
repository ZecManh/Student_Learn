import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> createAccount(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Map<String, Object?> getUserInfo() {
    return {
      'email': _auth.currentUser?.email,
      'user_id': _auth.currentUser?.uid
    };
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    return null;
  }

  Future resetPassword(String email, BuildContext context) async {
    await _auth.sendPasswordResetEmail(email: email);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'Mail đã được gửi tới bạn,vui lòng kiểm tra email để tiến hành khôi phục mật khẩu')));
  }

  Future logout(BuildContext context) async {
    await _auth.signOut();

    _auth.authStateChanges().listen((user) {
      if (user == null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Đã đăng xuất')));
        print('User is currently signed out!');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Đăng xuất không thành công')));
        print('User is signed in!');
      }
    });
  }
}
