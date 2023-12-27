import 'package:datn/database/firestore/firestore_service.dart';
import 'package:datn/model/subject_request/subject_request.dart';
import 'package:datn/model/user/user.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SubjectRequestScreen extends StatefulWidget {
  const SubjectRequestScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SubjectRequestScreenState();
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

class _SubjectRequestScreenState extends State<SubjectRequestScreen> {
  FirestoreService firestoreService = FirestoreService();
  Map<SubjectRequest, User> mapInfo = {};

  @override
  void initState() {
    super.initState();
    initInfo();
  }

  void initInfo() async {
    mapInfo = await firestoreService.getLearnerInfoWithListSubjectRequest();
    setState(() {
      mapInfo = mapInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lời mời dạy"),
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
                                  IconButton(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background,
                                      onPressed: () {
                                        // firestoreService.addClass(mapItem.key);
                                      },
                                      icon: const Icon(Icons.done)),
                                  IconButton(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background,
                                      onPressed: () {},
                                      icon: const Icon(
                                          Icons.remove_circle_outline)),
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
                                          Text(mapItem
                                                  .key
                                                  .schedules
                                                  ?.weekSchedules
                                                  ?.monday
                                                  ?.startTime ??
                                              ''),
                                          const Text(" Đến "),
                                          Text(mapItem
                                                  .key
                                                  .schedules
                                                  ?.weekSchedules
                                                  ?.monday
                                                  ?.endTime ??
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
                                          Text(mapItem
                                                  .key
                                                  .schedules
                                                  ?.weekSchedules
                                                  ?.tuesday
                                                  ?.startTime ??
                                              ''),
                                          const Text(" Đến "),
                                          Text(mapItem
                                                  .key
                                                  .schedules
                                                  ?.weekSchedules
                                                  ?.tuesday
                                                  ?.endTime ??
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
                                          Text(mapItem
                                                  .key
                                                  .schedules
                                                  ?.weekSchedules
                                                  ?.wednesday
                                                  ?.startTime ??
                                              ''),
                                          const Text(" Đến "),
                                          Text(mapItem
                                                  .key
                                                  .schedules
                                                  ?.weekSchedules
                                                  ?.wednesday
                                                  ?.endTime ??
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
                                          Text(mapItem
                                                  .key
                                                  .schedules
                                                  ?.weekSchedules
                                                  ?.thursday
                                                  ?.startTime ??
                                              ''),
                                          const Text(" Đến "),
                                          Text(mapItem
                                                  .key
                                                  .schedules
                                                  ?.weekSchedules
                                                  ?.thursday
                                                  ?.endTime ??
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
                                          Text(mapItem
                                                  .key
                                                  .schedules
                                                  ?.weekSchedules
                                                  ?.friday
                                                  ?.startTime ??
                                              ''),
                                          const Text(" Đến "),
                                          Text(mapItem
                                                  .key
                                                  .schedules
                                                  ?.weekSchedules
                                                  ?.friday
                                                  ?.endTime ??
                                              '')
                                        ])),
                                    const SizedBox(height: 10,),
                                    const Text(
                                      'Thứ 7',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    const SizedBox(height: 10,),
                                    Center(
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                          const Text("Từ "),
                                          Text(mapItem
                                                  .key
                                                  .schedules
                                                  ?.weekSchedules
                                                  ?.saturday
                                                  ?.startTime ??
                                              ''),
                                          const Text(" Đến "),
                                          Text(mapItem
                                                  .key
                                                  .schedules
                                                  ?.weekSchedules
                                                  ?.saturday
                                                  ?.endTime ??
                                              '')
                                        ])),
                                    const SizedBox(height: 10,),
                                    const Text(
                                      'Chủ nhật',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    const SizedBox(height: 10,),
                                    Center(
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                          const Text("Từ "),
                                          Text(mapItem
                                                  .key
                                                  .schedules
                                                  ?.weekSchedules
                                                  ?.sunday
                                                  ?.startTime ??
                                              ''),
                                          const Text(" Đến "),
                                          Text(mapItem
                                                  .key
                                                  .schedules
                                                  ?.weekSchedules
                                                  ?.sunday
                                                  ?.endTime ??
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
