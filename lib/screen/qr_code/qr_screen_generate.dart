
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
class DashBoardQrGenerate extends StatefulWidget {
  const DashBoardQrGenerate({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DashBoardQrGenerateState();
  }
}

class _DashBoardQrGenerateState extends State<DashBoardQrGenerate> {
  String data = "";
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
      appBar: AppBar(
        title: const Text('Qr Generate'),
      ),
       body: Column(
         mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
         children: [
          const Text('Tạo QR'),
          Center(
            child: QrImageView(
            data: data,
            version: QrVersions.auto,
            size: 200.0,
          )),
          const SizedBox(
            height: 24,
          ),
          Container(
            width: 300.0,
            margin: const EdgeInsets.only(bottom: 20.0),
            child: TextField(
              //we will generate a new qr code when the input value change
              onChanged: (value) {
                setState(() {
                  data = value;
                });
              },
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
              ),
              decoration: const InputDecoration(
                hintText: "Mời nhập dữ liệu",
                filled: true,
                // fillColor: AppStyle.textInputColor,
                border: InputBorder.none,
              ),
            ),
          ),
         ],
       ),
      ),
    );
  }
}

