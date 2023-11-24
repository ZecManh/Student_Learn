import 'package:datn/screen/authenticate/choose_type.dart';
import 'package:flutter/material.dart';

import '../../database/auth/firebase_auth_service.dart';

class DashBoardTutorOther extends StatefulWidget {
  const DashBoardTutorOther({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DashBoardTutorOtherState();
  }
}

class _DashBoardTutorOtherState extends State<DashBoardTutorOther> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            OutlinedButton(
              onPressed: () {
                FirebaseAuthService auth = FirebaseAuthService();
                auth.signOut();
                // Navigator.pushAndRemoveUntil(context,
                //     MaterialPageRoute(builder: (context) {
                //   return const ChooseTypeScreen();
                // }), (route) => false);
              },
              child: const Text('Đăng xuất'),
            ),
          ],
        ),
      ),
    );
  }
}
