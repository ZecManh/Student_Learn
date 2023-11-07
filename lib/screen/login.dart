import 'package:datn/auth/firebase_auth_service.dart';
import 'package:datn/screen/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  Future<User?> login() async {
    String email = emailController.text;
    String password = passwordController.text;
    User? user = null;

    if (email != '' && password != '') {
      user =
          await firebaseAuthService.signInWithEmailAndPassword(email, password);
    }
    if (user != null) {
      print(user.email.toString() + ' login successful');
      SnackBar snackBar =
          SnackBar(content: Text('${user.email.toString()} login successful'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      print('Some error happened');
    }
  }

  // FirebaseAuthService authService = FirebaseAuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Login'),
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
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Form(
                      child: Column(
                        children: [
                          TextFormField(
                            // validator: ,
                            controller: emailController,
                            obscureText: false,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Email',
                            ),
                          )   ,

                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: passwordController,
                            obscureText: passwordVisible,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
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
                        ],
                      ),
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
                        // Navigator.pop(context,emailController.text);
                        login();
                        //if login successfull -> pop ...
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return DashBoardScreen();
                        }));
                      },
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Text(
                          'Đăng nhập',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            child: Text('Đăng kí'),
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return SignUpScreen();
                              }));
                            },
                          ),
                          Text('Quên mật khẩu?')
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
