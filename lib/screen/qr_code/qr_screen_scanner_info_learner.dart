import 'dart:io';
import 'package:datn/screen/learner/learner_update_info.dart';
import 'package:datn/screen/qr_code/info_learner.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:provider/provider.dart';
import 'package:datn/model/user/user.dart' as model_user;
import 'dart:convert';
import 'package:datn/screen/learner/search_tutor/tutor_show_info.dart';
import 'package:datn/database/firestore/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
        title: Text('Qr Scanner kkkk'),
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
  void _initInfo(dynamic scanData) async {
    var dataScan = jsonDecode(scanData);
    if (dataScan['type'] == 'tutor') {
      var userFetch = await firestoreService.getTutorById(dataScan['uid']);
      if (userFetch != null) {
        print(userFetch);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    TuTorShowInfo(tutor: userFetch)));
        await this.controller!.pauseCamera();
        return;
      }

    }

    // Chuyển hướng đến trang khác dựa trên dữ liệu từ mã QR
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) {
    //     model_user.User user = Provider.of<model_user.User>(context);
    //     return Provider.value(value: userFetch, child:TuTorShowInfo());)
    //   }),
    // );
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) =>
    //             TuTorShowInfo(tutor: userFetch)));
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
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
