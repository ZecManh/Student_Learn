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

    // so sanh voi 2 khoang thoi gian khac nhau
    Duration getTimeDuration(DateTime timeData, DateTime timeDataDuration) {
      Duration timeCheck = timeData.difference(timeDataDuration);
      return timeCheck;
    }

    DateTime convertJsonTimeToDateTime(Map<String, dynamic> timestampJson) {
      int seconds = timestampJson['seconds'];
      int nanoseconds = timestampJson['nanoseconds'];
      int microseconds = (seconds * 1000000) + (nanoseconds / 1000).round();
      Timestamp getTimeCheck = Timestamp.fromMicrosecondsSinceEpoch(
          microseconds);
      DateTime timestampCheck = DateTime.fromMillisecondsSinceEpoch(
          getTimeCheck.seconds * 1000);
      return timestampCheck;
    }

    //  so sanh voi thoi gian hien tại
    Duration getTimeDurationNow(Map<String, dynamic> timestampJson) {
      DateTime timestampCheck = convertJsonTimeToDateTime(timestampJson);
      Duration timeCheck = getTimeDuration(timestampCheck,DateTime.now());
      return timeCheck;
    }




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
        bool noPushRouter = false;
        var dataFetch = await firestoreService.getClassByIdTutor(
            dataScan['uid']);
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
                // check thoi gian tao qr
                Map<String, dynamic> timestampJson = jsonDecode(
                    dataScan["timeCheck"]);
                Duration timeCheck = getTimeDurationNow(timestampJson);
                print('timeCheck   ${timeCheck.inHours}');

                // thoi gian tao QR lon hon 30p thi QR vo hieu
                if (timeCheck.inHours > 0.5) {
                  noPushRouter = true;
                  return data;
                }
                // ket thuc check

                // check thoi gian bat dau

                // lay startTime trong qr code de so sanh voi startTime trong data
                Map<String, dynamic> timestampStartJson = jsonDecode(
                    dataScan["startTime"]);
                DateTime DataStartJson = convertJsonTimeToDateTime(timestampStartJson) ;

                print(data.startTime);
                print(timestampStartJson);
                // lay startTime trong data
                Map<String, dynamic> dataStartTimeJson = {
                  'seconds': data.startTime!.seconds,
                  'nanoseconds': data.startTime!.nanoseconds,
                };
                DateTime dataStartTime = convertJsonTimeToDateTime(dataStartTimeJson) ;

                Duration timeStartCheck = getTimeDuration(dataStartTime,DataStartJson);
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
                  if (dataScan['state'] == 'not-studying') {
                    Timestamp timestamp = Timestamp.fromDate(DateTime.now());
                    data.attendanceTime = timestamp;
                    data.state = 'not-studying';
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
