import 'package:datn/screen/authenticate/authenticate.dart';
import 'package:datn/screen/authenticate/choose_type.dart';
import 'package:datn/screen/learner/dash_board_learner.dart';
import 'package:datn/screen/tutor/dash_board_tutor.dart';
import 'package:datn/viewmodel/user_type.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../database/auth/firebase_auth_service.dart';
import '../model/user.dart';

// lang nghe authStateChange lang nghe khi signout
class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  String _type = '';

  @override
  void initState() {
    super.initState();
    loadUserType();
  }

  Future loadUserType() async {
    final pref = await SharedPreferences.getInstance();
    String userType =
        pref.getString('userType')!;
    setState(() {
      _type = userType;
    });
  }

  @override
  Widget build(BuildContext context) {
    final firebaseAuthService = Provider.of<FirebaseAuthService>(context);
    print("wrapper rebuild with type ${_type}");
    return StreamBuilder<User?>(
        stream: firebaseAuthService.user,
        builder: (context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final User? user = snapshot.data;
            if (user == null) {
              return Authenticate();
            } else {
              if (_type == 'learner') {
                print("wrapper to learner");
                return DashBoardLearner();
              } else {
                print("wrapper to tutor");
                return DashBoardTutor();
              }
            }
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
