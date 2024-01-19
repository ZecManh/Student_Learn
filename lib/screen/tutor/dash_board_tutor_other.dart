import 'package:datn/screen/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../database/auth/firebase_auth_service.dart';
import '../face_recognition/camera_page.dart';

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
    return Center(
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
          OutlinedButton(
            onPressed: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FaceScanScreen(
                          username:
                              FirebaseAuth.instance.currentUser?.email ?? '')));
            },
            child: const Text('Đăng kí khuôn mặt'),
          ),
        ],
      ),
    );
  }
}
