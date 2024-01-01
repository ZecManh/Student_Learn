import 'package:datn/database/firestore/firestore_service.dart';
import 'package:datn/model/today_schedules.dart';
import 'package:datn/screen/face_detection/face_detection.dart';
import 'package:datn/screen/qr_code/qr_code_info_tutor.dart';
import 'package:datn/screen/tutor/requests/subject_request_screen.dart';
import 'package:datn/screen/tutor/update/tutor_info.dart';
import 'package:dynamic_timeline/dynamic_timeline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:datn/model/user/user.dart' as model_user;
import 'package:table_calendar/table_calendar.dart';

import '../../database/auth/firebase_auth_service.dart';
import '../../model/user/teach_schedules.dart';

class DashBoardTutorMain extends StatefulWidget {
  const DashBoardTutorMain({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DashBoardTutorMainState();
  }
}

class _DashBoardTutorMainState extends State<DashBoardTutorMain> {
  FirebaseAuthService firebaseAuthService = FirebaseAuthService();
  late TextEditingController nameController;
  late TextEditingController ageController;
  FirestoreService firestoreService = FirestoreService();
  List<TodaySchedules> daySchedules = [];
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.week;

  @override
  void initState() {
    super.initState();
    initInto();
  }

  void initInto() async {
    var daySchedulesFetch =
    await firestoreService.getSchedulesByDayTutorSide(DateTime.now());
    daySchedulesFetch.sort(
          (a, b) {
        if (a.startTime.isAfter(b.startTime))
          return 1;
        else
          return 0;
      },
    );
    setState(() {
      daySchedules = daySchedulesFetch;
    });
    print("TODAY SCHEDULES");
    daySchedules.forEach((element) {
      print("SCHEDULES " + element.toString());
    });
  }

