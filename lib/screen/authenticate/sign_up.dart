import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datn/database/auth/firebase_auth_service.dart';
import 'package:datn/model/user.dart';
import 'package:datn/screen/authenticate/choose_type.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';

import '../../database/firestore/firestore_service.dart';

class SignUpScreen extends StatefulWidget {
  final UserType userType;

  const SignUpScreen({super.key, required this.userType});

  @override
  State<StatefulWidget> createState() {
    return _SignUpScreenState();
  }
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordReassignController = TextEditingController();
  FirebaseAuthService firebaseAuthService = FirebaseAuthService();
  bool passwordValid = false;
  bool passwordReAssignValid = false;
  bool twoPasswordEqual = false;
  bool passwordVisible = false;
  bool passwordReAssignVisible = false;
  final _formKey = GlobalKey<FormState>();
  final _passwordKey = GlobalKey<FlutterPwValidatorState>();
  final _passwordReAssignKey = GlobalKey<FlutterPwValidatorState>();

  FirestoreService firestoreService = FirestoreService();

  void _signUp() async {
    await Firebase.initializeApp();
    String email = emailController.text;
    String password = passwordController.text;
    String passwordReassign = passwordReassignController.text;
    User? user ;
    if (email != '' && (password == passwordReassign)) {
      user = await firebaseAuthService.createUserWithEmailAndPassword(
          email, password);
    }
    if (user != null) {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'display_name': user.displayName,
        'email': user.email,
        'phone': user.phone,
        'photo_url': user.photoUrl,
        'born': user.born,
        'gender': user.gender
      });

      SnackBar snackBar = SnackBar(
          content: Text('${user.email.toString()} đăng kí thành công'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Đăng kí không thành công,tài khoản đã được sử dụng')));
    }
  }

  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Vui lòng nhập email!';
    } else {
      bool isEmailOK = EmailValidator.validate(email);
      if (isEmailOK) {
        return null;
      } else {
        return 'Email không hợp lệ! Vui lòng nhập lại';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.userType == UserType.tutor
            ? 'Đăng kí người dạy'
            : 'Đăng kí người học'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Center(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: validateEmail,
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      obscureText: false,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Nhập email',
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      obscureText: passwordVisible,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Nhập mật khẩu',
                          suffixText: 'Ẩn/Hiện',
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                passwordVisible = !passwordVisible;
                              });
                            },
                            icon: Icon(passwordVisible
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined),
                          )),
                    ),
                    FlutterPwValidator(
                        key: _passwordKey,
                        width: 400,
                        height: 100,
                        minLength: 6,
                        numericCharCount: 1,
                        onSuccess: () {
                          passwordValid = true;
                        },
                        onFail: () {
                          passwordValid = false;
                        },
                        controller: passwordController),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: passwordReassignController,
                      keyboardType: TextInputType.text,
                      obscureText: passwordReAssignVisible,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Nhập lại mật khẩu',
                          suffixText: 'Ẩn/Hiện',
                          suffixIcon: IconButton(
                            icon: Icon(passwordReAssignVisible
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined),
                            onPressed: () {
                              setState(() {
                                passwordReAssignVisible =
                                    !passwordReAssignVisible;
                              });
                            },
                          )),
                    ),
                    FlutterPwValidator(
                        key: _passwordReAssignKey,
                        width: 400,
                        height: 100,
                        minLength: 6,
                        numericCharCount: 1,
                        onSuccess: () {
                          passwordReAssignValid = true;
                        },
                        onFail: () {
                          passwordReAssignValid = false;

                        },
                        controller: passwordReassignController)
                  ],
                )),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Khi đăng nhập hoặc đăng kí,tôi đã đồng ý với Điều khoản và Chính sách bảo mật',
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            OutlinedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).colorScheme.primary),
                  foregroundColor: MaterialStateProperty.all(
                      Theme.of(context).colorScheme.background)),
              onPressed: () {
                FormState? emailFormState = _formKey.currentState;
                if (emailFormState != null) {
                  if (passwordController.text ==
                      passwordReassignController.text) {
                    twoPasswordEqual = true;
                  } else {
                    twoPasswordEqual = false;
                  }
                  if (!emailFormState.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Email không hợp lệ')));
                  } else if (passwordController.text.isEmpty ||
                      passwordReassignController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Vui lòng nhập mật khẩu')));
                  } else if (twoPasswordEqual == false) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('2 mật khẩu không trùng khớp')));
                  } else if (_formKey.currentState!.validate() &&
                      passwordValid &&
                      passwordReAssignValid &&
                      twoPasswordEqual) {
                    _signUp();
                  }
                }
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text(
                  'Đăng kí',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Đã có tài khoản? Đăng nhập ngay!',
                textAlign: TextAlign.center,
              ),
            )
          ]),
        ),
      ),
    );
  }
}
