import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datn/model/enum.dart';
import 'package:datn/model/subject_request/schedules.dart';
import 'package:datn/model/subject_request/subject_request.dart';
import 'package:datn/model/teach_classes/teach_class.dart';
import 'package:datn/model/today_schdules.dart';
import 'package:datn/model/user/user.dart' as user_model;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../model/user/teach_schedules.dart';

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
      }
    } catch (e) {}
  }

  Future<List<SubjectRequest>> getAllSubjectRequest() async {
    List<SubjectRequest> subjectRequests = [];
    print("GET ALL SUBJECT REQUEST");
    firestore.collection("subject_requests").get().then(
      (querySnapshot) {
        print("Successfully completed");
        for (var docSnapshot in querySnapshot.docs) {
          print('${docSnapshot.id} => ${docSnapshot.data()}');
          Map<String, dynamic> data =
              docSnapshot.data() as Map<String, dynamic>;
          var subjectRequest = SubjectRequest.fromJson(data);
          subjectRequests.add(subjectRequest);
          print("SUBJECT REQUEST $subjectRequest");
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
    return subjectRequests;
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
      String tutorId,
      String subject,
      String teachMethod,
      WeekSchedules schedules,
      String address,
      Timestamp startTime,
      Timestamp endTime) async {
    SubjectRequest subjectRequest = SubjectRequest(
        learnerId: FirebaseAuth.instance.currentUser!.uid,
        tutorId: tutorId,
        subject: subject,
        state: SubjectRequestState.pending.name,
        teachMethod: teachMethod,
        weekSchedules: schedules,
        address: address,
        createdTime: Timestamp.now(),
        startTime: startTime,
        endTime: endTime);
    print(subjectRequest.toJson().toString());
    await firestore.collection('subject_requests').add(subjectRequest.toJson());
  }

  Future<void> updateTeachAddress(List<String> chosenDistricts) async {
    await firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({'teach_address': chosenDistricts},
            SetOptions(merge: true)).catchError((error) {});
  }

  Future<List<SubjectRequest>> getAllSubjectRequestByID() async {
    List<SubjectRequest> subjectRequests = [];
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection(
              'subject_requests') // Replace with your actual collection name
          .where('tutor_id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .where('state', isEqualTo: SubjectRequestState.pending.name)
          .get();

      for (QueryDocumentSnapshot document in querySnapshot.docs) {
        // Access the data of the matching document
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        var subjectRequest = SubjectRequest.fromJson(data);
        subjectRequests.add(subjectRequest);
      }
    } catch (e) {}

    return subjectRequests;
  }

  Future<Map<SubjectRequest, user_model.User>>
      getLearnerInfoWithListSubjectRequest() async {
    List<user_model.User> leaners = [];
    List<SubjectRequest> subjectRequests = await getAllSubjectRequestByID();
    Map<SubjectRequest, user_model.User> data = {};
    try {
      for (SubjectRequest subjectRequest in subjectRequests) {
        user_model.User learner = await getUser(subjectRequest.learnerId!);
        Map<SubjectRequest, user_model.User> map = {subjectRequest: learner};
        data.addAll(map);
      }
    } catch (e) {}
    return data;
  }

  Future<user_model.User> getUser(String uid) async {
    List<user_model.User> users = [];
    QuerySnapshot querySnapshot = await firestore
        .collection('users') // Replace with your actual collection name
        .where('uid', isEqualTo: uid)
        .get();
    for (var docSnapshot in querySnapshot.docs) {
      var json = docSnapshot.data() as Map<String, dynamic>;
      var user = user_model.User.fromJson(json);
      users.add(user);
    }
    return users.first;
  }

  Future<void> addClass(SubjectRequest subjectRequest) async {
    TeachClass teachClass = TeachClass();

    teachClass.createdTime = Timestamp.now();
    teachClass.startTime = subjectRequest.startTime;
    teachClass.endTime = subjectRequest.endTime;
    teachClass.learnerId = subjectRequest.learnerId;
    teachClass.tutorId = subjectRequest.tutorId;
    teachClass.subject = subjectRequest.subject;
    teachClass.address = subjectRequest.address;
    teachClass.state = ClassesState.running.name;
    teachClass.teachMethod = subjectRequest.teachMethod;

    List<LessonSchedules> lessonSchedules =
        TeachClass.generateTimetableTimestamp(subjectRequest.startTime!,
            subjectRequest.endTime!, subjectRequest.weekSchedules!);

    teachClass.schedules = Schedules(
        weekSchedules: subjectRequest.weekSchedules,
        lessonSchedules: lessonSchedules);

    await _firestore
        .collection('classes')
        .add(teachClass.toJson())
        .then((value) => print(value));

    _firestore
        .collection("subject_requests")
        .where("learner_id", isEqualTo: subjectRequest.learnerId)
        .where("tutor_id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then(
      (querySnapshot) {
        print("Successfully completed SUBJECT REQUEST");
        for (var docSnapshot in querySnapshot.docs) {
          print('${docSnapshot.id} => ${docSnapshot.data()}');
          String subjectRequestId = docSnapshot.id;
          changeSubjectRequestStateToAccept(subjectRequestId);
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
  }

  Future<void> changeSubjectRequestStateToAccept(
      String subjectRequestID) async {
    await _firestore.collection("subject_requests").doc(subjectRequestID).set({
      'state': SubjectRequestState.accepted.name,
    }, SetOptions(merge: true)).catchError((error) {
      print('FIRESTORE UPDATE SUBJECT REQUEST TO ACCEPTED' + error);
    });
  }

  Future<void> removeSubjectRequest(SubjectRequest subjectRequest) async {
    _firestore
        .collection("subject_requests")
        .where("learner_id", isEqualTo: subjectRequest.learnerId)
        .where("tutor_id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where("created_time", isEqualTo: subjectRequest.createdTime)
        .get()
        .then(
      (querySnapshot) {
        print("Successfully completed SUBJECT REQUEST");
        for (var docSnapshot in querySnapshot.docs) {
          print('${docSnapshot.id} => ${docSnapshot.data()}');
          String subjectRequestId = docSnapshot.id;
          _firestore
              .collection("subject_requests")
              .doc(subjectRequestId)
              .delete()
              .then(
                (doc) => print("Document $subjectRequestId deleted"),
                onError: (e) => print("Error updating subject request $e"),
              );
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
  }

  Future<List<TeachClass>> getAllClassTutorSide() async {
    List<TeachClass> teachClasses = [];
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('classes') // Replace with your actual collection name
          .where('tutor_id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .where('state', isEqualTo: ClassesState.running.name)
          .get();

      for (QueryDocumentSnapshot document in querySnapshot.docs) {
        // Access the data of the matching document
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        var teachClass = TeachClass.fromJson(data);
        teachClasses.add(teachClass);
      }
    } catch (e) {}

    return teachClasses;
  }

  Future<List<TeachClass>> getAllClassLearnerSide() async {
    List<TeachClass> teachClasses = [];
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('classes') // Replace with your actual collection name
          .where('learner_id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .where('state', isEqualTo: ClassesState.running.name)
          .get();

      for (QueryDocumentSnapshot document in querySnapshot.docs) {
        // Access the data of the matching document
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        var teachClass = TeachClass.fromJson(data);
        teachClasses.add(teachClass);
      }
    } catch (e) {}

    return teachClasses;
  }

  Future<List<Map<String, dynamic>>> getTeachingInfoTutorSide() async {
    List<Map<String, dynamic>> teachingData = [];
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('classes') // Replace with your actual collection name
          .where('tutor_id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .where('state', isEqualTo: ClassesState.running.name)
          .get();

      for (QueryDocumentSnapshot document in querySnapshot.docs) {
        // Access the data of the matching document
        Map<String, dynamic> itemData = {};
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        var teachClass = TeachClass.fromJson(data);
        user_model.User learnerInfo = await getUser(teachClass.learnerId!);
        itemData.addAll({
          'docId': document.id,
          'teachClass': teachClass,
          'learnerInfo': learnerInfo
        });
        teachingData.add(itemData);
      }
    } catch (e) {}

    return teachingData;
  }
  Future<user_model.User?> getTutorById(String uid) async {
    user_model.User? user;
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('users') // Thay thế bằng tên collection thực tế của bạn
          .where('uid', isEqualTo: uid) // Thay 'your_uid' bằng uid cụ thể của item bạn muốn truy cập
          .limit(1)
          .get();
      if (querySnapshot.size > 0) {
        // Tìm thấy item với uid cụ thể
        DocumentSnapshot documentSnapshot = querySnapshot.docs[0];

        Map<String, dynamic> data = documentSnapshot.data() as Map<String,
            dynamic>;
        user = user_model.User.fromJson(data);
      }
    } catch (e) {}
    return user;
  }

  Future<List<Map<String, dynamic>>> getTeachingInfoLearnerSide() async {
    List<Map<String, dynamic>> teachingData = [];
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('classes') // Replace with your actual collection name
          .where('learner_id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .where('state', isEqualTo: ClassesState.running.name)
          .get();

      for (QueryDocumentSnapshot document in querySnapshot.docs) {
        // Access the data of the matching document
        Map<String, dynamic> itemData = {};
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        var teachClass = TeachClass.fromJson(data);
        user_model.User learnerInfo = await getUser(teachClass.learnerId!);
        itemData.addAll({
          'docId': document.id,
          'teachClass': teachClass,
          'learnerInfo': learnerInfo
        });
        teachingData.add(itemData);
      }
    } catch (e) {}

    return teachingData;
  }

  Future<List<TodaySchedules>> getTodaySchedules() async {
    DateTime today = DateTime.now();
    List<TeachClass> teachClasses = await getAllClassTutorSide();
    List<TodaySchedules> todaySchedules = [];
    teachClasses.forEach((classItem) {
      List<LessonSchedules>? lessonSchedules =
          classItem.schedules?.lessonSchedules;
      lessonSchedules?.forEach((itemLessonSchedules) {
        if (isTheSameDay(itemLessonSchedules.startTime?.toDate(), today)) {
          DateTime startTime = itemLessonSchedules.startTime!.toDate();
          DateTime endTime = itemLessonSchedules.endTime!.toDate();
          String subject = classItem.subject!;
          String teachMethod = classItem.teachMethod!;
          todaySchedules.add(TodaySchedules(
              startTime: startTime,
              endTime: endTime,
              subject: subject,
              teachMethod: teachMethod));
        }
      });
    });
    return todaySchedules;
  }

  bool isTheSameDay(DateTime? dateTime1, DateTime? dateTime2) {
    if (dateTime1 != null && dateTime2 != null) {
      bool isSameDay = dateTime1.year == dateTime2.year &&
          dateTime1.month == dateTime2.month &&
          dateTime1.day == dateTime2.day;
      return isSameDay;
    }
    return false;
  }
  // Future<user_model.User?> getClassById(String uid) async {
  //   user_model.User? user;
  //   try {
  //     QuerySnapshot querySnapshot = await firestore
  //         .collection('classes') // Thay thế bằng tên collection thực tế của bạn
  //         .where('uid', isEqualTo: uid)
  //         .limit(1)
  //         .get();
  //     if (querySnapshot.size > 0) {
  //       // Tìm thấy item với uid cụ thể
  //       DocumentSnapshot documentSnapshot = querySnapshot.docs[0];
  //
  //       Map<String, dynamic> data = documentSnapshot.data() as Map<String,
  //           dynamic>;
  //       user = user_model.User.fromJson(data);
  //     }
  //   } catch (e) {}
  //   return user;
  // }
}
