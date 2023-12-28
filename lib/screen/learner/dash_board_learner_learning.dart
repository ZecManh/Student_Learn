import 'package:flutter/material.dart';

import '../../database/firestore/firestore_service.dart';
import '../../model/teach_classes/teach_class.dart';
import '../../model/user/user.dart';

class DashBoardLearnerLearning extends StatefulWidget {
  const DashBoardLearnerLearning({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DashBoardLearnerLearningState();
  }
}

class _DashBoardLearnerLearningState extends State<DashBoardLearnerLearning> {
  List<Map<String, dynamic>> teachingData = [];
  FirestoreService firestoreService = FirestoreService();

  Future<void> initInfo() async {
    teachingData = await firestoreService.getTeachingInfoLearnerSide();
    print("TEACHING INFO LEARNER SIDE");
    teachingData.forEach((element) {print(element.toString());});
    setState(() {
      teachingData = teachingData;
    });

  }

  @override
  Widget build(BuildContext context) {
    initInfo();
    return SingleChildScrollView(
      child: Column(
        children: [
          ...teachingData.map((teachingDataItem) {
            return GestureDetector(
              onLongPress: () {
                //show dialog để remove và edit gì đó
              },
              onTap: () {},
              child: Card(
                color: Theme.of(context).colorScheme.primary,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(children: [
                    Row(
                      children: [
                        Expanded(
                          child: Card(
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                (((teachingDataItem['teachClass'])
                                            as TeachClass)
                                        .subject ??
                                    ''),
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Card(
                            color: Theme.of(context).colorScheme.background,
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                      backgroundImage: (((teachingDataItem[
                                                      'learnerInfo']) as User)
                                                  .photoUrl !=
                                              null)
                                          ? NetworkImage(
                                              ((teachingDataItem['learnerInfo'])
                                                      as User)
                                                  .photoUrl!)
                                          : const AssetImage('assets/bear.jpg')
                                              as ImageProvider,
                                      radius: 30),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                        (((teachingDataItem['learnerInfo'])
                                                    as User)
                                                .displayName ??
                                            ''),
                                        style: TextStyle(
                                          fontSize: 16,
                                        )),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ]),
                ),
              ),
            );
          })
        ],
      ),
    );
  }
}
