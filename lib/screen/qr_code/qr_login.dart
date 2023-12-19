// import 'package:flutter/material.dart';
// import 'package:qr_flutter/qr_flutter.dart';
// import 'package:provider/provider.dart';
// import 'package:datn/database/firestore/firestore_service.dart';
// import 'package:datn/model/user/user.dart' as model_user;

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     model_user.User user = Provider.of<model_user.User>(context);
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('QR Code Login Example'),
//         ),
//         body: Center(
//           child: QrImageView(
//             data: '${user.uid}', // Thông tin đăng nhập hoặc mã người dùng
//             version: QrVersions.auto,
//             size: 200.0,
//           ),
//         ),
//       ),
//     );
//   }
// }
