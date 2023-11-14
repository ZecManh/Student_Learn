import 'package:flutter/material.dart';

class DashBoardFaceID extends StatefulWidget {
  const DashBoardFaceID({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DashBoardFaceIDState();
  }
}

class _DashBoardFaceIDState extends State<DashBoardFaceID> {
  String data = "";
  @override
  Widget build(BuildContext context) {
    print('dash board qr rebuild');

    return SafeArea(
      child: const Scaffold(),
    );
  }
}
