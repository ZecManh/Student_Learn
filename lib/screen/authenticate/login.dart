
import 'package:datn/database/auth/firebase_auth_service.dart';
import 'package:datn/model/user.dart';
import 'package:datn/screen/authenticate/forget_password.dart';
import 'package:datn/screen/authenticate/sign_up.dart';
import 'package:datn/screen/learner/dash_board_learner.dart';
import 'package:datn/screen/tutor/dash_board_tutor.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import '../shared/loading.dart';
import 'choose_type.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.userType});

  final UserType userType;

  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FirebaseAuthService firebaseAuthService = FirebaseAuthService();
  bool passwordVisible = false;
  bool passwordValid = false;
  final _formKey = GlobalKey<FormState>();
  final _passwordKey = GlobalKey<FlutterPwValidatorState>();

  String? validateEmail(String? email) {
    String? _email = email?.trim();
    if (_email == null || _email.isEmpty) {
      return 'Vui lòng nhập email!';
    } else {
      bool isEmailOK = EmailValidator.validate(_email);
      if (isEmailOK) {
        return null;
      } else {
        return 'Email không hợp lệ! Vui lòng nhập lại';
      }
    }
  }

  // bool loading=false;

  Future login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    User? user = null;
    if (email != '' && password != '') {
      user =
      await firebaseAuthService.signInWithEmailAndPassword(email, password);
    }
    if (user != null) {
      SnackBar snackBar = SnackBar(
          content: Text('${user.email.toString()} Đăng nhập thành công'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      if(widget.userType==UserType.learner){
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) {
              return const DashBoardLearner();
            }), (route) => false);
      }else{
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) {
              return const DashBoardTutor();
            }), (route) => false);
      }



    } else {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
          Text('Đăng nhập không thành công,kiểm tra lại email và mật khẩu'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.userType == UserType.tutor
            ? 'Đăng nhập người dạy'
            : 'Đăng nhập người học'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Image.asset('assets/ic_logo_remove_bg.png'),
              Text(
                widget.userType == UserType.tutor
                    ? 'Dạy tốt cùng Tlu Tutor'
                    : 'Học tốt cùng Tlu Tutor',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            validator: validateEmail,
                            controller: emailController,
                            obscureText: false,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Email',
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            controller: passwordController,
                            obscureText: passwordVisible,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'Password',
                              suffixText: 'Ẩn/Hiện Mật Khẩu',
                              suffixIcon: IconButton(
                                onPressed: () {
                                  print('onclick');
                                  setState(() {
                                    print(passwordVisible);
                                    passwordVisible = !passwordVisible;
                                  });
                                },
                                icon: Icon(passwordVisible
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined),
                              ),
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
                              controller: passwordController)
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    OutlinedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Theme
                                  .of(context)
                                  .colorScheme
                                  .primary),
                          foregroundColor: MaterialStateProperty.all(
                              Theme
                                  .of(context)
                                  .colorScheme
                                  .background)),
                      onPressed: () {
                        print('go here');
                        FormState? emailFormState = _formKey.currentState;
                        if (emailFormState != null) {
                          if (_formKey.currentState!.validate() &&
                              passwordValid) {
                            login();
                          }
                        }
                      },
                      child: const Padding(
                        padding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Text(
                          'Đăng nhập',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            child: const Text('Đăng kí'),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return SignUpScreen(
                                    userType: widget.userType,
                                  );
                                }),
                              );
                            },
                          ),
                          GestureDetector(
                            child: const Text('Quên mật khẩu?'),
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                    return ForgetPasswordScreen();
                                  }));
                            },
                          )
                        ]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
