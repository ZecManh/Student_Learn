
import 'package:datn/screen/qr_code/qr_screen_test.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
class DashBoardQr extends StatefulWidget {
  const DashBoardQr({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DashBoardQrState();
  }
}

class _DashBoardQrState extends State<DashBoardQr> {
  String data = "";
  @override
  Widget build(BuildContext context) {
    print('dash board qr rebuild');

    return SafeArea(
      child: Scaffold(
       backgroundColor: const Color.fromARGB(255, 221, 255, 0),
       body: Column(
         mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
         children: [
          const Text('Qr của tôi'),
          Expanded(
              child: Center(
              child: QrImageView(
              data: 'NhamDucManh-61TNB-DHTL',
              version: QrVersions.auto,
              size: 200.0,
                      )),
          ),
          Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      
                      Expanded(
                        child: IconButton(
                          onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return const DashBoardQrScanner();
                              }));
                          },
                          icon: const Text('Camera Scanner'),
                        ),
                      ),
                    ],
                  ),
                ),
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
          // SizedBox(
          //   height: 24.0,
          // ),
          // RawMaterialButton(
          //   onPressed: () {},
          //   // fillColor: AppStyle.accentColor,
          //   shape: StadiumBorder(),
          //   padding: EdgeInsets.symmetric(
          //     horizontal: 36.0,
          //     vertical: 16.0,
          //   ),
          //   child: Text(
          //     "Generate QR Code",
          //   ),
          // )
         
                
        
         ],
       ),
      ),
    );
  }
}

