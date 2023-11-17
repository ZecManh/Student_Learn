import 'package:datn/screen/choose_type.dart';
import 'package:flutter/material.dart';

import '../../auth/firebase_auth_service.dart';
import '../../database/auth/firebase_auth_service.dart';

class DashBoardOther extends StatefulWidget {
  const DashBoardOther({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DashBoardOtherState();
  }
}

class _DashBoardOtherState extends State<DashBoardOther> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange,
      child: Center(
        child: Column(
          children: [
            OutlinedButton(
              onPressed: () {
                FirebaseAuthService auth = FirebaseAuthService();
                auth.signOut();
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (context) {
                  return const ChooseTypeScreen();
                }), (route) => false);
              },
              child: const Text('Đăng xuất'),
            ),
            OutlinedButton(
              onPressed: () {},
              child: Text('Do some thing'),
            ),
          ],
        ),
      ),
    );
  }
}
