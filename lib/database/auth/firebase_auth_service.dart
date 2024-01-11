import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datn/database/firestore/firestore_service.dart';
import 'package:datn/model/user/user.dart';
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

  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      firebase_auth.UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on firebase_auth.FirebaseAuthException catch (e) {
      return false;
    }
  }

  Future<bool> createUserWithEmailAndPassword(String email, String password,
      ) async {
    var user = User();
    await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((userCredential) {
          print("SIGNUP OK");
          print("USER credential firestore ${userCredential.user}");
          var user = User();
          user.email = userCredential.user?.email;
          user.uid = userCredential.user?.uid;
          print("USER INFOOO");
          print("email ${user.email}");
          print("uid ${user.uid}");

          FirebaseFirestore firestore = FirebaseFirestore.instance;
          if(user.uid!=null){
            print("uid khac null");
          }
          if(user.email!=null){
            print("email khac null");
          }
          firestore.collection('users').doc(user.uid).set({
            'uid': user.uid,
            'email': email,
            'last_login' : Timestamp.now(),
            'created_time' : Timestamp.now(),
          });
          return true;

    }).catchError((err) {
      print("SIGNUP ERRPR $err");
      return false;
    });
    print("USER INFOOO BELOW");
    print("email BELOW ${user.email}");
    print("uid BELOW ${user.uid}");
    return false;
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
