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
  FirebaseAuthService firebaseAuthService=FirebaseAuthService();
  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth=firebaseAuthService.auth;
    String? displayName=auth.currentUser!.displayName;
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
              child: Row(children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const UpdateInfoScreen();
                      }));

                    },
                    child: const CircleAvatar(
                      backgroundImage: AssetImage('assets/bear.jpg'),
                      radius: 50,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                 Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      displayName ?? 'Tên bạn là gì',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text('Người học', style: TextStyle(fontSize: 18)),
                  ],
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const DashBoardQr();
                            }));
                          },
                          icon: const Icon(Icons.qr_code),
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                          onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return const DashBoardFaceID();
                              }));
                          },
                          icon: const Icon(Icons.tag_faces_rounded),
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.notifications),
                        ),
                      ),
                    ],
                  ),
                )
              ]),
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
