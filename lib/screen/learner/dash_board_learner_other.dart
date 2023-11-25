import 'package:datn/screen/wrapper.dart';
import 'package:flutter/material.dart';

import '../../database/auth/firebase_auth_service.dart';

class DashBoardLearnerOther extends StatefulWidget {
  const DashBoardLearnerOther({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DashBoardLearnerOtherState();
  }
}

class _DashBoardLearnerOtherState extends State<DashBoardLearnerOther> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            OutlinedButton(
              onPressed: () async {
                FirebaseAuthService auth = FirebaseAuthService();
               await auth.signOut();
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (context) {
                  return const Wrapper();
                }), (route) => false);
              },
              child: const Text('Đăng xuất'),
            ),
          ],
        ),
      ),
    );
  }
}
