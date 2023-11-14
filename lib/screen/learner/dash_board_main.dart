import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datn/auth/firebase_auth_service.dart';
import 'package:datn/screen/learner/update_info.dart';
import 'package:datn/screen/qr_code/qr_screen.dart';
import 'package:datn/screen/face_detection/face_detection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DashBoardMain extends StatefulWidget {
  const DashBoardMain({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DashBoardMainState();
  }
}

class _DashBoardMainState extends State<DashBoardMain> {
  FirebaseAuthService firebaseAuthService = FirebaseAuthService();

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = firebaseAuthService.auth;
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    Stream<DocumentSnapshot> userDocument = firebaseFirestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .snapshots();
    // String? displayName=firebaseFirestore.collection('users').doc('${auth!.currentUser!.uid}').get('display_name');

    print('dash board main rebuild');

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
                            return const UpdateInfoScreen();
                          }),
                        );
                      },
                      child: const CircleAvatar(
                        backgroundImage: AssetImage('assets/bear.jpg'),
                        radius: 50,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Vũ Minh Hiếu',
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                              iconSize: 30,
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              style: ButtonStyle().copyWith(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Theme.of(context)
                                          .colorScheme
                                          .background)),
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                      return const DashBoardQr();
                                    }));
                              },
                              icon: const Icon(Icons.qr_code),
                            ),
                            IconButton(
                              iconSize: 30,
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              style: ButtonStyle().copyWith(
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
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              style: ButtonStyle().copyWith(
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
            child: Container(
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
                                Icons.person_add_alt,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Tìm gia sư',
                            style: TextStyle(fontSize: 16),
                          )
                        ],
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
                                Icons.menu_book,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Khoá học',
                            style: TextStyle(fontSize: 16),
                          )
                        ],
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
            margin: const EdgeInsets.all(10),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
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
                    'Gia sư phù hợp với bạn',
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