import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
 final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future addSignUpProfile(String userId, String? email) async {
    Map<String, Object?> data = {'user_id': userId, 'email': email};

    //chua xu ly error
    await _firestore.collection('Users').add(data).then((value) => print(value));
  }
  // Future addSignUpProfile( String email) async {
  //   Map<String, Object> data = {'email': email};
  //
  //   //chua xu ly error
  //   await _firestore.collection('Users').add(data).then((value) => print(value));
  // }
}
