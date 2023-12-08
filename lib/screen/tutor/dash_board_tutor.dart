import 'package:datn/model/user/user.dart' as model_user;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../database/firestore/firestore_service.dart';
import 'dash_board_tutor_teaching.dart';
import 'dash_board_tutor_main.dart';
import 'dash_board_tutor_other.dart';

class DashBoardTutor extends StatefulWidget {
  const DashBoardTutor({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DashBoardTutorState();
  }
}

class _DashBoardTutorState extends State<DashBoardTutor> {
  int currentPageIndex = 0;
  final List<Widget> _children = [
    const DashBoardTutorMain(),
    const DashBoardTutorTeaching(),
    const DashBoardTutorOther()
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FirestoreService firestoreService = FirestoreService();
    FirebaseAuth auth = FirebaseAuth.instance;
    return MultiProvider(
      providers: [
        StreamProvider<model_user.User>(
          create: (_) => firestoreService.user(auth.currentUser!.uid),
          initialData: model_user.User(),
        )
      ],
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          bottomNavigationBar: NavigationBar(
            onDestinationSelected: (index) {
              setState(() {
                currentPageIndex = index;
              });
            },
            selectedIndex: currentPageIndex,
            destinations: const [
              NavigationDestination(
                  icon: Icon(Icons.home_outlined), label: 'Trang chủ'),
              NavigationDestination(
                  icon: Icon(Icons.people_alt_outlined), label: 'Đang dạy'),
              NavigationDestination(
                  icon: Icon(Icons.grid_view_outlined), label: 'Khác'),
            ],
          ),
          appBar: AppBar(
            title: const Text('Gia sư'),
          ),
          body: _children[currentPageIndex]),
    );
  }
}
