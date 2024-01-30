import 'package:datn/screen/learner/search_tutor/register_tutor.dart';
import 'package:flutter/material.dart';
import 'package:datn/model/user/user.dart' as model_user;
import 'package:intl/intl.dart';

import '../../widget/mini_card.dart';
import 'package:datn/screen/qr_code/components/qr_code_view.dart';
import 'dart:convert';

class TuTorShowInfo extends StatefulWidget {
  TuTorShowInfo({required this.tutor, super.key});

  model_user.User tutor;

  @override
  State<StatefulWidget> createState() {

    return _TutorShowInfoState();
  }
}

class _TutorShowInfoState extends State<TuTorShowInfo> {

  void _openModal(BuildContext context) {
    var info = {
      "uid": widget.tutor.uid,
      "type": 'tutor'
    };
    String jsonInfo = widget.tutor.uid != null ? jsonEncode(info) : "";
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return
          Dialog(
            child: Container(
              width: double.infinity,
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Center(
                      child: QRCodeView(text : jsonInfo),
                    ),
                  ),
                ],
              ),
            ),
          );
          // Container(
          // child: ),);
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin gia sư'),
      ),
      body: SingleChildScrollView(
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
                    const SizedBox(
                      height: 20,
                    ),
                    CircleAvatar(
                        backgroundImage: (widget.tutor.photoUrl != null)
                            ? NetworkImage(widget.tutor.photoUrl!)
                            : const AssetImage('assets/bear.jpg') as ImageProvider,
                        radius: 50),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20, left: 20),
                      child: Center(
                        child: (widget.tutor.displayName != null)
                            ? Text(
                                widget.tutor.displayName!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 24),
                              )
                            : Text('',
                                style: TextStyle(
                                    fontSize: 24,
                                    color:
                                        Theme.of(context).colorScheme.error)),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
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
                        _openModal(context);
                      },
                      icon: const Icon(Icons.qr_code),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Card(
                      shape: const OutlineInputBorder(borderSide: BorderSide()),
                      color: Theme.of(context).colorScheme.background,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: (widget.tutor.verify == true)
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
                                    color: Theme.of(context).colorScheme.error),
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
                        child: (widget.tutor.experience != null)
                            ? Text(
                                widget.tutor.experience!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontSize: 18,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              )
                            : Text('',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20,
                                    color:
                                        Theme.of(context).colorScheme.error)),
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
                    padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
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
                        (widget.tutor.gender != null)
                            ? Text(
                                widget.tutor.gender!,
                                style: const TextStyle(fontSize: 20),
                              )
                            : Text(
                                '',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Theme.of(context).colorScheme.error),
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
                    padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
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
                        (widget.tutor.born != null)
                            ? Expanded(
                                child: Text(
                                  (int.parse(DateFormat('yyyy')
                                              .format(DateTime.now())) -
                                          int.parse(DateFormat('yyyy').format(
                                              widget.tutor.born!.toDate())))
                                      .toString(),
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(fontSize: 20),
                                ),
                              )
                            : Expanded(
                                child: Text(
                                  textAlign: TextAlign.start,
                                  '',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color:
                                          Theme.of(context).colorScheme.error),
                                ),
                              ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
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
                          child: (widget.tutor.address != null)
                              ? Text(
                                  textAlign: TextAlign.start,
                                  // (user.address!.ward!+' , '+user.address!.district! +' , '+user.address!.province!),
                                  ((widget.tutor.address!.ward != null
                                          ? (widget.tutor.address!.ward! +
                                              ' , ')
                                          : '') +
                                      (widget.tutor.address!.district != null
                                          ? (widget.tutor.address!.district! +
                                              ' , ')
                                          : '') +
                                      (widget.tutor.address!.province != null
                                          ? (widget.tutor.address!.province!)
                                          : '')),
                                  style: const TextStyle(fontSize: 20),
                                )
                              : Text(
                                  textAlign: TextAlign.start,
                                  '',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color:
                                          Theme.of(context).colorScheme.error),
                                ))
                    ]),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                    child: Row(
                      children: [
                        const Icon(Icons.school_outlined),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text('Trường : ', style: TextStyle(fontSize: 20)),
                        Expanded(
                          child: (widget.tutor.education?.university != null)
                              ? Text(
                                  widget.tutor.education!.university!,
                                  style: const TextStyle(fontSize: 20),
                                )
                              : Text('',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color:
                                          Theme.of(context).colorScheme.error)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
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
                          child: (widget.tutor.education?.major != null)
                              ? Text(
                                  widget.tutor.education!.major!,
                                  style: const TextStyle(fontSize: 20),
                                )
                              : Text('',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color:
                                          Theme.of(context).colorScheme.error)),
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
                  (widget.tutor.subjects != null)
                      ? Wrap(
                          children: [
                            ...widget.tutor.subjects!.map((subjectName) =>
                                MiniCard(cardName: subjectName))
                            // for (String subject in user.subjects!) ...[SubjectCard(subjectName: subject)]
                          ],
                        )
                      : Center(
                          child: Text('',
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
                  (widget.tutor.teachAddress != null)
                      ? Wrap(
                          children: [
                            ...widget.tutor.teachAddress!
                                .map((item) => MiniCard(cardName: item))
                          ],
                        )
                      : Text(
                          '',
                          style: TextStyle(
                              fontSize: 20,
                              color: Theme.of(context).colorScheme.error),
                        ),
                ],
              ),
            ),

           Center(child: OutlinedButton(onPressed: (){
             Navigator.push(
                 context,
                 MaterialPageRoute(
                     builder: (context) =>
                         RegisterTutor(tutor: widget.tutor)));
           }, child: const Text('Đăng kí học')))
          ],
        ),
      ),
    );
  }
}
