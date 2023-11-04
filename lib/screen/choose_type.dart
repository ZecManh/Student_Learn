import 'package:datn/screen/login.dart';
import 'package:flutter/material.dart';

class ChooseTypeScreen extends StatefulWidget {
  const ChooseTypeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ChooseTypeScreenState();
  }
}

class _ChooseTypeScreenState extends State<ChooseTypeScreen> {
  bool type = true;
  Color tutorColor = Colors.white;
  Color learnerColor = Colors.white;

  void getColor() {
    if (type == true) {
      tutorColor = Theme.of(context).colorScheme.primary;
      learnerColor = Theme.of(context).colorScheme.background;
    } else {
      tutorColor = Theme.of(context).colorScheme.background;
      learnerColor = Theme.of(context).colorScheme.primary;
    }
  }

  //pass data children to parent
  // Future<String> getResultFromLogin() async {
  //   return await Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => const LoginScreen(),
  //       ));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose your type'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: 40,
              ),
              Image(
                image: AssetImage('assets/ic_logo_remove_bg.png'),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                'Bạn là ai ?',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(40),
                          ),
                          side: BorderSide(color: tutorColor),
                        ),
                        color: Theme.of(context).colorScheme.primaryContainer,
                        child: TextButton.icon(
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  EdgeInsets.all(20))),
                          onPressed: () {
                            setState(() {
                              type = true;
                              getColor();
                            });
                          },
                          icon: Image.asset('assets/ic_teacher.png', width: 50),
                          label: Text(
                            'Tôi là người dạy',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(40),
                          ),
                          side: BorderSide(color: learnerColor),
                        ),
                        color: Theme.of(context).colorScheme.primaryContainer,
                        child: TextButton.icon(
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  EdgeInsets.all(20))),
                          onPressed: () {
                            setState(() {
                              type = false;
                              getColor();
                            });
                          },
                          icon: Image.asset('assets/ic_student.png', width: 50),
                          label: Text(
                            'Tôi là người học',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      )
                    ]),
              ),
              SizedBox(
                height: 40,
              ),
              OutlinedButton.icon(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen(),));

                  // getResultFromLogin().then((value) {
                  //   if (value[0] is String) {
                  //     print('Email is ${value}');
                  //     SnackBar snackbar =
                  //         SnackBar(content: Text('Email is $value'));
                  //     ScaffoldMessenger.of(context).showSnackBar(snackbar);
                  //   }
                  // });
                },
                icon: Icon(Icons.arrow_forward_rounded,
                    color: Theme.of(context).colorScheme.background),
                label: Text(
                  'Tiếp theo',
                  style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.background),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).colorScheme.primary)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