  void getDaySchedules(DateTime day) async {
    var daySchedulesFetch = await firestoreService.getSchedulesByDayTutorSide(day);
    daySchedulesFetch.sort(
          (a, b) {
        if (a.startTime.isAfter(b.startTime))
          return 1;
        else
          return 0;
      },
    );
    setState(() {
      daySchedules = daySchedulesFetch;
      daySchedules.forEach((element) {
        print("SCHEDULES " + element.toString());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    model_user.User user = Provider.of<model_user.User>(context);
    nameController = TextEditingController(text: user.displayName);
    ageController = TextEditingController(text: user.email);

    FirebaseAuth auth = firebaseAuthService.auth;
    FirestoreService firestoreService = Provider.of<FirestoreService>(context);

    return SingleChildScrollView(
      child: Container(
        color: Theme
            .of(context)
            .colorScheme
            .background,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Theme
                      .of(context)
                      .colorScheme
                      .primaryContainer,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: GestureDetector(
                          onTap: () {
                            print("TUTOR INFO");
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return Provider.value(
                                  value: user,
                                  // child: UpdateInfoTutor()
                                  child: const TutorInfo(),
                                );
                              }),
                            );
                          },
                          child: StreamBuilder<model_user.User>(
                              stream:
                              firestoreService.user(auth.currentUser!.uid),
                              builder: (context,
                                  AsyncSnapshot<model_user.User> snapshot) {
                                // var data=snapshot.data;
                                model_user.User? user = snapshot.data;
                                if (user != null) {
                                  return CircleAvatar(
                                      backgroundImage: (user.photoUrl != null)
                                          ? NetworkImage(user.photoUrl!)
                                          : const AssetImage('assets/bear.jpg')
                                      as ImageProvider,
                                      radius: 50);
                                } else {
                                  return const CircleAvatar(
                                    backgroundImage:
                                    AssetImage('assets/bear.jpg'),
                                    radius: 50,
                                  );
                                }
                              })),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          StreamBuilder<model_user.User?>(
                              stream:
                              firestoreService.user(auth.currentUser!.uid),
                              builder: (context,
                                  AsyncSnapshot<model_user.User?> snapshot) {
                                {
                                  model_user.User? user = snapshot.data;
                                  if (user != null) {
                                    return Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        (snapshot.data!.displayName != null)
                                            ? snapshot.data!.displayName!
                                            : 'Tên bạn là gì?',
                                        style: const TextStyle(fontSize: 24),
                                      ),
                                    );
                                  } else {
                                    return const Text(
                                      'Loading',
                                      style: TextStyle(fontSize: 24),
                                    );
                                  }
                                }
                              }),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                iconSize: 30,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                style: const ButtonStyle().copyWith(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Theme
                                            .of(context)
                                            .colorScheme
                                            .background)),
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                        return Provider.value(
                                          value: user,
                                          child: QrCodeInfoTutor(),
                                        );
                                      }));
                                },
                                icon: const Icon(Icons.qr_code),
                              ),
                              IconButton(
                                iconSize: 30,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                style: const ButtonStyle().copyWith(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Theme
                                            .of(context)
                                            .colorScheme
                                            .background)),
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                        return const DashBoardFaceID();
                                      }));
                                },
                                icon: const Icon(Icons.tag_faces_rounded),
                              ),
                              IconButton(
                                iconSize: 30,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                style: const ButtonStyle().copyWith(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Theme
                                            .of(context)
                                            .colorScheme
                                            .background)),
                                onPressed: () {},
                                icon: const Icon(Icons.notifications),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Card(
              margin: const EdgeInsets.all(10),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Theme
                                  .of(context)
                                  .colorScheme
                                  .primary,
                              shape: BoxShape.rectangle,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(18),
                              child: Icon(
                                Icons.add_outlined,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Tạo lớp',
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return Provider.value(
                                value: user,
                                // child: UpdateInfoTutor()
                                child: const SubjectRequestScreen(),
                              );
                            }),
                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Theme
                                    .of(context)
                                    .colorScheme
                                    .primary,
                                shape: BoxShape.rectangle,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(18),
                                child: Icon(
                                  Icons.mark_email_unread_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'Lời mời',
                              style: TextStyle(fontSize: 16),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Theme
                                  .of(context)
                                  .colorScheme
                                  .primary,
                              shape: BoxShape.rectangle,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(18),
                              child: Icon(
                                Icons.message_outlined,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Hỗ trợ',
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Text(
                      'Lịch dạy',
                      style: TextStyle(fontSize: 20),
                    ),
                  ]),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 500,
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: TableCalendar(
                    focusedDay: DateTime.now(),
                    firstDay: DateTime.utc(2023, 1, 1),
                    lastDay: DateTime.utc(2024, 12, 31),
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      print(selectedDay.toString());
                      print(focusedDay.toString());
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                      getDaySchedules(selectedDay);
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
                  ),
                ),
              ),
            ),
            Card(
              child: Column(
                children: [
                  ...daySchedules
                      .map(
                        (item) =>
                        Row(children: [
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  // Return the dialog widget
                                  return AlertDialog(
                                    title: const Text('Thông tin chi tiết'),
                                    content: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const Text(
                                              "Môn học : ",
                                              style: TextStyle(fontSize: 20),
                                            ),
                                            Expanded(
                                              child: Card(
                                                color: Theme
                                                    .of(context)
                                                    .colorScheme
                                                    .primary,
                                                child: Padding(
                                                  padding: EdgeInsets.all(10),
                                                  child: Text(
                                                    '${item.subject}',
                                                    style: TextStyle(
                                                        color: Theme
                                                            .of(context)
                                                            .colorScheme
                                                            .onPrimary),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              "Địa chỉ : ",
                                              style: TextStyle(fontSize: 20),
                                            ),
                                            Expanded(
                                              child: Card(
                                                color: Theme
                                                    .of(context)
                                                    .colorScheme
                                                    .primary,
                                                child: Padding(
                                                  padding: EdgeInsets.all(10),
                                                  child: Text(
                                                    '${item.address ?? ''}',
                                                    style: TextStyle(
                                                        color: Theme
                                                            .of(context)
                                                            .colorScheme
                                                            .onPrimary),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          // Close the dialog
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Card(
                              color: Theme
                                  .of(context)
                                  .colorScheme
                                  .primary,
                              child: Padding(
                                padding: EdgeInsets.all(20),
                                child: Text(
                                  '${DateFormat.Hm().format(
                                      item.startTime)} - ${DateFormat.Hm()
                                      .format(item.endTime)}',
                                  style: TextStyle(
                                      color: Theme
                                          .of(context)
                                          .colorScheme
                                          .onPrimary),
                                ),
                              ),
                            ),
                          ),
                        ]),
                  )
                      .toList()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
