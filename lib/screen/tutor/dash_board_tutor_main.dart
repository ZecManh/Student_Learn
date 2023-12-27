import 'package:datn/database/firestore/firestore_service.dart';
import 'package:datn/screen/learner/learner_update_info.dart';
import 'package:datn/screen/face_detection/face_detection.dart';
import 'package:datn/screen/qr_code/qr_code_info_tutor.dart';
import 'package:datn/screen/tutor/requests/subject_request_screen.dart';
import 'package:datn/screen/tutor/update/tutor_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:datn/model/user/user.dart' as model_user;
import 'package:qr_flutter/qr_flutter.dart';
import 'package:datn/screen/qr_code/qr_screen_scanner.dart';
import 'package:datn/screen/qr_code/qr_scan_image.dart';

import '../../database/auth/firebase_auth_service.dart';

class DashBoardTutorMain extends StatefulWidget {
  const DashBoardTutorMain({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DashBoardTutorMainState();
  }
}

class _DashBoardTutorMainState extends State<DashBoardTutorMain> {
  FirebaseAuthService firebaseAuthService = FirebaseAuthService();
  late TextEditingController nameController;
  late TextEditingController ageController;

  @override
  void initState() {
    super.initState();
    initInto();
  }

  void initInto() async {

  }
  @override
  Widget build(BuildContext context) {
    model_user.User user = Provider.of<model_user.User>(context);
    nameController = TextEditingController(text: user.displayName);
    ageController = TextEditingController(text: user.email);

    FirebaseAuth auth = firebaseAuthService.auth;
    FirestoreService firestoreService = Provider.of<FirestoreService>(context);
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return Provider.value(
                                value: user,
                                // child: UpdateInfoTutor()
                                child: const TutorInfo(),
                              );
                            }),
                          );
                        },
                        child: StreamBuilder<model_user.User>(
                            stream:
                                firestoreService.user(auth.currentUser!.uid),
                            builder: (context,
                                AsyncSnapshot<model_user.User> snapshot) {
                              // var data=snapshot.data;
                              model_user.User? user = snapshot.data;
                              if (user != null) {
                                return CircleAvatar(
                                    backgroundImage: (user.photoUrl != null)
                                        ? NetworkImage(user.photoUrl!)
                                        : const AssetImage('assets/bear.jpg')
                                            as ImageProvider,
                                    radius: 50);
                              } else {
                                return const CircleAvatar(
                                  backgroundImage:
                                      AssetImage('assets/bear.jpg'),
                                  radius: 50,
                                );
                              }
                            })),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        StreamBuilder<model_user.User?>(
                            stream:
                                firestoreService.user(auth.currentUser!.uid),
                            builder: (context,
                                AsyncSnapshot<model_user.User?> snapshot) {
                              {
                                model_user.User? user = snapshot.data;
                                if (user != null) {
                                  return Text(
                                    (snapshot.data!.displayName != null)
                                        ? snapshot.data!.displayName!
                                        : 'Tên bạn là gì?',
                                    style: const TextStyle(fontSize: 24),
                                  );
                                } else {
                                  return const Text(
                                    'Loading',
                                    style: TextStyle(fontSize: 24),
                                  );
                                }
                              }
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                              iconSize: 30,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              style: const ButtonStyle().copyWith(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Theme.of(context)
                                          .colorScheme
                                          .background)),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return Provider.value(
                                        value: user, child: QrCodeInfoTutor());
                                  }),
                                );
                              },
                              icon: const Icon(Icons.qr_code),
                            ),
                            IconButton(
                              iconSize: 30,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              style: const ButtonStyle().copyWith(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Theme.of(context)
                                          .colorScheme
                                          .background)),
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const DashBoardFaceID();
                                }));
                              },
                              icon: const Icon(Icons.tag_faces_rounded),
                            ),
                            IconButton(
                              iconSize: 30,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              style: const ButtonStyle().copyWith(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Theme.of(context)
                                          .colorScheme
                                          .background)),
                              onPressed: () {},
                              icon: const Icon(Icons.notifications),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Card(
            margin: const EdgeInsets.all(10),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            shape: BoxShape.rectangle,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(18),
                            child: Icon(
                              Icons.add_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Tạo lớp',
                          style: TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return Provider.value(
                              value: user,
                              // child: UpdateInfoTutor()
                              child: const SubjectRequestScreen(),
                            );
                          }),
                        );
                      },
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              shape: BoxShape.rectangle,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(18),
                              child: Icon(
                                Icons.mark_email_unread_outlined,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Lời mời',
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            shape: BoxShape.rectangle,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(18),
                            child: Icon(
                              Icons.message_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Hỗ trợ',
                          style: TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text(
                    'Lớp đang dạy',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    textAlign: TextAlign.end,
                    'Xem tất cả',
                    style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                ]),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
