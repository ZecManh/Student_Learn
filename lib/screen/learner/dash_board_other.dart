import 'package:datn/screen/choose_type.dart';
import 'package:flutter/material.dart';

import '../../auth/firebase_auth_service.dart';

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
    print('dash board other rebuild');

    return Container(
      child: Column(
        children: [
          OutlinedButton(
            onPressed: () {
              FirebaseAuthService auth=FirebaseAuthService();
              auth.logout(context);
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return const ChooseTypeScreen();
              }));
            },
            child: const Text('Đăng xuất'),
          ),
        ],
      ),
    );
  }
}
