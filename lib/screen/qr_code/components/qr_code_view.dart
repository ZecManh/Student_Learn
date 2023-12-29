import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/rendering.dart';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:path_provider/path_provider.dart';
class QRCodeView extends StatefulWidget {
  final String? text;

  QRCodeView({ this.text});

  @override
  _QRCodeView createState() => _QRCodeView();
}


class _QRCodeView extends State<QRCodeView> {

  String data = '';
  final GlobalKey _qrkey = GlobalKey();
  bool dirExists = false;
  dynamic externalDir = '/storage/emulated/0/Download';

  // Future<String> getGalleryPath() async {
  //   final directory = await getDownloadsDirectory();
  //   final galleryPath = '${directory?.path}';
  //   // final downloadsDirectory = await DownloadsPathProvider.downloadsDirectory;
  //   // return downloadsDirectory.path;
  //   print("galleryPath");
  //   print(directory);
  //   print(galleryPath);
  //   return galleryPath;
  // }

  Future<void> _captureAndSavePng() async {
    try{
      RenderRepaintBoundary boundary = _qrkey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      var image = await boundary.toImage(pixelRatio: 3.0);
      // final externalDir = await getGalleryPath();
      //Drawing White Background because Qr Code is Black
      final whitePaint = Paint()..color = Colors.white;
      final recorder = PictureRecorder();
      final canvas = Canvas(recorder,Rect.fromLTWH(0,0,image.width.toDouble(),image.height.toDouble()));
      canvas.drawRect(Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()), whitePaint);
      canvas.drawImage(image, Offset.zero, Paint());
      final picture = recorder.endRecording();
      final img = await picture.toImage(image.width, image.height);
      ByteData? byteData = await img.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      //Check for duplicate file name to avoid Override
      String fileName = 'qr_code';
      int i = 1;
      while(await File('$externalDir/$fileName.png').exists()){
        fileName = 'qr_code_$i';
        i++;
      }

      // Check if Directory Path exists or not
      dirExists = await File(externalDir).exists();
      //if not then create the path
      if(!dirExists){
        await Directory(externalDir).create(recursive: true);
        dirExists = true;
      }

      final file = await File('$externalDir/$fileName.png').create();
      await file.writeAsBytes(pngBytes);

      if(!mounted)return;
      const snackBar = SnackBar(content: Text('Mã QR đã được lưu vào thư viện'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

    }catch(e){
      if(!mounted)return;
      const snackBar = SnackBar(content: Text('Đã xảy ra lỗi!!!'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child:
      Column(
          children: [
            Center(
              child: RepaintBoundary(
                  key: _qrkey,
                  child:
                   QrImageView(
        data: (widget?.text != null ||widget?.text != "" ? "${widget.text}" : "Dữ liệu chưa được cập nhật khi chưa điền đủ thông tin"),
        version: QrVersions.auto,
        size: 200.0,
                     gapless: true,
                     errorStateBuilder: (ctx, err) {
                       return const Center(
                         child: Text(
                           'Đã xảy ra lỗi!!!',
                           textAlign: TextAlign.center,
                         ),
                       );
                     },
         )
        )),
            Center(
          child: IconButton(
            onPressed: () {
              _captureAndSavePng();
            },
            icon: const Text('Tải QR về thiết bị'),
          ),
        ),
          ]),
    );
  }
}