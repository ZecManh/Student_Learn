import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datn/model/subject_request/subject_request.dart';
import 'package:datn/model/user/teach_schedules.dart';
import 'package:datn/model/user/user.dart' as user_model;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
    final snapshot = docRef.snapshots();
    return docRef
        .snapshots()
        .map((json) => user_model.User.fromJson(json.data() as Map));
  }

  Stream<Map<dynamic, dynamic>>? userMap(String userId) {
    DocumentReference docRef = _firestore.collection('users').doc(userId);
    final snapshot = docRef.snapshots();
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
            (error) {
      print('FIRESTORE UPDATE EXPERIENCE' + error);
    });
  }

  void getSubjectRequest() async {
    print("GET SUBJECT REQUEST");
    // final query = firestore
    //     .collection(SUBJECT_REQUEST_DOC)
    //     .where("learner_id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
    //     .get()
    //     .then((querySnapshot) {
    //   print("Successfully completed");
    //   //test
    //
    //   print("QUERY SNAPSHOT " + querySnapshot.toString());
    //   print("QUERY SNAPSHOT DOCS " + querySnapshot.doc.toString());
    //
    //   //test
    //   for (var docSnapshot in querySnapshot.docs) {
    //     print('${docSnapshot.id} => ${docSnapshot.data().toString()}');
    //   }

      try {
        // Query documents where the 'userName' field is equal to the provided username
        QuerySnapshot querySnapshot = await firestore
            .collection('subject_requests') // Replace with your actual collection name
            .where('learner_id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .get();

        // Loop through the query results
        for (QueryDocumentSnapshot document in querySnapshot.docs) {
          // Access the data of the matching document
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
          print('Document ID: ${document.id}, Data: $data');
          print('Document ID: ${document.id}, Data: $data');
          print("data json $data");
          var subjectRequest = SubjectRequest.fromJson(data);
          print(subjectRequest.toString());
        /*  print("learner id " + data['learner_id'].toString());
          print("subject " + data['subject']);
          print("state " + data['state']);
          print("teach method " + data['teach_method']);*/
          // print("schedules "+ data['schedules']);
          // print(TeachSchedules.fromJson(data['schedules']).toString());
        }
      } catch (e) {
        print('Error querying Firestore: $e');
      }

  }
}
