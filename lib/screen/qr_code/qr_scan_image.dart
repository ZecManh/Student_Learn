import 'dart:io';

import 'package:datn/screen/qr_code/qr_screen_generate.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:scan/scan.dart';
import 'package:images_picker/images_picker.dart';

class QrScanImg extends StatefulWidget {
  @override
  _QrScanImgState createState() => _QrScanImgState();
}

class _QrScanImgState extends State<QrScanImg> {
  String qrcode = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
}
