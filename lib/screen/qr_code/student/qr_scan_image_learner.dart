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
import 'package:datn/screen/learner/learning/class_info_learner.dart';
import 'package:datn/model/user/teach_schedules.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datn/model/subject_request/schedules.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
        var userFetch = await firestoreService.getUserById(dataScan['uid']);
        if (userFetch != null) {
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
      // if (dataScan['type'] == 'learner') {
      //   var userFetch = await firestoreService.getUserById(dataScan['uid']);
      //   if (userFetch != null) {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) {
      //         return Provider.value(
      //             value: user,
      //             child: ShowInfoLearner(learner: userFetch));
      //       }),
      //     );
      //     return;
      //   }
      // }
      if (dataScan['type'] == 'class') {
        var dataFetch = await firestoreService.getClassByIdTutor(dataScan['uid']);
        if (dataFetch != null) {
          if (dataScan['state'] != null) {
            var lessonSchedules = dataFetch['teachClass'].schedules!.lessonSchedules as List<LessonSchedules>;
            print("lessonSchedules $lessonSchedules");
            if (lessonSchedules != null) {
              var check = 0 as num;
              List<LessonSchedules> schedules = lessonSchedules.map((data) {
                if (check > 0) {
                  return data;
                }
                print(data.startTime);
                Map<String, dynamic> timestampJson = jsonDecode(dataScan["timeCheck"]);
                int seconds = timestampJson['seconds'];
                int nanoseconds = timestampJson['nanoseconds'];
                int microseconds = (seconds * 1000000) + (nanoseconds / 1000).round();
                Timestamp getTimeCheck = Timestamp.fromMicrosecondsSinceEpoch(microseconds);

                DateTime timestampCheck = DateTime.fromMillisecondsSinceEpoch(getTimeCheck.seconds * 1000);
                DateTime timestamp = DateTime.fromMillisecondsSinceEpoch(data.startTime!.seconds * 1000);
                DateTime timestamp2 = DateTime.fromMillisecondsSinceEpoch(data.endTime!.seconds * 1000);
                var difference2 = timestamp.difference(DateTime.now());
                var differenceEnd = timestamp2.difference(DateTime.now());
                Duration timeCheck = timestampCheck.difference(DateTime.now());
                Duration difference = difference2;
                Duration differenceEndTime = differenceEnd;
                if (timeCheck.inHours > 0.5) {
                  return data;
                }
                print('difference   ${difference.inHours}');
                print('differenceEndTime   ${differenceEndTime.inHours}');
                if(difference.inHours > 0.5 && difference.inHours < 1 && dataScan['state'] == 'progress') {
                  Timestamp timestamp = Timestamp.fromDate(DateTime.now());
                  data.attendanceTime = timestamp;
                  data.state = 'progress';
                  check = check + 1;
                  return data;
                }
                if(differenceEndTime.inHours > 0 && dataScan['state'] == 'done') {
                  Timestamp timestamp = Timestamp.fromDate(DateTime.now());
                  data.attendanceTime = timestamp;
                  data.state = 'done';
                  check = check + 1;
                  return data;
                }
                if(dataScan['state'] == 'not-stydying') {
                  data.attendanceTime = null;
                  data.state = 'not-stydying';
                  check = check + 1;
                  return data;
                }
                return data;
                // if (data[])
              }).toList();
              var newData = Schedules(
                  weekSchedules: dataFetch['teachClass'].schedules!.weekSchedules,
                  lessonSchedules : schedules
              );
              print('newData $newData');
              await firestoreService.updateStatusClass(dataScan['uid'],newData.toJson());
              dataFetch = await firestoreService.getClassByIdTutor(dataScan['uid']);

            }
          }
          print("dataFetch $dataFetch");
          Navigator.push(context,
              MaterialPageRoute(builder: (context) {
                return Provider(
                    create: (context) => dataFetch,
                    builder: (context, child) => ClassInfoLearnerScreen());
              }));
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
            ],
          ),
          // Text('${qrcode}'),
        ],
      ),
    );
  }
}
