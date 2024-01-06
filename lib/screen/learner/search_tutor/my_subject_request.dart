import 'package:datn/database/firestore/firestore_service.dart';
import 'package:datn/model/user/user.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../model/subject_request/subject_request.dart';

class MySubjectRequest extends StatefulWidget {
  const MySubjectRequest({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MySubjectRequestState();
  }
}

String extractTimeString(String timeOfDayString) {
  // Find the opening and closing parentheses
  int startIndex = timeOfDayString.indexOf('(');
  int endIndex = timeOfDayString.indexOf(')');

  // Extract the content between the parentheses
  String content = timeOfDayString.substring(startIndex + 1, endIndex);

  return content;
}

class _MySubjectRequestState extends State<MySubjectRequest> {
  FirestoreService firestoreService = FirestoreService();
  Map<SubjectRequest, User> mapInfo = {};

  @override
  void initState() {
    super.initState();
    updateListRequest();
  }

  void updateListRequest() async {
    mapInfo = await firestoreService.getTutorInfoWithListSubjectRequest();
    setState(() {
      mapInfo = mapInfo;
      print("MAP INFO UPDATE");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Yêu cầu của bạn"),
      ),
      body: SingleChildScrollView(
        child: Card(
          child: Column(
            children: [
              ...mapInfo.entries.map((mapItem) => ElevatedButton(
                    onPressed: () {},
                    child: Column(children: [
                      Card(
                        color: Theme.of(context).colorScheme.primary,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Row(
                            children: [
                              (mapItem.key.subject != null)
                                  ? Expanded(
                                      child: Text(
                                        mapItem.key.subject!,
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .background),
                                      ),
                                    )
                                  : const Text(''),
                              Expanded(
                                child: Row(children: [
                                  OutlinedButton(
                                    onPressed: () {
                                      firestoreService
                                          .removeSubjectRequestLearnerSide(mapItem.key);
                                      setState(() {
                                        mapInfo.remove(mapItem.key);
                                      });
                                    },
                                    child: Text(
                                      "Huỷ",
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                    ),
                                    style: OutlinedButton.styleFrom(backgroundColor:Theme.of(context)
                                        .colorScheme
                                        .background ),
                                  )
                                ]),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.done),
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              // Return the dialog widget
                              return AlertDialog(
                                title: const Text('Lịch Học'),
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Thứ 2',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Center(
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                          const Text("Từ "),
                                          Text(mapItem.key.weekSchedules?.monday
                                                  ?.startTime
                                                  ?.format() ??
                                              ''),
                                          const Text(" Đến "),
                                          Text(mapItem.key.weekSchedules?.monday
                                                  ?.endTime
                                                  ?.format() ??
                                              '')
                                        ])),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      'Thứ 3',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Center(
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                          const Text("Từ "),
                                          Text(mapItem.key.weekSchedules
                                                  ?.tuesday?.startTime
                                                  ?.format() ??
                                              ''),
                                          const Text(" Đến "),
                                          Text(mapItem.key.weekSchedules
                                                  ?.tuesday?.endTime
                                                  ?.format() ??
                                              '')
                                        ])),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      'Thứ 4',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Center(
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                          const Text("Từ "),
                                          Text(mapItem.key.weekSchedules
                                                  ?.wednesday?.startTime
                                                  ?.format() ??
                                              ''),
                                          const Text(" Đến "),
                                          Text(mapItem.key.weekSchedules
                                                  ?.wednesday?.endTime
                                                  ?.format() ??
                                              '')
                                        ])),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      'Thứ 5',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Center(
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                          const Text("Từ "),
                                          Text(mapItem.key.weekSchedules
                                                  ?.thursday?.startTime
                                                  ?.format() ??
                                              ''),
                                          const Text(" Đến "),
                                          Text(mapItem.key.weekSchedules
                                                  ?.thursday?.endTime
                                                  ?.format() ??
                                              '')
                                        ])),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      'Thứ 6',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Center(
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                          const Text("Từ "),
                                          Text(mapItem.key.weekSchedules?.friday
                                                  ?.startTime
                                                  ?.format() ??
                                              ''),
                                          const Text(" Đến "),
                                          Text(mapItem.key.weekSchedules?.friday
                                                  ?.endTime
                                                  ?.format() ??
                                              '')
                                        ])),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      'Thứ 7',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Center(
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                          const Text("Từ "),
                                          Text(mapItem.key.weekSchedules
                                                  ?.saturday?.startTime
                                                  ?.format() ??
                                              ''),
                                          const Text(" Đến "),
                                          Text(mapItem.key.weekSchedules
                                                  ?.saturday?.endTime
                                                  ?.format() ??
                                              '')
                                        ])),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      'Chủ nhật',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Center(
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                          const Text("Từ "),
                                          Text(mapItem.key.weekSchedules?.sunday
                                                  ?.startTime
                                                  ?.format() ??
                                              ''),
                                          const Text(" Đến "),
                                          Text(mapItem.key.weekSchedules?.sunday
                                                  ?.endTime
                                                  ?.format() ??
                                              '')
                                        ])),
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
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: CircleAvatar(
                                        backgroundImage:
                                            (mapItem.value.photoUrl != null)
                                                ? NetworkImage(
                                                    mapItem.value.photoUrl!)
                                                : const AssetImage(
                                                        'assets/bear.jpg')
                                                    as ImageProvider,
                                        radius: 30),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Row(children: [
                                      const Text('Tên : '),
                                      Text(mapItem.value.displayName ?? '')
                                    ]),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(children: [
                                        const Text('Địa chỉ : '),
                                        Text(mapItem.key.address ?? '')
                                      ])),
                                  Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(children: [
                                        const Text('Môn học : '),
                                        Text(mapItem.key.subject ?? '')
                                      ])),
                                  Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(children: [
                                        const Text('Thời gian bắt đầu : '),
                                        Text((mapItem.key.startTime != null)
                                            ? (DateFormat('dd-MM-yyyy').format(
                                                mapItem.key.startTime!
                                                    .toDate()))
                                            : '')
                                      ])),
                                  Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(children: [
                                        const Text('Thời gian kết thúc : '),
                                        Text((mapItem.key.startTime != null)
                                            ? (DateFormat('dd-MM-yyyy').format(
                                                mapItem.key.endTime!.toDate()))
                                            : ''),
                                      ])),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      const Divider()
                    ]),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
