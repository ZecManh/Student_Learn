import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../model/teach_classes/teach_class.dart';
import '../../../model/user/teach_schedules.dart';
import 'package:datn/model/user/user.dart' as model_user;
import 'package:datn/screen/qr_code/components/qr_code_view.dart';
import 'package:datn/database/firestore/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ClassInfoLearnerScreen extends StatefulWidget {
  const ClassInfoLearnerScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ClassInfoScreenState();
  }
}

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

class _ClassInfoScreenState extends State<ClassInfoLearnerScreen> {
  Map<String, dynamic> tutorInfo = {};
  int lessonOnWeek = 0;
  List<LessonSchedules> lessonSchedules = [];
  late DateTime startDate;
  late DateTime endDate;
  DateTime? _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.week;
  Map<DateTime, List> _eventsList = {};
  Map<DateTime, Object> _eventsListState = {};
  FirebaseAuth auth = FirebaseAuth.instance;
  FirestoreService firestoreService = FirestoreService();

  @override
  String getTimeHour(Timestamp? attendanceTime) {
    if (attendanceTime == null) {
      return '';
    }
    DateTime dateTimeFromTimestamp = attendanceTime.toDate();

    String formattedTime = DateFormat.Hm().format(dateTimeFromTimestamp);
    print("formattedTime   $formattedTime");
    return formattedTime;
  }

  void initState() {
    super.initState();
    tutorInfo = Provider.of<Map<String, dynamic>>(context, listen: false);
    WeekSchedules? weekSchedules =
        (tutorInfo['teachClass'] as TeachClass).schedules?.weekSchedules;
    lessonOnWeek = countDayOnWeek(weekSchedules);
    if ((tutorInfo['teachClass'] as TeachClass).schedules != null) {
      lessonSchedules =
          (tutorInfo['teachClass'] as TeachClass).schedules!.lessonSchedules!;
    }
    startDate = DateTime.fromMillisecondsSinceEpoch(
        lessonSchedules[0].startTime!.millisecondsSinceEpoch);
    endDate = DateTime.fromMillisecondsSinceEpoch(
        lessonSchedules[lessonSchedules.length - 1]
            .startTime!
            .millisecondsSinceEpoch);
    _focusedDay = startDate;
    _selectedDay = startDate;
    print("START TIME ${startDate.toString()}");
    print("END TIME ${endDate.toString()}");
    lessonSchedules.forEach((itemLesson) {
      _eventsList.addAll({
        DateTime.fromMillisecondsSinceEpoch(
            itemLesson.startTime!.millisecondsSinceEpoch): [
          'Thời gian điểm danh :  ${itemLesson.attendanceTime != null ? getTimeHour(itemLesson.attendanceTime) : ''}'
        ],
      });
      _eventsListState.addAll({
        DateTime.fromMillisecondsSinceEpoch(
            itemLesson.startTime!.millisecondsSinceEpoch): itemLesson,
      });
    });
  }

  int countDayOnWeek(WeekSchedules? weekSchedules) {
    int count = 0;
    if (weekSchedules != null) {
      if (weekSchedules.monday != null) {
        count++;
      }
      if (weekSchedules.tuesday != null) {
        count++;
      }
      if (weekSchedules.wednesday != null) {
        count++;
      }
      if (weekSchedules.thursday != null) {
        count++;
      }
      if (weekSchedules.friday != null) {
        count++;
      }
      if (weekSchedules.saturday != null) {
        count++;
      }
      if (weekSchedules.sunday != null) {
        count++;
      }
    }
    return count;
  }

