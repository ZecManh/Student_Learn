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
      });

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


    // print("JSON" + json.toString());
    // print("TO STRING " + toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    data['born'] = this.born;
    data['display_name'] = this.displayName;
    if (this.education != null) {
      data['education'] = this.education!.toJson();
    }
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['phone'] = this.phone;
    data['photo_url'] = this.photoUrl;
    data['subjects'] = this.subjects;
    data['teach_address'] = this.teachAddress;
    data['teach_method'] = this.teachMethod;
    data['uid'] = this.uid;
    data['verify'] = this.verify;
    data['experience'] = this.experience;

    return data;
  }

  @override
  String toString() {
    return 'User{address: $address, born: $born, displayName: $displayName, education: $education, email: $email, gender: $gender, phone: $phone, photoUrl: $photoUrl, subjects: $subjects, teachAddress: $teachAddress, teachMethod: $teachMethod, uid: $uid, verify: $verify, experience: $experience}';
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
    data['province'] = this.province;
    data['district'] = this.district;
    data['ward'] = this.ward;
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
    data['major'] = this.major;
    data['university'] = this.university;
    data['year'] = this.year;
    return data;
  }

  @override
  String toString() {
    return 'Education{major: $major, university: $university, year: $year}';
  }
}
