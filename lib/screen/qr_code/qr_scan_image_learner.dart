import 'dart:io';

import 'package:datn/database/auth/firebase_auth_service.dart';
import 'package:datn/screen/learner/learner_update_info.dart';
import 'package:datn/screen/qr_code/info_learner.dart';
import 'package:flutter/material.dart';
import 'package:scan/scan.dart';
import 'package:images_picker/images_picker.dart';
import 'package:provider/provider.dart';
import 'package:datn/model/user/user.dart' as model_user;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:datn/database/firestore/firestore_service.dart';

class QrScanImgLearner extends StatefulWidget {
  @override
  _QrScanImgLearnerState createState() => _QrScanImgLearnerState();
}

class _QrScanImgLearnerState extends State<QrScanImgLearner> {
  String qrcode = '';
  FirebaseAuthService firebaseAuthService = FirebaseAuthService();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // model_user.User user = Provider.of<model_user.User>(context);
    // FirebaseAuth auth = firebaseAuthService.auth;
    // FirestoreService firestoreService = Provider.of<FirestoreService>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quét QR qua ảnh'),
      ),
      body: Column(
        children: [
          Wrap(
            children: [
              Padding(padding: EdgeInsets.all(10.0)),
              Center(
                child: ElevatedButton(
                  child: Text("Chọn ảnh quét QR"),
                  onPressed: () async {
                    List<Media>? res = await ImagesPicker.pick();
                    if (res != null) {
                      String? str = await Scan.parse(res[0].path);
                      if (str != null) {
                        setState(() {
                          qrcode = str;
                          // if (qrcode != null) {
                          //   Navigator.push(
                          //     context,
                          //     MaterialPageRoute(builder: (context) {
                          //       return Provider.value(
                          //           value: user, child: UpdateInfoLearner());
                          //     }),
                          //   );
                          // }
                        });
                      }
                    }
                  },
                ),
              ),
              // ElevatedButton(
              //   child: Text('go scan page'),
              //   onPressed: () {
              //     Navigator.push(context, MaterialPageRoute(builder: (_) {
              //       return InfoLearner();
              //     }));
              //   },
              // ),
            ],
          ),
          Text('$qrcode'),
        ],
      ),
    );
  }

  // void navigateToNewPage() {
  //   // Xử lý dữ liệu từ mã QR và chuyển hướng đến trang mới
  //   // Ví dụ: chuyển hướng đến trang có tên là NewPage và truyền dữ liệu qua route
  // }
}
