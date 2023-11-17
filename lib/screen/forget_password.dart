import 'package:datn/auth/firebase_auth_service.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import '../database/auth/firebase_auth_service.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ForgetPasswordScreenState();
  }
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formEmailKey = GlobalKey<FormState>();
  FirebaseAuthService firebaseAuthService = FirebaseAuthService();
  final TextEditingController _emailController = TextEditingController();

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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quên mật khẩu'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Image.asset('assets/ic_logo_remove_bg.png'),
              const Text(
                'Nhập email của bạn để khôi phục mật khẩu',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                    key: _formEmailKey,
                    child: TextFormField(
                      validator: validateEmail,
                      controller: _emailController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: 'Email'),
                      obscureText: false,
                      // validator: ,
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      OutlinedButton(
                          onPressed: () {
                            FormState? emailFormState =
                                _formEmailKey.currentState;
                            if (emailFormState!.validate()) {
                              print('validate email ok');
                              firebaseAuthService.resetPassword(
                                  _emailController.text.trim(), context);
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Text(
                              'Gửi',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Theme.of(context).colorScheme.primary),
                              foregroundColor: MaterialStateProperty.all(
                                  Theme.of(context).colorScheme.background))),
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
