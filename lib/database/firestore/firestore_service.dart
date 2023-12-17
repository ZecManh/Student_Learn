import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datn/model/user/user.dart' as user_model ;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirestoreService extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  get firestore => _firestore;

  Future addSignUpProfile(String userId, String? email) async {
    Map<String, Object?> data = {'user_id': userId, 'email': email};

    //chua xu ly error
    await _firestore
        .collection('users')
        .add(data)
        .then((value) => print(value));
  }

  Stream<user_model.User>? user(String userId) {
    DocumentReference docRef = _firestore.collection('users').doc(userId);
    final snapshot = docRef.snapshots();
    return docRef.snapshots().map((json) => user_model.User.fromJson(json.data() as Map));
  }

  Stream<Map<dynamic, dynamic>>? userMap(String userId) {
    DocumentReference docRef = _firestore.collection('users').doc(userId);
    final snapshot = docRef.snapshots();
    return docRef.snapshots().map((json) => json as Map);
  }

  Future updateInfo(String displayName, String phone,
      Timestamp born, String gender) async {
    await firestore.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).set({
      'display_name': displayName,
      'phone': phone,
      'born': born,
      'gender': gender
    }, SetOptions(merge: true)).catchError((error) {
      print('FIRESTORE UPLOAD' + error);
    });
  }

  Future updateName(String displayName) async {
    await firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({'display_name': displayName}, SetOptions(merge: true)).catchError(
            (error) {
      print('FIRESTORE UPLOAD DISPLAYNAME' + error);
    });
  }

  Future updateImageUrl(String url) async {
    await firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({'photo_url': url}, SetOptions(merge: true)).catchError((error) {
      print('FIRESTORE UPDATE IMAGE URL' + error);
    });
  }

  Future updateAddress(user_model.Address address) async {
    await firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({'address': address.toJson()}, SetOptions(merge: true)).catchError(
            (error) {
      print('FIRESTORE UPDATE ADDRESS' + error);
    });
  }

  void updateEducation(user_model.Education education) async {
    await firestore.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).set(
        {'education': education.toJson()},
        SetOptions(merge: true)).catchError((error) {
      print('FIRESTORE UPDATE EDUCATION' + error);
    });
  }

  void updateSubject(List<String> subject) async {
    await firestore.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).set(
        {'subjects': subject},
        SetOptions(merge: true)).catchError((error) {
      print('FIRESTORE UPDATE SUBJECTS' + error);
    });
  }

  void updateExperience(String experience) async {
    await firestore.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).set(
        {'experience': experience},
        SetOptions(merge: true)).catchError((error) {
      print('FIRESTORE UPDATE EXPERIENCE' + error);
    });
  }

}
