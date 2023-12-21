import 'package:datn/database/firestore/firestore_service.dart';
import 'package:datn/screen/tutor/update/updateTeachSubject.dart';
import 'package:datn/screen/tutor/update/update_address.dart';
import 'package:datn/screen/tutor/update/update_education.dart';
import 'package:datn/screen/tutor/update/update_experience.dart';
import 'package:datn/screen/tutor/update/update_profile.dart';
import 'package:datn/screen/tutor/update/update_teach_address.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:datn/model/user/user.dart' as model_user;

class UpdateInfoTutor extends StatefulWidget {
  const UpdateInfoTutor({super.key});

  @override
  State<StatefulWidget> createState() {
    return _UpdateInfoTutorState();
  }
}

class _UpdateInfoTutorState extends State<UpdateInfoTutor> {
  @override
  Widget build(BuildContext context) {
    FirestoreService service = Provider.of<FirestoreService>(context);
    FirebaseAuth auth = FirebaseAuth.instance;
    return MultiProvider(
      providers: [
        StreamProvider<model_user.User?>(
            create: (context) => service.user(auth.currentUser!.uid),
            initialData: model_user.User())
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Hồ sơ gia sư'),
        ),
        body: Builder(
          builder: (BuildContext context) {
            model_user.User user = Provider.of<model_user.User>(context);
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return Provider(
                                create: (context) => user,
                                builder: (context, child) => const UpdateProfile());
                          }));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Card(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          child: Row(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                        return Provider(
                                            create: (context) => user,
                                            builder: (context, child) => const UpdateProfile());
                                      }));
                                },
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                        const CircleBorder()),
                                    backgroundColor: MaterialStateProperty.all(
                                        Theme.of(context)
                                            .colorScheme
                                            .background)),
                                child: Icon(Icons.person_2_rounded,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground),
                              ),
                              Expanded(
                                child: Text(
                                  'Thông tin cá nhân',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimaryContainer,
                                      fontSize: 20),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Provider(
                            create: (context) => user,
                            builder: (context, child) => const UpdateAddress());
                      }));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Card(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          child: Row(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                        return Provider(
                                            create: (context) => user,
                                            builder: (context, child) => const UpdateAddress());
                                      }));
                                },
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                        const CircleBorder()),
                                    backgroundColor: MaterialStateProperty.all(
                                        Theme.of(context)
                                            .colorScheme
                                            .background)),
                                child: Icon(Icons.home,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground),
                              ),
                              Expanded(
                                child: Text(
                                  'Thông tin địa chỉ',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimaryContainer,
                                      fontSize: 20),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return Provider(
                                create: (context) => user,
                                builder: (context, child) => const UpdateEducation());
                          }));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Card(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          child: Row(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                        return Provider(
                                            create: (context) => user,
                                            builder: (context, child) => const UpdateEducation());
                                      }));
                                },
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                        const CircleBorder()),
                                    backgroundColor: MaterialStateProperty.all(
                                        Theme.of(context)
                                            .colorScheme
                                            .background)),
                                child: Icon(Icons.school,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground),
                              ),
                              Expanded(
                                child: Text(
                                  'Trình độ học vấn',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimaryContainer,
                                      fontSize: 20),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return Provider(
                                create: (context) => user,
                                builder: (context, child) => UpdateTeachSubject());
                          }));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Card(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          child: Row(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                        return Provider(
                                            create: (context) => user,
                                            builder: (context, child) => UpdateTeachSubject());
                                      }));
                                },
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                        const CircleBorder()),
                                    backgroundColor: MaterialStateProperty.all(
                                        Theme.of(context)
                                            .colorScheme
                                            .background)),
                                child: Icon(Icons.subject,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground),
                              ),
                              Expanded(
                                child: Text(
                                  'Môn dạy kèm',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimaryContainer,
                                      fontSize: 20),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return Provider(
                                create: (context) => user,
                                builder: (context, child) => const UpdateExperience());
                          }));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Card(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          child: Row(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                        return Provider(
                                            create: (context) => user,
                                            builder: (context, child) => const UpdateExperience());
                                      }));
                                },
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                        const CircleBorder()),
                                    backgroundColor: MaterialStateProperty.all(
                                        Theme.of(context)
                                            .colorScheme
                                            .background)),
                                child: Icon(Icons.info,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground),
                              ),
                              Expanded(
                                child: Text(
                                  'Giới thiệu bản thân,kinh nghiệm',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimaryContainer,
                                      fontSize: 20),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return Provider(
                                create: (context) => user,
                                builder: (context, child) => const UpdateTeachAddress());
                          }));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Card(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          child: Row(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                        return Provider(
                                            create: (context) => user,
                                            builder: (context, child) => const UpdateTeachAddress());
                                      }));
                                },
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                        const CircleBorder()),
                                    backgroundColor: MaterialStateProperty.all(
                                        Theme.of(context)
                                            .colorScheme
                                            .background)),
                                child: Icon(Icons.info,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground),
                              ),
                              Expanded(
                                child: Text(
                                  'Khu vực dạy kèm',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimaryContainer,
                                      fontSize: 20),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Card(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          child: Row(
                            children: [
                              ElevatedButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                        const CircleBorder()),
                                    backgroundColor: MaterialStateProperty.all(
                                        Theme.of(context)
                                            .colorScheme
                                            .background)),
                                child: Icon(Icons.upload_file_sharp,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground),
                              ),
                              Expanded(
                                child: Text(
                                  'Tải lên chứng nhận',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimaryContainer,
                                      fontSize: 20),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
