import 'package:datn/database/firestore/firestore_service.dart';
import 'package:datn/model/user/user.dart' as model_user;
import 'package:datn/screen/tutor/update/tutor_update_info.dart';
import 'package:datn/screen/widget/mini_card.dart';
import 'package:dynamic_timeline/dynamic_timeline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../database/storage/firebase_storage.dart';

class TutorInfo extends StatefulWidget {
  const TutorInfo({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TutorInfoState();
  }
}

class _TutorInfoState extends State<TutorInfo> with TickerProviderStateMixin {
  late final TabController _tabController;
  FirestoreService firestoreService = FirestoreService();
  FirebaseStorageService firebaseStorageService = FirebaseStorageService();
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  void initUserInfo() {}

  @override
  Widget build(BuildContext context) {
    model_user.User user = Provider.of<model_user.User>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tổng quan'),
        actions: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return const UpdateInfoTutor();
                    }));
                  },
                  icon: const Icon(Icons.edit)))
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Icon(Icons.person_3_outlined)),
            Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Icon(Icons.calendar_month_outlined)),
            Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Icon(Icons.rate_review_outlined),
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                          style: BorderStyle.solid,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: firebaseStorageService.uploadImage,
                                  child: StreamBuilder<model_user.User>(
                                      stream: firestoreService.user(FirebaseAuth.instance.currentUser!.uid),
                                      builder:
                                          (context, AsyncSnapshot<model_user.User> snapshot) {
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
                                            backgroundImage: AssetImage('assets/bear.jpg'),
                                            radius: 50,
                                          );
                                        }
                                      }),
                                ),
                              ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20, left: 20),
                          child: Center(
                            child: (user.displayName != null)
                                ? Text(
                                    user.displayName!,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 24),
                                  )
                                : Text('Chưa cập nhật',
                                    style: TextStyle(
                                        fontSize: 24,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .error)),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Card(
                          shape: const OutlineInputBorder(
                              borderSide: BorderSide()),
                          color: Theme.of(context).colorScheme.background,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: (user.verify == true)
                                ? Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                        Text(
                                          'Đã xác minh',
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .error,
                                              fontSize: 20,
                                              fontStyle: FontStyle.italic),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Icon(
                                          Icons.verified_outlined,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        )
                                      ])
                                : Text(
                                    'Đang chờ duyệt',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .error),
                                  ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                        style: BorderStyle.solid,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  color: Theme.of(context).colorScheme.background,
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Center(
                        child: Text(
                          'Kinh nghiệm',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(30),
                            child: (user.experience != null)
                                ? Text(
                                    user.experience!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontSize: 18,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                  )
                                : Text('Chưa cập nhật',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .error)),
                          ))
                        ],
                      ),
                    ],
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                        style: BorderStyle.solid,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  color: Theme.of(context).colorScheme.background,
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                        child: Row(
                          children: [
                            const Icon(Icons.person_2_outlined),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              'Giới tính : ',
                              style: TextStyle(fontSize: 20),
                            ),
                            (user.gender != null)
                                ? Text(
                                    user.gender!,
                                    style: const TextStyle(fontSize: 20),
                                  )
                                : Text(
                                    'Chưa cập nhật',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .error),
                                  ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                        child: Row(
                          children: [
                            const Icon(Icons.info_outline),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              'Tuổi :',
                              style: TextStyle(fontSize: 20),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            (user.born != null)
                                ? Expanded(
                                    child: Text(
                                      (int.parse(DateFormat('yyyy').format(DateTime.now()))-int.parse(DateFormat('yyyy').format(user.born!.toDate()))).toString(),
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                  )
                                : Expanded(
                                    child: Text(
                                      textAlign: TextAlign.start,
                                      'Chưa cập nhật',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .error),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                        child: Row(children: [
                          const Icon(Icons.location_on_outlined),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            'Đang ở :',
                            style: TextStyle(fontSize: 20),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: (user.address != null)
                                  ? Text(
                                      textAlign: TextAlign.start,
                                      // (user.address!.ward!+' , '+user.address!.district! +' , '+user.address!.province!),
                                      ((user.address!.ward != null
                                              ? (user.address!.ward! + ' , ')
                                              : '') +
                                          (user.address!.district != null
                                              ? (user.address!.district! +
                                                  ' , ')
                                              : '') +
                                          (user.address!.province != null
                                              ? (user.address!.province!)
                                              : '')),
                                      style: const TextStyle(fontSize: 20),
                                    )
                                  : Text(
                                      textAlign: TextAlign.start,
                                      'Chưa cập nhật',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .error),
                                    ))
                        ]),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                        child: Row(
                          children: [
                            const Icon(Icons.school_outlined),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text('Trường : ', style: TextStyle(fontSize: 20)),
                            Expanded(
                              child: (user.education?.university != null)
                                  ? Text(
                                      user.education!.university!,
                                      style: const TextStyle(fontSize: 20),
                                    )
                                  : Text('Chưa cập nhật',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .error)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                        child: Row(
                          children: [
                            const Icon(Icons.class_outlined),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              'Ngành :',
                              style: TextStyle(fontSize: 20),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: (user.education?.major != null)
                                  ? Text(
                                      user.education!.major!,
                                      style: const TextStyle(fontSize: 20),
                                    )
                                  : Text('Chưa cập nhât',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .error)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                        style: BorderStyle.solid,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  color: Theme.of(context).colorScheme.background,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Center(
                        child: Text(
                          'Môn dạy kèm',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      const SizedBox(height: 10),
                      (user.subjects != null)
                          ? Wrap(
                              children: [
                                ...user.subjects!.map((subjectName) =>
                                    MiniCard(cardName: subjectName))
                                // for (String subject in user.subjects!) ...[SubjectCard(subjectName: subject)]
                              ],
                            )
                          : Center(
                              child: Text(
                                'Chưa cập nhật',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Theme.of(context).colorScheme.error),
                              ),
                            ),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                        style: BorderStyle.solid,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  color: Theme.of(context).colorScheme.background,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Center(
                        child: Text(
                          'Khu vực dạy kèm tại nhà',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      const SizedBox(height: 20,)
                      ,
                      (user.teachAddress != null)
                          ? Wrap(
                              children: [
                                ...user.teachAddress!
                                    .map((item) => MiniCard(cardName: item))
                              ],
                            )
                          : Center(
                            child: Text(
                                'Chưa cập nhật',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Theme.of(context).colorScheme.error),
                              ),
                          ),
                      const SizedBox(height: 20,)
                    ],
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                        style: BorderStyle.solid,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  color: Theme.of(context).colorScheme.background,
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
           Center(
            child: SingleChildScrollView(
              child: DynamicTimeline(
                firstDateTime: DateTime(1970, 1, 1, 7),
                lastDateTime: DateTime(1970, 1, 1, 22),
                labelBuilder: DateFormat('HH:mm').format,
                intervalDuration:  Duration(minutes: 30),
                items: [
                  TimelineItem(
                    startDateTime: DateTime(1970, 1, 1, 7),
                    endDateTime: DateTime(1970, 1, 1, 8),
                    child: const Text('Event 1'),
                  ),
                  TimelineItem(
                    startDateTime: DateTime(1970, 1, 1, 10),
                    endDateTime: DateTime(1970, 1, 1, 12),
                    child: const Text('Event 2'),
                  ),
                  TimelineItem(
                    startDateTime: DateTime(1970, 1, 1, 15),
                    endDateTime: DateTime(1970, 1, 1, 17),
                    child: const Text('Event 3'),
                  ),
                ],
              ),
            ),
          ),
          const Center(
            child: Text("It's sunny here"),
          ),
        ],
      ),
    );
  }
}
