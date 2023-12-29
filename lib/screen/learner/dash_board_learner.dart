import 'package:datn/model/user/user.dart' as model_user;
import 'package:datn/screen/learner/dash_board_learner_learning.dart';
import 'package:datn/screen/learner/dash_board_learner_main.dart';
import 'package:datn/screen/learner/dash_board_learner_other.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../database/firestore/firestore_service.dart';

class DashBoardLearner extends StatefulWidget {
  const DashBoardLearner({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DashBoardLearnerState();
  }
}

class _DashBoardLearnerState extends State<DashBoardLearner> {
  int currentPageIndex = 0;
  final List<Widget> _children = [
    const DashBoardLearnerMain(),
    const DashBoardLearnerLearning(),
    const DashBoardLearnerOther()
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FirestoreService firestoreService = FirestoreService();
    FirebaseAuth auth = FirebaseAuth.instance;
    firestoreService.getSubjectRequest();
    return MultiProvider(
      providers: [
        StreamProvider<model_user.User>(
          create: (_) => firestoreService.user(auth.currentUser!.uid),
          initialData: model_user.User(),
        ),
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
                  icon: Icon(Icons.people_alt_outlined), label: 'Đang học'),
              NavigationDestination(
                  icon: Icon(Icons.grid_view_outlined), label: 'Khác'),
            ],
          ),
          appBar: AppBar(
            title: const Text('Người học'),
          ),
          body: _children[currentPageIndex]),
    );
  }
}
