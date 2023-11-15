import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../model/user.dart' as model;

class UserModel extends ChangeNotifier {
  // model.User _currentUser = model.User();
  late model.User _currentUser = model.User();
  FirebaseAuth auth = FirebaseAuth.instance;

  model.User get currentUser => _currentUser;

  // FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CollectionReference userRef =
      FirebaseFirestore.instance.collection('users');

  Future init() async {
    await userRef
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((event) {
      _currentUser = model.User.fromJson(event.data() as Map<dynamic, dynamic>);
      print('current user'+ _currentUser.toString());
      notifyListeners();
    });
  }
}
