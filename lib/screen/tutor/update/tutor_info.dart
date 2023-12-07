import 'package:datn/model/user.dart';
import 'package:datn/screen/tutor/update/tutor_update_info.dart';
import 'package:datn/screen/widget/mini_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TutorInfo extends StatefulWidget {
  const TutorInfo({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TutorInfoState();
  }
}

class _TutorInfoState extends State<TutorInfo> with TickerProviderStateMixin {
  late final TabController _tabController;

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
    User user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tổng quan'),
        actions: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: IconButton(onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      return UpdateInfoTutor() ;
                    }) );
              }, icon: const Icon(Icons.edit)))
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            const Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Icon(Icons.person_3_outlined)),
            const Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Icon(Icons.calendar_month_outlined)),
            const Padding(
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
                          padding: EdgeInsets.all(20),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                    backgroundImage: (user.photoUrl != null)
                                        ? NetworkImage(user.photoUrl!)
                                        : AssetImage('assets/bear.jpg') as ImageProvider,
                                    radius: 80),
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
                            padding: EdgeInsets.all(10),
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
                                        SizedBox(
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
                        SizedBox(
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
                      SizedBox(
                        height: 20,
                      ),
                      Center(
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
                            padding: EdgeInsets.all(30),
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
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                        child: Row(
                          children: [
                            Icon(Icons.person_2_outlined),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Giới tính : ',
                              style: TextStyle(fontSize: 20),
                            ),
                            (user.gender != null)
                                ? Text(
                                    user.gender!,
                                    style: TextStyle(fontSize: 20),
                                  )
                                : Text(
                                    'Chưa cập nhật',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .error),
                                  ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                        child: Row(
                          children: [
                            Icon(Icons.info_outline),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Tuổi :',
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            (user.born != null)
                                ? Expanded(
                                    child: Text(
                                      textAlign: TextAlign.start,
                                      (DateTime.timestamp().year -
                                              user.born!.year)
                                          .toString(),
                                      style: TextStyle(fontSize: 20),
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
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                        child: Row(children: [
                          Icon(Icons.location_on_outlined),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Đang ở :',
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: (user.address != null)
                                  ? Text(
                                      textAlign: TextAlign.start,
                                      user.address!,
                                      style: TextStyle(fontSize: 20),
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
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                        child: Row(
                          children: [
                            Icon(Icons.school_outlined),
                            SizedBox(
                              width: 10,
                            ),
                            Text('Trường : ', style: TextStyle(fontSize: 20)),
                            Expanded(
                              child: (user.university != null)
                                  ? Text(
                                      user.university!,
                                      style: TextStyle(fontSize: 20),
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
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                        child: Row(
                          children: [
                            Icon(Icons.class_outlined),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Ngành :',
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: (user.university != null)
                                  ? Text(
                                      user.university!,
                                      style: TextStyle(fontSize: 20),
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
                      SizedBox(
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
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Text(
                          'Môn dạy kèm',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      SizedBox(height: 10),
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
                      SizedBox(
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
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Text(
                          'Khu vực dạy kèm tại nhà',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      (user.teachAddress != null)
                          ? Wrap(
                              children: [
                                ...user.teachAddress!
                                    .map((item) => MiniCard(cardName: item))
                              ],
                            )
                          : Text(
                              'Chưa cập nhật',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Theme.of(context).colorScheme.error),
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
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Text(
                          'Phương thức giảng dạy',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.all(10),
                          child:
                          (user.teachMethod!=null)?
                              Wrap(children: [
                                ...user.teachMethod!.map((item) =>MiniCard(cardName: item)),
                              ],):Text(
                            'Chưa cập nhật',
                            style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).colorScheme.error),
                          )
                        )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Text("It's rainy here"),
          ),
          Center(
            child: Text("It's sunny here"),
          ),
        ],
      ),
    );
  }
}
