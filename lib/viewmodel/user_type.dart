import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screen/authenticate/choose_type.dart';

class UserTypeModel extends ChangeNotifier {
  UserType _userType = UserType.tutor;

  get userType => _userType;

  void changeUserType(UserType userType) async {
    _userType = userType;
    print("change user type to $_userType");
    notifyListeners();
  }
}
