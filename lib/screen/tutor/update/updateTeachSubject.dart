import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datn/database/firestore/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:datn/model/user/user.dart' as model_user;

import '../../widget/mini_card.dart';

class UpdateTeachSubject extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UpdateTeachSubjectState();
  }
}

class _UpdateTeachSubjectState extends State<UpdateTeachSubject> {
  late TextEditingController subjectController;
  List<String> subjects = [];

  @override
  void initState() {
    super.initState();
    initInfo();
  }

  initInfo() {
    model_user.User sendUser =
        Provider.of<model_user.User>(context, listen: false);
    subjects = (sendUser.subjects != null) ? sendUser.subjects! : [];
    subjectController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    FirestoreService firestoreService = FirestoreService();
    FirebaseAuth auth = FirebaseAuth.instance;
    return MultiProvider(
      providers: [
        StreamProvider<model_user.User>(
            create: (context) => firestoreService.user(auth.currentUser!.uid),
            initialData: model_user.User())
      ],
      child: Builder(
        builder: (context) {
          model_user.User user = Provider.of<model_user.User>(context);

          return Scaffold(
            appBar: AppBar(
              title: Text('Môn dạy kèm'),
            ),
            body: SingleChildScrollView(
              child: Center(
                  child: Card(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Card(
                        color: Theme.of(context).colorScheme.background,
                        child: (user.teachMethod != null)
                            ? Wrap(
                                children: [
                                  ...subjects.map((item) {
                                    return Padding(
                                      padding: EdgeInsets.all(5),
                                      child: OutlinedButton.icon(
                                        onPressed: () {
                                          if (subjects
                                              .contains(item as String)) {
                                            setState(() {
                                              subjects.removeAt(subjects
                                                  .indexOf(item as String));
                                            });
                                          }
                                        },
                                        icon: Icon(Icons.delete_forever),
                                        label: Text(
                                          item,
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    );
                                  })
                                ],
                              )
                            : Text(
                                'Chưa cập nhật',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Theme.of(context).colorScheme.error),
                              ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Card(
                        color: Theme.of(context).colorScheme.background,
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            Text(
                              'Thêm mới',
                              style: TextStyle(fontSize: 20),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: TextField(
                                controller: subjectController,
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            OutlinedButton.icon(
                                onPressed: () {
                                  if(subjectController.text!=""){
                                    setState(() {
                                      subjects.add(subjectController.text);
                                      subjectController.clear();
                                    });
                                  }
                                },
                                icon: Icon(Icons.add),
                                label: Text('Thêm')),
                            SizedBox(height: 10,)
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      OutlinedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Theme.of(context).colorScheme.primary),
                            foregroundColor: MaterialStateProperty.all(
                                Theme.of(context).colorScheme.background)),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Xác nhận'),
                                  content: Text(
                                      'Bạn chắc chắn với sự thay đổi này?'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'Cancel'),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        firestoreService.updateSubject(auth.currentUser!.uid,subjects);
                                        Navigator.pop(context, 'OK');
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                );
                              });
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Text(
                            'Cập nhật',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              )),
            ),
          );
        },
      ),
    );
  }
}
