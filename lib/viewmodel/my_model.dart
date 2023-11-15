import 'dart:math';

import 'package:flutter/cupertino.dart';

import '../model/user.dart';

class MyModel extends ChangeNotifier{
  User user=User(email: 'minghieuu@',displayName: 'Minh Hieu');
  void changeSomething(){
    Random rd=Random();
    int randInt= rd.nextInt(100);
    user.phone=randInt.toString();
    print(user.toString());
    notifyListeners();
  }

}