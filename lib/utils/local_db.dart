import 'package:hive_flutter/hive_flutter.dart';

import '../model/face_recognition/user.dart';

class HiveBoxes {
  static const userDetails = "user_details";

  static Box userDetailsBox() => Hive.box(userDetails);

  static initialize() async {
    await Hive.openBox(userDetails);
  }

  static clearAllBox() async {
    await HiveBoxes.userDetailsBox().clear();
  }
}

class LocalDB {
  static User getUser() => User.fromJson(HiveBoxes.userDetailsBox().toMap());

  static String getUserName() =>
      HiveBoxes.userDetailsBox().toMap()[User.nameKey];

  static String getUserArray() =>
      HiveBoxes.userDetailsBox().toMap()[User.arrayKey];

  static setUserDetails(User user) =>
      HiveBoxes.userDetailsBox().putAll(user.toJson());
}
