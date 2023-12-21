import 'dart:io';

import 'package:datn/screen/qr_code/info_tutor.dart';

import 'package:datn/screen/tutor/update/tutor_update_info.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:scan/scan.dart';
import 'package:images_picker/images_picker.dart';
import 'package:datn/model/user/user.dart' as model_user;

class QrScanImgTutor extends StatefulWidget {
  @override
  _QrScanImgTutorState createState() => _QrScanImgTutorState();
}

class _QrScanImgTutorState extends State<QrScanImgTutor> {
  String qrcode = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    model_user.User user = Provider.of<model_user.User>(context);
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return Provider.value(
                                    value: user, child: InfoTutor());
                              }),
                            );
                          }
                        });
                      }
                    }
                  },
                ),
              )
              // ElevatedButton(
              //   child: Text('go scan page'),
              //   onPressed: () {
              //     Navigator.push(context,
              //         MaterialPageRoute(builder: (_) {
              //       return DashBoardQrGenerate();
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
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => const TutorInfo(),
  //     ),
  //   );
  // }
}
