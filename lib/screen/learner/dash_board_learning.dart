import 'package:flutter/material.dart';

class DashBoardLearning extends StatefulWidget {
  const DashBoardLearning({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DashBoardLearningState();
  }
}

class _DashBoardLearningState extends State<DashBoardLearning> {
  @override
  Widget build(BuildContext context) {
    print('dash board learning rebuild');

    return Text('leaning');
  }
}
