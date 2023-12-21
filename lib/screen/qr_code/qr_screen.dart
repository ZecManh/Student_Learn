import 'package:datn/screen/qr_code/qr_screen_generate.dart';
import 'package:datn/screen/qr_code/qr_screen_scanner.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class DashBoardQr extends StatefulWidget {
  const DashBoardQr({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DashBoardQrState();
  }
}

class _DashBoardQrState extends State<DashBoardQr> {
  String data = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Qr Code'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Qr của tôi'),
            Center(
                child: QrImageView(
              data: 'NhamDucManh-61TNB-DHTL',
              version: QrVersions.auto,
              size: 200.0,
            )),
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const DashBoardQrScanner();
                }));
              },
              icon: const Text('Camera Scanner'),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const DashBoardQrGenerate();
                }));
              },
              icon: const Text('Qr Generate'),
            ),
          ],
        ),
      ),
    );
  }
}
