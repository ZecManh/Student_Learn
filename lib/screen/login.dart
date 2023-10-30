import 'package:flutter/cupertino.dart';

enum UserType { learner, tutor }

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.userType});

  final UserType userType;

  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return const Text('Login');
  }
}
