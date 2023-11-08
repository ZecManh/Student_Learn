import 'package:datn/auth/firebase_auth_service.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';

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
  bool passwordValid = false;
  bool passwordReAssignValid = false;
  bool twoPasswordEqual = false;
  final _formKey = GlobalKey<FormState>();
  final _passwordKey = GlobalKey<FlutterPwValidatorState>();
  final _passwordReAssignKey = GlobalKey<FlutterPwValidatorState>();

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
      SnackBar snackBar =
          SnackBar(content: Text('${user.email.toString()} create successful'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      print('Some error happened');
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
        title: Text('Sign up'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
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
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Nhập email',
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Nhập mật khẩu',
                      ),
                    ),
                    FlutterPwValidator(
                        key: _passwordKey,
                        width: 400,
                        height: 100,
                        minLength: 6,
                        numericCharCount: 1,
                        onSuccess: () {
                          print("MATCHED");
                          passwordValid = true;
                          print('password valid $passwordValid');
                        },
                        onFail: () {
                          print("NOT MATCHED");
                          passwordValid = false;
                          print('password valid $passwordValid');
                        },
                        controller: passwordController),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: passwordReassignController,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Nhập lại mật khẩu',
                      ),
                    ),
                    FlutterPwValidator(
                        key: _passwordReAssignKey,
                        width: 400,
                        height: 100,
                        minLength: 6,
                        numericCharCount: 1,
                        onSuccess: () {
                          print("MATCHED");
                          passwordReAssignValid = true;
                          print(
                              'password reassign valid $passwordReAssignValid');
                        },
                        onFail: () {
                          print("NOT MATCHED");
                          passwordReAssignValid = false;
                          print(
                              'password reassign valid $passwordReAssignValid');
                        },
                        controller: passwordReassignController)
                  ],
                )),
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
                print('go here');
                FormState? emailFormState = _formKey.currentState;
                if (emailFormState != null) {
                  print('go here 1');
                  if (passwordController.text ==
                      passwordReassignController.text) {
                    twoPasswordEqual = true;
                  } else {
                    twoPasswordEqual = false;
                  }
                  if(twoPasswordEqual==false){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('2 mật khẩu không trùng khớp'))
                    );
                  }
                  if (_formKey.currentState!.validate() &&
                      passwordValid &&
                      passwordReAssignValid &&
                      twoPasswordEqual) {
                    print('validate email ok');
                    _signUp();
                  }
                }
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
