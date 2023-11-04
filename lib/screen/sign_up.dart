import 'package:datn/auth/firebase_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SignUpScreenState();
  }
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordReassignController = TextEditingController();
  FirebaseAuthService firebaseAuthService = FirebaseAuthService();

  void _signUp() async {
    await Firebase.initializeApp();
    String email = emailController.text;
    String password = passwordController.text;
    String passwordReassign = passwordReassignController.text;
    User? user = null;
    if (email != '' && (password == passwordReassign)) {
      user = await firebaseAuthService.createAccount(email, password);
    }
    if (user != null) {
      print('Created account successfully');
      SnackBar snackBar=SnackBar(content: Text('${user.email.toString()} create successful'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      print('Some error happened');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign up'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Center(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nhập email',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: passwordController,
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nhập mật khẩu',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: passwordReassignController,
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nhập lại mật khẩu',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Khi đăng nhập hoặc đăng kí,tôi đã đồng ý với Điều khoản và Chính sách bảo mật',
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            OutlinedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).colorScheme.primary),
                  foregroundColor: MaterialStateProperty.all(
                      Theme.of(context).colorScheme.background)),
              onPressed: () {
                _signUp();
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text(
                  'Đăng kí',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Đã có tài khoản? Đăng nhập ngay!',
              textAlign: TextAlign.center,
            )
          ]),
        ),
      ),
    );
  }
}
