


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/teach_classes/teach_class.dart';
import '../../../model/user/teach_schedules.dart';
import '../../../model/user/user.dart';

class ClassInfoLearnerScreen extends StatefulWidget {
  const ClassInfoLearnerScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ClassInfoScreenState();
  }
}

class _ClassInfoScreenState extends State<ClassInfoLearnerScreen> {
  Map<String, dynamic> tutorInfo = {};
  int lessonOnWeek = 0;

  @override
  void initState() {
    super.initState();
    tutorInfo = Provider.of<Map<String, dynamic>>(context, listen: false);
    WeekSchedules? weekSchedules =
        (tutorInfo['teachClass'] as TeachClass).schedules?.weekSchedules;
    lessonOnWeek = countDayOnWeek(weekSchedules);
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

  @override
  Widget build(BuildContext context) {
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
                  SizedBox(height: 10,),
                  CircleAvatar(
                      backgroundImage: (((tutorInfo['tutorInfo']) as User)
                          .photoUrl !=
                          null)
                          ? NetworkImage(
                          ((tutorInfo['tutorInfo']) as User).photoUrl!)
                          : const AssetImage('assets/bear.jpg')
                      as ImageProvider,
                      radius: 50),
                  const SizedBox(
                    height: 20,
                  ),
                  Card(
                    color: Theme.of(context).colorScheme.primary,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        (((tutorInfo['tutorInfo']) as User).displayName) ??
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
                                'Số điện thoại người học :',
                                style: TextStyle(fontSize: 16),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  (((tutorInfo['tutorInfo']) as User)
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
                                'Lương/tháng :',
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
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
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
