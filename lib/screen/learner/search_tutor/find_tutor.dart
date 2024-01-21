import 'package:datn/screen/learner/search_tutor/tutor_show_info.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:datn/database/firestore/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:datn/model/user/user.dart' as model_user;

class FindTuTor extends StatefulWidget {
  const FindTuTor({super.key});

  @override
  State<StatefulWidget> createState() {
    return _FindTutorState();
  }
}

class _FindTutorState extends State<FindTuTor> {
  List<model_user.User> users = [];
  List<model_user.User> userShow = [];
  FirebaseAuth auth = FirebaseAuth.instance;
  FirestoreService firestoreService = FirestoreService();
  TextEditingController nameController = TextEditingController();
  TextEditingController subjectController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initInfo();
  }

  void initInfo() async {
    var usersFetch = await firestoreService.getTutors();
    setState(() {
      users = usersFetch.toList();
      userShow = usersFetch.toList();
    });
  }

  searchTutor() {


    String searchName =
        nameController.text; // Replace with the name you want to search for
    String searchSubject = subjectController
        .text; // Replace with the subject you want to search for
    print("SEARCH FOR $searchName $searchSubject");
    // Use regex to find a user with the specified name and subject
    RegExp nameRegex = RegExp("$searchName", caseSensitive: false);
    RegExp subjectRegex = RegExp("$searchSubject", caseSensitive: false);


    List<model_user.User> result = [];

    if(searchName==''&&searchSubject==''){
      print("khong nhap gi");
    }
    if(searchName!=''&&searchSubject==''){
      print("Nhap moi ten");
      for (model_user.User user in users) {
        print("Lap ten ${user.displayName!}");
        if (nameRegex.hasMatch(user.displayName!)) {
              result.add(user);
        }
      }
    }

    if(searchName==''&&searchSubject!=''){
      print("nhap moi mon hoc");
      for (model_user.User user in users) {
        List<String> listSubjects = user.subjects!;
        for (String subject in listSubjects) {
          if (subjectRegex.hasMatch(subject)) {
            print("TRUNG KHOP ${user.displayName} ${subject}");
            result.add(user);
            break;
          }
        }
      }
    }

    if(searchName!=''&&searchSubject!=''){
      //nhap ca hai
      for (model_user.User user in users) {
        print("Lap ten ${user.displayName!}");
        if (nameRegex.hasMatch(user.displayName!)) {
          print("SEARCH INFO ${user.displayName!}");
          List<String> listSubjects = user.subjects!;

          for (String subject in listSubjects) {
            if (subjectRegex.hasMatch(subject)) {
              print("TRUNG KHOP ${user.displayName} ${subject}");
              result.add(user);
              break;
            }
          }
        } else {
          print("khong khop");
        }
      }
    }

    setState(() {
      userShow = result.toList();
    });
  }

  void resetResult() {
    setState(() {
      print("USER SET STATE");
      users.forEach((element) {
        print(" user " + element.toString());
      });
      nameController.text = '';
      subjectController.text = '';
      userShow = users;
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
        appBar: AppBar(
          title: Text("Danh sách gia sư"),
        ),
        body: Builder(
          builder: (BuildContext context) {
            model_user.User user = Provider.of<model_user.User>(context);
            userShow.forEach((element) {});
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    color: Theme.of(context).colorScheme.background,
                    child: Column(
                      children: [
                        Card(
                            child: Padding(
                                padding: EdgeInsets.all(20),
                                child: Text("Tìm kiếm nâng cao"))),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Tên',
                                style: TextStyle(fontSize: 20),
                              )),
                        ),
                        Card(
                          child: TextFormField(
                            controller: nameController,
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Môn học',
                                style: TextStyle(fontSize: 20),
                              )),
                        ),
                        Card(
                          child: TextFormField(
                            controller: subjectController,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(children: [
                            Expanded(
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    backgroundColor:
                                        Theme.of(context).colorScheme.primary),
                                onPressed: () {
                                  searchTutor();
                                },
                                child: Text(
                                  'Tìm kiếm',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background),
                                ),
                              ),
                            ),
                            Expanded(
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    backgroundColor:
                                        Theme.of(context).colorScheme.primary),
                                onPressed: () {
                                  resetResult();
                                },
                                child: Text(
                                  'Làm mới',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background),
                                ),
                              ),
                            ),
                          ]),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  ...userShow.map((itemUser) {
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
