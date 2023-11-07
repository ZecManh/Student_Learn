import 'package:flutter/material.dart';

class DashBoardQr extends StatefulWidget {
  const DashBoardQr({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DashBoardQrState();
  }
}

class _DashBoardQrState extends State<DashBoardQr> {
  @override
  Widget build(BuildContext context) {
    print('dash board qr rebuild');

    return Text('qr');
  }
}
