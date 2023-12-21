import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datn/model/subject_request/subject_request.dart';
import 'package:datn/model/user/user.dart' as user_model;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../model/user/teach_schedules.dart';
import '../../model/user/user.dart';

class FirestoreService extends ChangeNotifier {
  static String USER_DOC = "users";
  static String SUBJECT_REQUEST_DOC = "subject_request";
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
    // final snapshot = docRef.snapshots();
    return docRef
        .snapshots()
        .map((json) => user_model.User.fromJson(json.data() as Map));
  }

  Stream<Map<dynamic, dynamic>>? userMap(String userId) {
    DocumentReference docRef = _firestore.collection('users').doc(userId);
    // final snapshot = docRef.snapshots();
    return docRef.snapshots().map((json) => json as Map);
  }

  Future updateInfo(
      String displayName, String phone, Timestamp born, String gender) async {
    await firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
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
    await firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({'education': education.toJson()},
            SetOptions(merge: true)).catchError((error) {
      print('FIRESTORE UPDATE EDUCATION' + error);
    });
  }

  void updateSubject(List<String> subject) async {
    await firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({'subjects': subject}, SetOptions(merge: true)).catchError(
            (error) {
      print('FIRESTORE UPDATE SUBJECTS' + error);
    });
  }

  void updateExperience(String experience) async {
    await firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({'experience': experience}, SetOptions(merge: true)).catchError(
            (error) {});
  }

  void getSubjectRequest() async {
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection(
              'subject_requests') // Replace with your actual collection name
          .where('learner_id',
              isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();

      // Loop through the query results
      for (QueryDocumentSnapshot document in querySnapshot.docs) {
        // Access the data of the matching document
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        var subjectRequest = SubjectRequest.fromJson(data);
        /*  print("learner id " + data['learner_id'].toString());
          print("subject " + data['subject']);
          print("state " + data['state']);
          print("teach method " + data['teach_method']);*/
        // print("schedules "+ data['schedules']);
        // print(TeachSchedules.fromJson(data['schedules']).toString());
      }
    } catch (e) {}
  }

  Future<List<user_model.User>> getTutors() async {
    List<user_model.User> users = [];
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('users') // Replace with your actual collection name
          .where('uid', isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();

      for (QueryDocumentSnapshot document in querySnapshot.docs) {
        // Access the data of the matching document
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        var user = user_model.User.fromJson(data);
        users.add(user);
      }
    } catch (e) {}
    // return users;
    users.retainWhere((element) {
      if (element.subjects != null) {
        if (element.subjects!.length > 0) {
          return true;
        }
        return false;
      }
      return false;
    });
    return users;
  }

  Future<void> addSubjectRequest(
      String subject,
      String teachMethod,
      TeachSchedules schedules,
      String address,
      Timestamp startTime,
      Timestamp endTime) async {
    SubjectRequest subjectRequest = SubjectRequest(
        learnerId: FirebaseAuth.instance.currentUser!.uid,
        subject: subject,
        state: "Pending",
        teachMethod: teachMethod,
        schedules: schedules,
        address: address,
        createdTime: Timestamp.now(),
        startTime: startTime,
        endTime: endTime);
    await firestore.collection('subject_requests').add(subjectRequest.toJson());
  }

  Future<void> updateTeachAddress(List<String> chosenDistricts) async {
    await firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({'teach_address': chosenDistricts}, SetOptions(merge: true)).catchError(
            (error) {});
  }
}
