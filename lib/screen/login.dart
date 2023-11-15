import 'package:datn/auth/firebase_auth_service.dart';
import 'package:datn/screen/forget_password.dart';
import 'package:datn/screen/sign_up.dart';
import 'package:datn/viewmodel/user_model.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:provider/provider.dart';
import 'choose_type.dart';
import 'learner/dash_board.dart';

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

  Future login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    User? user;
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (email != '' && password != '') {
      user =
          await firebaseAuthService.signInWithEmailAndPassword(email, password);
    }
    if (user != null) {
      print(user.email.toString() + ' login successful');
      // await prefs.setString('email', user.email!);
      SnackBar snackBar = SnackBar(
          content: Text('${user.email.toString()} Đăng nhập thành công'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      // Navigator.push(context, MaterialPageRoute(builder: (context) {
      //   return DashBoardScreen();
      // }));

      // Navigator.of(context).pushAndRemoveUntil(
      //     MaterialPageRoute(builder: (context) {
      //   return const DashBoardScreen();
      // }), (route) => false);

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) {
        return ChangeNotifierProvider<UserModel>(
            create: (BuildContext context) {
              return UserModel();
            },
            child: const DashBoardScreen());
      }), (route) => false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Đăng nhập không thành công,kiểm tra lại email và mật khẩu')));
    }
  }

  // FirebaseAuthService authService = FirebaseAuthService();

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
                              Theme.of(context).colorScheme.primary),
                          foregroundColor: MaterialStateProperty.all(
                              Theme.of(context).colorScheme.background)),
                      onPressed: () {
                        print('go here');
                        FormState? emailFormState = _formKey.currentState;
                        if (emailFormState != null) {
                          print('go here 1');
                          if (_formKey.currentState!.validate() &&
                              passwordValid) {
                            print('validate email ok');
                            login();
                          }
                        }

                        // FlutterPwValidatorState? passwordFormState =
                        //     _passwordKey.currentState;
                        // if (passwordFormState != null) {
                        //   _passwordKey.currentState!.validate();
                        // }
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
