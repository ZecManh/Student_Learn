import 'package:datn/database/firestore/firestore_service.dart';
import 'package:datn/model/teach_classes/teach_class.dart';
import 'package:datn/model/user/user.dart';
import 'package:datn/screen/tutor/teaching/class_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashBoardTutorTeaching extends StatefulWidget {
  const DashBoardTutorTeaching({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DashBoardTutorTeachingState();
  }
}

class _DashBoardTutorTeachingState extends State<DashBoardTutorTeaching> {
  List<Map<String, dynamic>> teachingData = [];
  FirestoreService firestoreService = FirestoreService();

  Future<void> initInfo() async {
    teachingData = await firestoreService.getTeachingInfoTutorSide();
    setState(() {
      teachingData = teachingData;
    });
    // teachingData.forEach((element) {
    //   print(element.toString());
    // });
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
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                      return Provider(
                          create: (context) => teachingDataItem,
                          builder: (context, child) => const ClassInfoScreen());
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
