import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../database/firestore/firestore_service.dart';
import '../../model/teach_classes/teach_class.dart';
import '../../model/user/user.dart';
import 'learning/class_info_learner.dart';

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
    var teachingDataFetch = await firestoreService.getTeachingInfoLearnerSide();
    print("TEACHING INFO LEARNER SIDE");
    teachingDataFetch.forEach((element) {
      print(element.toString());
    });
    setState(() {
      teachingData = teachingDataFetch;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initInfo();

  }
  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Column(
        children: [
          ...teachingData.map((teachingDataItem) {
            return GestureDetector(
              onLongPress: () {},
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Provider(
                      create: (context) => teachingDataItem,
                      builder: (context, child) => ClassInfoLearnerScreen());
                }));
              },
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
                                                      'tutorInfo']) as User)
                                                  .photoUrl !=
                                              null)
                                          ? NetworkImage(
                                              ((teachingDataItem['tutorInfo'])
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
                                        'Gia sư : ' +
                                            (((teachingDataItem['tutorInfo'])
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
