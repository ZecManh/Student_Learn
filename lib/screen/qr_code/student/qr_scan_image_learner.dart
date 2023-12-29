import 'dart:io';

import 'package:datn/database/auth/firebase_auth_service.dart';
import 'package:datn/screen/qr_code/student/info_learner.dart';
import 'package:flutter/material.dart';
import 'package:scan/scan.dart';
import 'package:images_picker/images_picker.dart';
import 'package:provider/provider.dart';
import 'package:datn/model/user/user.dart' as model_user;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:datn/database/firestore/firestore_service.dart';
import 'dart:convert';
import 'package:datn/screen/learner/search_tutor/tutor_show_info.dart';

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
    model_user.User user = Provider.of<model_user.User>(context);
    FirebaseAuth auth = FirebaseAuth.instance;
    FirestoreService firestoreService = FirestoreService();
    void _initInfo(dynamic scanData) async {
      var dataScan = jsonDecode(scanData);
      if (dataScan['type'] == 'tutor') {
        var userFetch = await firestoreService.getTutorById(dataScan['uid']);
        if (userFetch != null) {
          // print(userFetch);
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) =>
          //             TuTorShowInfo(tutor: userFetch)));

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return Provider.value(
                  value: user, child: TuTorShowInfo(tutor: userFetch));
            }),
          );
          return;
        }
      }
    }

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
                          if (qrcode != null) {
                            _initInfo(qrcode);
                          }
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
          // Text('${qrcode}'),
        ],
      ),
    );
  }
}
