import 'package:datn/screen/authenticate/authenticate.dart';
import 'package:datn/screen/authenticate/choose_type_after_login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../database/auth/firebase_auth_service.dart';
import '../model/user.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final firebaseAuthService = Provider.of<FirebaseAuthService>(context);
    return StreamBuilder<User?>(
        stream: firebaseAuthService.user,
        builder: (context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final User? user = snapshot.data;
            if (user == null) {
              return Authenticate();
            } else {
              return ChooseTypeAfterLogin();
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
