import 'package:datn/screen/choose_type.dart';
import 'package:datn/viewmodel/my_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

    return ChangeNotifierProvider<MyModel>(
      create: (BuildContext context) {
        return MyModel();
      },
      child: Container(
        color: Colors.orange,
        child: Center(
          child: Column(
            children: [
              OutlinedButton(
                onPressed: () {
                  FirebaseAuthService auth = FirebaseAuthService();
                  auth.logout(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const ChooseTypeScreen();
                  }));
                },
                child: const Text('Đăng xuất'),
              ),
              Container(
                child: Consumer<MyModel>(
                  builder: (context, myModel, child) {
                    return Column(children: [
                      Text(
                          'Display name : ${myModel.user.displayName ?? 'Khong co ten'} '),
                      Text(
                          'Email : ${myModel.user.email ?? 'Khong co email '} '),
                      Text(
                          'Born ${myModel.user.born ?? 'Khong co ngay sinh '}'),
                      Text('Phone ${myModel.user.phone ?? 'Khong co phone '}'),
                    ]);
                  },
                ),
              ),
              Consumer<MyModel>(
                builder: (context, myModel, child) {
                  return OutlinedButton(
                    onPressed: () {
                      myModel.changeSomething();
                    },
                    child: Text('Do some thing'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
