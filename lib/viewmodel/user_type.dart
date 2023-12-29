import 'package:flutter/material.dart';

import '../screen/authenticate/choose_type.dart';

class UserTypeModel extends ChangeNotifier {
  UserType _userType = UserType.tutor;

  get userType => _userType;

  void changeUserType(UserType userType) async {
    _userType = userType;
    notifyListeners();
  }
}
