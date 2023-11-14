import 'package:datn/screen/login.dart';
import 'package:flutter/material.dart';

enum UserType { tutor, learner }

class ChooseTypeScreen extends StatefulWidget {
  const ChooseTypeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ChooseTypeScreenState();
  }
}

class _ChooseTypeScreenState extends State<ChooseTypeScreen> {
  UserType type = UserType.learner;
  Color tutorColor = Colors.white;
  Color learnerColor = Colors.white;

  void getColor() {
    if (type == UserType.tutor) {
      tutorColor = Theme.of(context).colorScheme.primary;
      learnerColor = Theme.of(context).colorScheme.background;
    } else {
      tutorColor = Theme.of(context).colorScheme.background;
      learnerColor = Theme.of(context).colorScheme.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bạn là ai ?'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(
                height: 40,
              ),
              const Image(
                image: AssetImage('assets/ic_logo_remove_bg.png'),
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                'Bạn là ai ?',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(40),
                          ),
                          side: BorderSide(color: tutorColor),
                        ),
                        color: Theme.of(context).colorScheme.primaryContainer,
                        child: TextButton.icon(
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  const EdgeInsets.all(20))),
                          onPressed: () {
                            setState(() {
                              type = UserType.tutor;
                              getColor();

                              SnackBar snackBar =
                                  const SnackBar(content: Text('Bạn đã chọn là người dạy'));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            });
                          },
                          icon: Image.asset('assets/ic_teacher.png', width: 50),
                          label: const Text(
                            'Tôi là người dạy',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(40),
                          ),
                          side: BorderSide(color: learnerColor),
                        ),
                        color: Theme.of(context).colorScheme.primaryContainer,
                        child: TextButton.icon(
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  const EdgeInsets.all(20))),
                          onPressed: () {
                            setState(() {
                              type = UserType.learner;
                              getColor();
                              SnackBar snackBar =
                              const SnackBar(content: Text('Bạn đã chọn là người học'));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            });
                          },
                          icon: Image.asset('assets/ic_student.png', width: 50),
                          label: const Text(
                            'Tôi là người học',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      )
                    ]),
              ),
              const SizedBox(
                height: 40,
              ),
              OutlinedButton.icon(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  LoginScreen(userType: type,),
                      ));
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
