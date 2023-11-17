import 'package:datn/screen/choose_type.dart';
import 'package:datn/screen/learner/dash_board.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../database/auth/firebase_auth_service.dart';
import '../model/user.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final firebaseAuthService = Provider.of<FirebaseAuthService>(context);
    return StreamBuilder<User?>(
        stream: firebaseAuthService.user,
        builder: (context, AsyncSnapshot<User?> snapshot) {
          print('WRAPPER SCREEN : CHECKING AUTH USER');
          if (snapshot.connectionState == ConnectionState.active) {
            final User? user = snapshot.data;
            return user == null ? ChooseTypeScreen() : DashBoardScreen();
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
