import 'package:datn/screen/learner/search_tutor/tutor_show_info.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:datn/database/firestore/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:datn/model/user/user.dart' as model_user;

class MySubjectRequest extends StatefulWidget {
  const MySubjectRequest({super.key});

  @override
  State<StatefulWidget> createState() {
    return _FindTutorState();
  }
}

class _FindTutorState extends State<MySubjectRequest> {
  List<model_user.User> users = [];
  FirebaseAuth auth = FirebaseAuth.instance;
  FirestoreService firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();

    initInfo();
  }

  void initInfo() async {
    var usersFetch = await firestoreService.getTutors();
    setState(() {
      users = usersFetch;
    });
    users.forEach((element) {
      print("userrrrrr " + element.toString());
    });
  }

  @override
  Widget build(BuildContext context) {


    FirestoreService firestoreService = Provider.of<FirestoreService>(context);

    firestoreService.getTutors();
    return MultiProvider(
      providers: [
        StreamProvider<model_user.User?>(
            create: (context) => firestoreService.user(auth.currentUser!.uid),
            initialData: model_user.User())
      ],
      child: Scaffold(
        appBar: AppBar(title: Text("Yêu cầu của bạn"),),
        body: Builder(
          builder: (BuildContext context) {
            model_user.User user = Provider.of<model_user.User>(context);
            users.forEach((element) {});
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ...users.map((itemUser) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    TuTorShowInfo(tutor: itemUser)));
                      },
                      child: Card(
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: CircleAvatar(
                                  backgroundImage: (itemUser.photoUrl != null)
                                      ? NetworkImage(itemUser.photoUrl!)
                                      : const AssetImage('assets/bear.jpg')
                                  as ImageProvider,
                                  radius: 40),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              children: [
                                Text(itemUser.displayName ?? 'Gia sư'),
                                Text(itemUser.education?.university ?? ''),
                                Text(itemUser.education?.major ?? '')
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
