import 'package:datn/screen/learner/dash_board_learning.dart';
import 'package:datn/screen/learner/dash_board_main.dart';
import 'package:datn/screen/learner/dash_board_other.dart';
import 'package:flutter/material.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DashBoardScreenState();
  }
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  int currentPageIndex = 0;
  final List<Widget> _children = [
    DashBoardMain(),
    DashBoardLearning(),
    DashBoardOther()
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print('dash board rebuild');
    return Scaffold(
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          selectedIndex: currentPageIndex,
          destinations: [
            NavigationDestination(
                icon: Icon(Icons.home_outlined), label: 'Trang chủ'),
            NavigationDestination(
                icon: Icon(Icons.people_alt_outlined), label: 'Đang học'),
            NavigationDestination(
                icon: Icon(Icons.grid_view_outlined), label: 'Khác'),
          ],
        ),
        appBar: AppBar(
          title: Text('Learner Screen'),
        ),
        body: _children[currentPageIndex]);
  }
}
