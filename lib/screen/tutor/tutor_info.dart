import 'package:flutter/material.dart';

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
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tổng quan'),
        actions: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: IconButton(onPressed: () {}, icon: Icon(Icons.edit)))
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Padding(
                padding: EdgeInsets.all(10),
                child: Text('Về tôi', style: TextStyle(fontSize: 20))),
            Padding(
                padding: EdgeInsets.all(10),
                child: Text('Lịch dạy', style: TextStyle(fontSize: 20))),
            Padding(
                padding: EdgeInsets.all(10),
                child: Text('Đánh giá', style: TextStyle(fontSize: 20))),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          SingleChildScrollView(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
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
                                    backgroundImage:
                                        AssetImage('assets/bear.jpg'),
                                    radius: 70,
                                  ),
                                ]),
                          ),
                          Center(
                            child: Text(
                              'Vũ Minh Hiếu',
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Text(
                              'Sinh viên',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Card(
                            shape: OutlineInputBorder(borderSide: BorderSide()),
                            color: Theme.of(context).colorScheme.background,
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Đã xác minh',
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
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
                                  ]),
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
                              child: Text(
                                '10 năm trong ngành lập trình mobile',
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontSize: 18,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              ),
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
                                'Nam',
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                '22 tuổi',
                                style: TextStyle(fontSize: 20),
                              )
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
                                child: Text(
                                  textAlign: TextAlign.start,
                                  'Nam Từ Liêm,Hà Nội',
                                  style: TextStyle(fontSize: 20),
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
                          child: Row(
                            children: [
                              Icon(Icons.school_outlined),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  'Năm 4 - Trường Đại Học Thuỷ Lợi',
                                  style: TextStyle(fontSize: 20),
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
                              Text(
                                'Công nghệ thông tin',
                                style: TextStyle(fontSize: 20),
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
                                'Lớp :',
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                '61THNB',
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
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
                            'Môn dạy kèm',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Card(
                                child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      'Lập trình ứng dụng di động',
                                      style: TextStyle(fontSize: 14),
                                    ))),
                            Card(
                                child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      'Lập trình hướng đối tượng',
                                      style: TextStyle(fontSize: 14),
                                    ))),
                            Card(
                                child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      'Lập trình java',
                                      style: TextStyle(fontSize: 14),
                                    ))),
                          ],
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Card(
                                child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      'Từ Liêm',
                                      style: TextStyle(fontSize: 14),
                                    ))),
                            Card(
                                child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      'Đống Đa',
                                      style: TextStyle(fontSize: 14),
                                    ))),
                            Card(
                                child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      'Hà Đông',
                                      style: TextStyle(fontSize: 14),
                                    )))
                          ],
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
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Text(
                            'Dạy online',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.all(20),
                            child: Text(
                              'Tôi có thể dạy 1 kèm 1 online qua Zoom , Google meet',
                              style: TextStyle(fontSize: 16),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
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
