import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datn/model/user.dart';
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

  Stream<User>? user(String userId) {
    DocumentReference docRef = _firestore.collection('users').doc(userId);
    final snapshot = docRef.snapshots();
    return docRef.snapshots().map((json) => User.fromJson(json.data() as Map));
  }

  Future updateInfo(String userId, String displayName, String phone,
      Timestamp born, String gender) async {
    await firestore.collection('users').doc(userId).set({
      'display_name': displayName,
      'phone': phone,
      'born': born,
      'gender': gender
    }, SetOptions(merge: true)).catchError((error) {
      print('FIRESTORE UPLOAD' + error);
    });
  }

  Future updateName(String userId, String displayName) async {
    await firestore
        .collection('users')
        .doc(userId)
        .set({'display_name': displayName}, SetOptions(merge: true)).catchError((error){
      print('FIRESTORE UPLOAD DISPLAYNAME' + error);
    });
  }

  Future updateImageUrl(String userId, String url) async {
    await firestore
        .collection('users')
        .doc(userId)
        .set({'photo_url': url}, SetOptions(merge: true)).catchError((error) {
      print('FIRESTORE UPDATE' + error);
    });
  }
}
