import 'package:flutter/material.dart';
import 'package:datn/model/user/user.dart' as model_user;
import 'package:intl/intl.dart';

import '../../widget/mini_card.dart';
import 'package:datn/screen/qr_code/components/qr_code_view.dart';
import 'dart:convert';

class ShowInfoLearner extends StatefulWidget {
  ShowInfoLearner({super.key, required this.learner});

  model_user.User learner;

  @override
  State<StatefulWidget> createState() {
    return _ShowInfoLearnerState();
  }
}

class _ShowInfoLearnerState extends State<ShowInfoLearner> {
  void _openModal(BuildContext context, model_user.User user) {
    var info = {"uid": user.uid, "type": 'learner'};
    String jsonInfo = user.uid != null ? jsonEncode(info) : "";
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            width: double.infinity,
            height: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: QRCodeView(text: jsonInfo),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin học sinh'),
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
                        backgroundImage: (widget.learner.photoUrl != null)
                            ? NetworkImage(widget.learner.photoUrl!)
                            : const AssetImage('assets/bear.jpg')
                                as ImageProvider,
                        radius: 50),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20, left: 20),
                      child: Center(
                        child: (widget.learner.displayName != null)
                            ? Text(
                                widget.learner.displayName!,
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
                              Theme.of(context).colorScheme.background)),
                      onPressed: () {
                        _openModal(context, widget.learner);
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
                        child: (widget.learner.verify == true)
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
                children: [
                  const SizedBox(
                    height: 20,
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
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                    child: Row(
                      children: [
                        const Icon(Icons.person_2_outlined),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'Giới tính : ',
                          style: TextStyle(fontSize: 10),
                        ),
                        (widget.learner.gender != null)
                            ? Text(
                                widget.learner.gender!,
                                style: const TextStyle(fontSize: 15),
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
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                    child: Row(
                      children: [
                        const Icon(Icons.info_outline),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'Số điện thoại :',
                          style: TextStyle(fontSize: 10),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        (widget.learner.phone != null)
                            ? Text(
                                widget.learner.phone!,
                                style: const TextStyle(fontSize: 15),
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
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                    child: Row(children: [
                      const Icon(Icons.location_on_outlined),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        'Địa chỉ Email :',
                        style: TextStyle(fontSize: 10),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      (widget.learner.email != null)
                          ? Text(
                              widget.learner.email!,
                              style: const TextStyle(fontSize: 15),
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
                    ]),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
