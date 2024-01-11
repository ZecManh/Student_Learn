import 'dart:io';
import 'dart:math';
import 'package:datn/screen/qr_code/student/info_learner.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:provider/provider.dart';
import 'package:datn/model/user/user.dart' as model_user;
import 'dart:convert';
import 'package:datn/screen/learner/search_tutor/tutor_show_info.dart';
import 'package:datn/database/firestore/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:datn/screen/learner/learning/class_info_learner.dart';
import 'package:datn/model/user/teach_schedules.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datn/model/subject_request/schedules.dart';

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
        title: Text('Quét QR Qua Camera'),
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

  Duration getTimeDuration(Map<String, dynamic> timestampJson) {
    int seconds = timestampJson['seconds'];
    int nanoseconds = timestampJson['nanoseconds'];
    int microseconds = (seconds * 1000000) + (nanoseconds / 1000).round();
    Timestamp getTimeCheck = Timestamp.fromMicrosecondsSinceEpoch(
        microseconds);
    DateTime timestampCheck = DateTime.fromMillisecondsSinceEpoch(
        getTimeCheck.seconds * 1000);

    Duration timeCheck = timestampCheck.difference(DateTime.now());
    return timeCheck;
  }

  void _initInfo(dynamic scanData) async {
    var dataScan = jsonDecode(scanData);
    if (dataScan['type'] == 'tutor') {
      var userFetch = await firestoreService.getUserById(dataScan['uid']);
      if (userFetch != null) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TuTorShowInfo(tutor: userFetch)));
        await this.controller!.pauseCamera();
        return;
      }
    }
    // if (dataScan['type'] == 'learner') {
    //   var userFetch = await firestoreService.getUserById(dataScan['uid']);
    //   if (userFetch != null) {
    //     Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //             builder: (context) => ShowInfoLearner(learner: userFetch)));
    //     await this.controller!.pauseCamera();
    //     return;
    //   }
    // }
    
    if (dataScan['type'] == 'class') {
      bool noPushRouter = false;
      var dataFetch = await firestoreService.getClassByIdTutor(dataScan['uid']);
      if (dataFetch != null) {
        if (dataScan['state'] != null) {
          var lessonSchedules = dataFetch['teachClass'].schedules!
              .lessonSchedules as List<LessonSchedules>;
          print("lessonSchedules $lessonSchedules");
          if (lessonSchedules != null) {
            var check = 0 as num;
            List<LessonSchedules> schedules = lessonSchedules.map((data) {
              if (check > 0) {
                return data;
              }
              print(data.startTime);
              // check thoi gian tao qr
              Map<String, dynamic> timestampJson = jsonDecode(
                  dataScan["timeCheck"]);
              Duration timeCheck = getTimeDuration(timestampJson);
              print('timeCheck   ${timeCheck.inHours}');

              // thoi gian tao QR lon hon 30p thi QR vo hieu
              if (timeCheck.inHours > 0.5) {
                noPushRouter = true;
                return data;
              }
              // ket thuc check

              // check thoi gian bat dau

              Map<String, dynamic> timestampStartJson = jsonDecode(
                  dataScan["startTime"]);
              Duration timeStartCheck = getTimeDuration(timestampJson);
              print('timeStartCheck   ${timeStartCheck.inHours}');
              if (timeStartCheck.inHours == 0) {
                if (dataScan['state'] == 'progress') {
                  Timestamp timestamp = Timestamp.fromDate(DateTime.now());
                  data.attendanceTime = timestamp;
                  data.state = 'progress';
                  check = check + 1;
                  return data;
                }
                if (dataScan['state'] == 'done') {
                  Timestamp timestamp = Timestamp.fromDate(DateTime.now());
                  data.attendanceTime = timestamp;
                  data.state = 'done';
                  check = check + 1;
                  return data;
                }
                if (dataScan['state'] == 'not-stydying') {
                  data.attendanceTime = null;
                  data.state = 'not-stydying';
                  check = check + 1;
                  return data;
                }
              }
              // ket thuc check
              return data;
              // if (data[])
            }).toList();
            var newData = Schedules(
                weekSchedules: dataFetch['teachClass'].schedules!
                    .weekSchedules,
                lessonSchedules: schedules
            );
            print('newData $newData');
            await firestoreService.updateStatusClass(
                dataScan['uid'], newData.toJson());
            dataFetch =
            await firestoreService.getClassByIdTutor(dataScan['uid']);
          }
        }
        if (noPushRouter) {
          return;
        }

        print("dataFetch");
        Navigator.push(context,
            MaterialPageRoute(builder: (context) {
              return Provider(
                  create: (context) => dataFetch,
                  builder: (context, child) => ClassInfoLearnerScreen());
            }));
        await this.controller!.pauseCamera();
        return;
      }
    }
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
  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
