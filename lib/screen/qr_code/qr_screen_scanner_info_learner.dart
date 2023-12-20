import 'dart:io';
import 'package:datn/screen/qr_code/info_learner.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class DashBoardQrScannerLearner extends StatefulWidget {
  const DashBoardQrScannerLearner({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DashBoardQrScannerLearnerState();
  }
}

class _DashBoardQrScannerLearnerState extends State<DashBoardQrScannerLearner> {
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
              child: Text('Scan a code'),
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
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return InfoLearner();
          }));
        }
      });
    });
  }

  void navigateToNewPage() {
    // Xử lý dữ liệu từ mã QR và chuyển hướng đến trang mới
    // Ví dụ: chuyển hướng đến trang có tên là NewPage và truyền dữ liệu qua route
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
