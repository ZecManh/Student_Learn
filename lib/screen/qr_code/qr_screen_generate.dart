import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

// import 'package:random_string/random_string.dart';
class DashBoardQrGenerate extends StatefulWidget {
  const DashBoardQrGenerate({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DashBoardQrGenerateState();
  }
}

class _DashBoardQrGenerateState extends State<DashBoardQrGenerate> {
  String _randomData = '';
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    print('dash board qr rebuild');

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Random QR Code Scanner'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            QrImageView(
              data: _randomData,
              size: 200.0,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: generateRandomQRCode,
              child: Text('Tạo QR Code Ngẫu Nhiên'),
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }

  void generateRandomQRCode() {
    setState(() {
      _randomData = generateRandomString(10);
    });
  }

  String generateRandomString(int length) {
    const charset = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random();
    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => charset.codeUnitAt(random.nextInt(charset.length)),
      ),
    );
  }
}
