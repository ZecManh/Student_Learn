import 'package:flutter/material.dart';

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

    return Text('other');
  }
}
