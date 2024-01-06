import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  Address? address;
  Timestamp? born;
  String? displayName;
  Education? education;
  String? email;
  String? gender;
  String? phone;
  String? photoUrl;
  List<String>? subjects;
  List<String>? teachAddress;
  List<String>? teachMethod;
  String? uid;
  bool? verify;
  String? experience;
  Timestamp? lastLogin;
  Timestamp? createdTime;

  User(
      {this.address,
      this.born,
      this.displayName,
      this.education,
      this.email,
      this.gender,
      this.phone,
      this.photoUrl,
      this.subjects,
      this.teachAddress,
      this.teachMethod,
      this.uid,
      this.verify,
      this.experience,
      this.lastLogin,
      this.createdTime});

  User.fromJson(Map<dynamic, dynamic> json) {
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    born = json['born'] != null ? (json['born']) : null;
    displayName = json['display_name'];
    education = json['education'] != null
        ? Education.fromJson(json['education'])
        : null;
    email = json['email'];
    gender = json['gender'];
    phone = json['phone'];
    photoUrl = json['photo_url'];
    subjects =
        (json['subjects'] != null) ? json['subjects'].cast<String>() : null;
    teachAddress = (json['teach_address'] != null)
        ? json['teach_address'].cast<String>()
        : null;
    teachMethod = (json['teach_method'] != null)
        ? json['teach_method'].cast<String>()
        : null;
    uid = json['uid'];
    verify = json['verify'];
    experience = json['experience'];
    lastLogin = json['last_login'] != null ? (json['last_login']) : null;
    createdTime = json['created_time'] != null ? (json['created_time']) : null;

    // print("JSON" + json.toString());
    // print("TO STRING " + toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (address != null) {
      data['address'] = address!.toJson();
    }
    data['born'] = born;
    data['display_name'] = displayName;
    if (education != null) {
      data['education'] = education!.toJson();
    }
    data['email'] = email;
    data['gender'] = gender;
    data['phone'] = phone;
    data['photo_url'] = photoUrl;
    data['subjects'] = subjects;
    data['teach_address'] = teachAddress;
    data['teach_method'] = teachMethod;
    data['uid'] = uid;
    data['verify'] = verify;
    data['experience'] = experience;
    data['last_login'] = lastLogin;
    data['created_time'] = createdTime;
    return data;
  }

  @override
  String toString() {
    return 'User{address: $address, born: $born, displayName: $displayName, education: $education, email: $email, gender: $gender, phone: $phone, photoUrl: $photoUrl, subjects: $subjects, teachAddress: $teachAddress, teachMethod: $teachMethod, uid: $uid, verify: $verify, experience: $experience, lastLogin: $lastLogin, createdTime: $createdTime}';
  }
}

class Address {
  String? province;
  String? district;
  String? ward;

  Address({this.province, this.district, this.ward});

  Address.fromJson(Map<String, dynamic> json) {
    province = json['province'];
    district = json['district'];
    ward = json['ward'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['province'] = province;
    data['district'] = district;
    data['ward'] = ward;
    return data;
  }

  @override
  String toString() {
    return 'Address{province: $province, district: $district, ward: $ward}';
  }
}

class Education {
  String? major;
  String? university;
  String? year;

  Education({this.major, this.university, this.year});

  Education.fromJson(Map<String, dynamic> json) {
    major = json['major'];
    university = json['university'];
    year = json['year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['major'] = major;
    data['university'] = university;
    data['year'] = year;
    return data;
  }

  @override
  String toString() {
    return 'Education{major: $major, university: $university, year: $year}';
  }
}
