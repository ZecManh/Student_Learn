import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';


class QRCodeView extends StatefulWidget {
  final String? text;
  QRCodeView({ this.text});

  @override
  _QRCodeView createState() => _QRCodeView();
}


class _QRCodeView extends State<QRCodeView> {
  String? textQr;

  @override
  Widget build(BuildContext context) {
    setState(() {
      textQr : widget?.text;
    });
    return Container(
      child:
      Column(
          children: [
            Center(
          child: (textQr != null)
              ? QrImageView(
            data: "$textQr",
            version: QrVersions.auto,
            size: 200.0,
          )
              : QrImageView(
            data:
            'Dữ liệu chưa được cập nhật khi chưa điền đủ thông tin',
            version: QrVersions.auto,
            size: 200.0,
          )),
            Center(
          child: IconButton(
            onPressed: () {},
            icon: const Text('Tải QR về thiết bị'),
          ),
        ),
          ]),
    );
  }
}