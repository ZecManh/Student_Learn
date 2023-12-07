import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class User {
  User(
      {this.uid,
      this.address,
      this.born,
      this.department,
      this.displayName,
      this.email,
      this.experience,
      this.gender,
      this.teachMethod,
      this.phone,
      this.photoUrl,
      this.university,
      this.verify,
      this.subjects,
      this.teachAddress});

  String? uid;
  String? address;
  DateTime? born;
  String? department;
  String? displayName;
  String? email;
  String? experience;
  String? gender;
  List<String>? teachMethod;
  String? phone;
  String? photoUrl;
  String? university;
  bool? verify;
  List<String>? subjects;
  List<String>? teachAddress;

  static String convertDateTime(DateTime oldDateTime) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    String formattedDateTime = formatter.format(oldDateTime);
    return formattedDateTime;
  }

  factory User.fromJson(Map<dynamic, dynamic> json) => User(
      uid: json['uid'],
      address: json['address'],
      born:
          (json['born'] != null) ? (json['born']! as Timestamp).toDate() : null,
      department: json['department'],
      displayName: json['display_name'],
      email: json['email'],
      experience: json['experience'],
      gender: json['gender'],
      teachMethod: (json['teach_method'] as List)
          .map((method) => method as String)
          .toList(),
      phone: json['phone'],
      photoUrl: json['photo_url'],
      university: json['university'],
      verify: json['verify'],
      // subjects: json['subjects']
      subjects:
          (json['subjects'] as List).map((item) => item as String).toList(),
      teachAddress: (json['teach_address'] as List)
          .map((item) => item as String)
          .toList());

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'address': address,
      'born': born != null ? Timestamp.fromDate(born!) : null,
      'department': department,
      'display_name': displayName,
      'email': email,
      'experience': experience,
      'gender': gender,
      'online_teach': teachMethod,
      'phone': phone,
      'photo_url': photoUrl,
      'university': university,
      'verify': verify,
      'subjects': subjects,
      'teach_address': teachAddress
    };
  }
}
