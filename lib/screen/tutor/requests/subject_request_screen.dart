import 'package:datn/database/firestore/firestore_service.dart';
import 'package:datn/model/subject_request/subject_request.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
  List<SubjectRequest> subjectRequests = [];
  List<String> leanerName = [];
  int index = 0;
  Map<SubjectRequest, String> mapInfo = {};

  @override
  void initState() {
    super.initState();
    initInfo();
  }

  void initInfo() async {
    print("getAllSubjectRequestByID");
    var subjectRequestsFetch = await firestoreService.getAllSubjectRequestByID();
    var fetchNames = await firestoreService
        .getLearnerNameByListSubjectRequest(subjectRequestsFetch);
    fetchNames.forEach((element) {
      print(element);
    });
    setState(() {
      subjectRequests = subjectRequestsFetch;
      leanerName = fetchNames;
      mapInfo = Map.fromIterables(subjectRequests, leanerName);
    });
    if (subjectRequests.length > 0) {
      print("LENGTH ${subjectRequests.length}");
      subjectRequests.forEach((element) {
        print(element.toString());
      });
    } else {
      print("SUBJECT REQUEST NIL");
    }
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
                                  : Text(''),
                              Expanded(
                                child: Row(children: [
                                  IconButton(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background,
                                      onPressed: () {

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
                        onTap: (){
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              // Return the dialog widget
                              return AlertDialog(
                                title: Text('Lịch Học'),
                                content: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                  Text('Thứ 2',style: TextStyle(fontSize: 20),),
                                  Text('Thứ 3',style: TextStyle(fontSize: 20),),
                                  Text('Thứ 4',style: TextStyle(fontSize: 20),),
                                  Text('Thứ 5',style: TextStyle(fontSize: 20),),
                                  Text('Thứ 6',style: TextStyle(fontSize: 20),),
                                  Text('Thứ 7',style: TextStyle(fontSize: 20),),
                                  Text('Chủ nhật',style: TextStyle(fontSize: 20),),
                                ],),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      // Close the dialog
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('OK'),
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
                                    padding: EdgeInsets.all(10),
                                    child: Row(children: [
                                      Text('Tên : '),
                                      Text(mapItem.value ?? '')
                                    ]),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Row(children: [
                                        Text('Địa chỉ : '),
                                        Text(mapItem.key.address ?? '')
                                      ])),
                                  Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Row(children: [
                                        Text('Môn học : '),
                                        Text(mapItem.key.subject ?? '')
                                      ])),
                                  Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Row(children: [
                                        Text('Thời gian bắt đầu : '),
                                        Text((mapItem.key.startTime != null)
                                            ? (DateFormat('dd-MM-yyyy').format(
                                                mapItem.key.startTime!.toDate()))
                                            : '')
                                      ])),
                                  Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Row(children: [
                                        Text('Thời gian kết thúc : '),
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
                      Divider()
                    ]),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
