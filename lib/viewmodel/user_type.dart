import 'package:flutter/material.dart';

import '../screen/authenticate/choose_type.dart';

class UserTypeModel extends ChangeNotifier {
  UserType _userType = UserType.learner;

  get userType => _userType;

  void changeUserType(UserType userType) {
    _userType = userType;
    notifyListeners();
  }
}
