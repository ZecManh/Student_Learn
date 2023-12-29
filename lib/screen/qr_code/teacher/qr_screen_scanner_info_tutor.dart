import 'dart:io';
import 'package:datn/screen/qr_code/student/info_learner.dart';
import 'package:datn/screen/tutor/update/tutor_info.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class DashBoardQrScannerTutor extends StatefulWidget {
  const DashBoardQrScannerTutor({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DashBoardQrScannerTutorState();
  }
}

class _DashBoardQrScannerTutorState extends State<DashBoardQrScannerTutor> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Qr Scanner'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: (result != null)
                  ? Column(
                      children: [
                        Padding(padding: EdgeInsets.all(10.0)),
                        Text('${result!.code}'),
                      ],
                    )
                  : const Text('Scan a code'),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        if (result != null) {
          // Chuyển hướng đến trang khác dựa trên dữ liệu từ mã QR
          navigateToNewPage();
        }
      });
    });
  }

  void navigateToNewPage() {
    // Xử lý dữ liệu từ mã QR và chuyển hướng đến trang mới
    // Ví dụ: chuyển hướng đến trang có tên là NewPage và truyền dữ liệu qua route
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TutorInfo(),
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
