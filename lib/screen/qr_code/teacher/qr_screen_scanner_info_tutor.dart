import 'dart:io';
import 'package:datn/screen/qr_code/student/info_learner.dart';
import 'package:datn/screen/tutor/update/tutor_info.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:convert';
import 'package:datn/screen/learner/search_tutor/tutor_show_info.dart';
import 'package:datn/database/firestore/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  FirebaseAuth auth = FirebaseAuth.instance;
  FirestoreService firestoreService = FirestoreService();
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

  void _initInfo(dynamic scanData) async {
    var dataScan = jsonDecode(scanData);
    if (dataScan['type'] == 'tutor') {
      var userFetch = await firestoreService.getTutorById(dataScan['uid']);
      if (userFetch != null) {
        print(userFetch);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TuTorShowInfo(tutor: userFetch)));
        await this.controller!.pauseCamera();
        return;
      }
    }
    if (dataScan['type'] == 'class') {
      var dataFetch = await firestoreService.getClassById(dataScan['uid']);
      if (dataFetch != null) {
        print(dataFetch);
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => TuTorShowInfo(tutor: userFetch)));
        await this.controller!.pauseCamera();
        return;
      }
    }
  }

  void _onQRViewCreated(QRViewController controller) async {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
      if (result!.code != null) {
        _initInfo(result!.code);
      }
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
