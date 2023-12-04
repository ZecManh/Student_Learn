class User {

  User(
      {this.uid = '',
      this.photoUrl = '',
      this.phone = '',
      this.gender = '',
      this.email = '',
      this.displayName = '',
      this.born = '',});

  String uid;
  String photoUrl;
  String phone;
  String gender;
  String email;
  String displayName;
  String born;

  factory User.fromJson(Map<dynamic, dynamic> json) => User(
      uid: json['uid'],
      photoUrl: json['photo_url'],
      phone: json['phone'],
      gender: json['gender'],
      email: json['email'],
      displayName: json['display_name'],
      born: json['born']);

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'photo_url': photoUrl,
      'phone': phone,
      'gender': gender,
      'email': email,
      'display_name': displayName,
      'born': born,

    };
  }

  @override
  String toString() {
    return 'User{uid: $uid, photoUrl: $photoUrl, phone: $phone, gender: $gender, email: $email, displayName: $displayName, born: $born}';
  }
}