  void _openModalQrUser(BuildContext context, dynamic user) {
    var info = {"uid": user.uid, "type": 'tutor'};
    String jsonInfo = user.uid != null ? jsonEncode(info) : "";
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            width: double.infinity,
            height: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: QRCodeView(text: jsonInfo),
                  ),
                ),
              ],
            ),
          ),
        );
        // Container(
        // child: ),);
      },
    );
  }

  void _openModalQrClass(BuildContext context, dynamic classInfo) {
    print('classInfo');
    print(classInfo);
    print(classInfo["docId"]);
    // return;
    var info = {"uid": classInfo["docId"], "type": 'class'};

    String jsonInfo = classInfo["docId"] != null ? jsonEncode(info) : "";
    print('jsonInfo');
    print(jsonInfo);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            width: double.infinity,
            height: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: QRCodeView(text: jsonInfo),
                  ),
                ),
              ],
            ),
          ),
        );
        // Container(
        // child: ),);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final _events = LinkedHashMap<DateTime, List>(
      equals: isSameDay,
      hashCode: getHashCode,
    )..addAll(_eventsList);
    final _eventsState = LinkedHashMap<DateTime, Object>(
      equals: isSameDay,
      hashCode: getHashCode,
    )..addAll(_eventsListState);
    List getEventForDay(DateTime day) {
      return _events[day] ?? [];
    }

    Object getEventStateForDay(DateTime day) {
      return _eventsState[day] ?? {};
    }

    firestoreService.listenChangeInfoClass(tutorInfo['docId'],(dynamic value){
      print("value :   $value");
    });

    dynamic _renderAction(BuildContext context,dynamic classInfo) {
      print(lessonSchedules);
      print("classInfo : $classInfo");
      print("getEventStateForDay(_selectedDay!) : ${getEventStateForDay(_selectedDay!)}");
      var objState = getEventStateForDay(_selectedDay!) as dynamic;

      print("objState.state == 'progress' ${objState.state}");
      var obj = {};
      DateTime currentDateTime = DateTime.now();
      Timestamp timestamp = Timestamp.fromDate(currentDateTime);

      Map<String, dynamic> timestampJson = {
        'seconds': timestamp.seconds,
        'nanoseconds': timestamp.nanoseconds,
      };

      String timestampJsonString = jsonEncode(timestampJson);

      print(timestampJsonString);
      var info = {"uid": classInfo["docId"], "type": 'class'};
      info["timeCheck"] = timestampJsonString ;
      obj['text'] = 'Bắt đầu học';
      info['state'] = 'progress';
      print(info);
      // String jsonInfo = classInfo["docId"] != null ? jsonEncode(info) : "";
      obj['action'] = () => {
        // _openModalActionQrClass(context,jsonInfo)
      };
      if (objState.state == 'progress') {
        obj['text'] = 'Đang học';
        info['state'] = 'done';
        // String jsonInfo = classInfo["docId"] != null ? jsonEncode(info) : "";
        obj['action'] = () => {
          // _openModalActionQrClass(context,jsonInfo)
        };
      }
      if (objState.state == 'done') {
        obj['text'] = 'Đã học xong';
        obj['action'] = () => {};
      }
      if (objState.state == 'not-stydying') {
        obj['text'] = 'Nghỉ học';
        info['state'] = 'not-stydying';
        // String jsonInfo = classInfo["docId"] != null ? jsonEncode(info) : "";
        obj['action'] = () => {
          // _openModalActionQrClass(context,jsonInfo)
        };
      }
      print("obj === $obj");
      return obj;
    };

    return Scaffold(
      appBar: AppBar(title: const Text("Thông tin lớp học")),
      body: SingleChildScrollView(
        child: Center(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const Row(
                    children: [
                      Text(
                        'Gia sư của bạn',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CircleAvatar(
                      backgroundImage:
                          (((tutorInfo['tutorInfo']) as model_user.User)
                                      .photoUrl !=
                                  null)
                              ? NetworkImage(
                                  ((tutorInfo['tutorInfo']) as model_user.User)
                                      .photoUrl!)
                              : const AssetImage('assets/bear.jpg')
                                  as ImageProvider,
                      radius: 50),
                  const SizedBox(
                    height: 20,
                  ),
                  IconButton(
                    iconSize: 30,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    style: const ButtonStyle().copyWith(
                        backgroundColor: MaterialStatePropertyAll(
                            Theme.of(context).colorScheme.background)),
                    onPressed: () {
                      _openModalQrUser(context, (tutorInfo['tutorInfo']));
                    },
                    icon: const Icon(Icons.qr_code),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Card(
                    color: Theme.of(context).colorScheme.primary,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        (((tutorInfo['tutorInfo']) as model_user.User)
                                .displayName) ??
                            '',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).colorScheme.onPrimary),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Card(
                    color: Theme.of(context).colorScheme.background,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Môn :',
                                style: TextStyle(fontSize: 16),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  (((tutorInfo['teachClass']) as TeachClass)
                                          .subject) ??
                                      '',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              const Text(
                                'Hình thức dạy :',
                                style: TextStyle(fontSize: 16),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  (((tutorInfo['teachClass']) as TeachClass)
                                          .teachMethod) ??
                                      '',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              const Text(
                                'Số điện thoại người dạy :',
                                style: TextStyle(fontSize: 16),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  (((tutorInfo['tutorInfo']) as model_user.User)
                                          .phone) ??
                                      '',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              const Text(
                                'Số buổi học :',
                                style: TextStyle(fontSize: 16),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  (lessonOnWeek.toString() + " buổi/tuần"),
                                  style: TextStyle(fontSize: 16),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Row(
                            children: [
                              Text(
                                'Học phí/giờ :',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  '',
                                  style: TextStyle(fontSize: 16),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              OutlinedButton.icon(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.edit_document,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                                label: Text(
                                  'Xem kết quả',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary),
                                ),
                                style: OutlinedButton.styleFrom(
                                    backgroundColor:
                                        Theme.of(context).colorScheme.primary),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              OutlinedButton.icon(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.calendar_month,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                                label: Text(
                                  'Lịch học',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary),
                                ),
                                style: OutlinedButton.styleFrom(
                                    backgroundColor:
                                        Theme.of(context).colorScheme.primary),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              OutlinedButton.icon(
                                icon: Icon(
                                  Icons.qr_code,
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                ),
                                label: Text(
                                  'Thông tin lớp học',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary),
                                ),
                                style: OutlinedButton.styleFrom(
                                    backgroundColor:
                                        Theme.of(context).colorScheme.primary),
                                onPressed: () {
                                  _openModalQrClass(context, tutorInfo);
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              OutlinedButton.icon(
                                icon: Icon(
                                  Icons.qr_code,
                                  color:
                                  Theme.of(context).colorScheme.onSecondary,
                                ),
                                label: Text(
                                  _renderAction(context,tutorInfo)['text'] ?? '',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary),
                                ),
                                style: OutlinedButton.styleFrom(
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                                onPressed: () {
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                  TableCalendar(
                    focusedDay: _focusedDay,
                    firstDay: startDate,
                    lastDay: endDate,
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },
                    calendarFormat: _calendarFormat,
                    onFormatChanged: (format) {
                      if (_calendarFormat != format) {
                        // Call `setState()` when updating calendar format
                        setState(() {
                          _calendarFormat = format;
                        });
                      }
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      print(selectedDay.toString());
                      print(focusedDay.toString());
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                      // getDaySchedules(selectedDay);
                    },
                    eventLoader: (day) {
                      return getEventForDay(day);
                    },
                  ),
                  ListView(
                    shrinkWrap: true,
                    children: getEventForDay(_selectedDay!)
                        .map((event) => ListTile(
                              title: Text(event.toString()),
                            ))
                        .toList(),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
