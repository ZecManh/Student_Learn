import 'package:datn/screen/authenticate/authenticate.dart';
import 'package:datn/screen/authenticate/choose_type.dart';
import 'package:datn/screen/learner/dash_board_learner.dart';
import 'package:datn/screen/tutor/dash_board_tutor.dart';
import 'package:datn/viewmodel/user_type.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../database/auth/firebase_auth_service.dart';
import '../model/user.dart';

// lang nghe authStateChange lang nghe khi signout
class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final firebaseAuthService = Provider.of<FirebaseAuthService>(context);
    UserTypeModel userTypeModel = Provider.of<UserTypeModel>(context);
    return StreamBuilder<User?>(
        stream: firebaseAuthService.user,
        builder: (context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final User? user = snapshot.data;
            // return user == null ? Authenticate() : DashBoardLearner();
            if (user == null) {
              return Authenticate();
            } else {
              if (userTypeModel.userType == UserType.learner) {
                return DashBoardLearner();
              } else {
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

//khong hoat dong khi sign out
// class Wrapper extends StatelessWidget {
//   const Wrapper({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final authNotifier = Provider.of<FirebaseAuthService>(context);
//     return (authNotifier.isSignedIn != true)
//         ? Authenticate()
//         : DashBoardScreen();
//   }
// }

//khong hoat dong khi signOut
// class Wrapper extends StatelessWidget {
//   const Wrapper({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<FirebaseAuthService>(builder: (context, auth, child) {
//       print("isSignedIn ${auth.isSignedIn}");
//       return auth.isSignedIn ? DashBoardScreen() : Authenticate();
//     });
//   }
// }
