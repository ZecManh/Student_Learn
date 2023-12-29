import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datn/database/firestore/firestore_service.dart';
import 'package:datn/database/storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:datn/model/user/user.dart' as model_user;
import 'package:provider/provider.dart';
import '../../../database/auth/firebase_auth_service.dart';

List<String> genders = ['Nam', 'Nữ', 'Khác'];

class InfoLearner extends StatefulWidget {
  const InfoLearner({super.key});

  @override
  State<StatefulWidget> createState() {
    return _InfoLearnerState();
  }
}

class _InfoLearnerState extends State<InfoLearner> {
  FirebaseAuthService authService = FirebaseAuthService();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirestoreService firestoreService = FirestoreService();
  FirebaseStorageService firebaseStorageService = FirebaseStorageService();
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    model_user.User user = Provider.of<model_user.User>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Thông tin người học'),
      ),
      body: Builder(
        builder: (BuildContext context) => Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Center(
            child: Column(
              children: [
                GestureDetector(
                  child: StreamBuilder<model_user.User>(
                      stream: firestoreService.user(auth.currentUser!.uid),
                      builder:
                          (context, AsyncSnapshot<model_user.User> snapshot) {
                        model_user.User? user = snapshot.data;
                        if (user != null) {
                          return CircleAvatar(
                              backgroundImage: (user.photoUrl != null)
                                  ? NetworkImage(user.photoUrl!)
                                  : AssetImage('assets/bear.jpg')
                                      as ImageProvider,
                              radius: 50);
                        } else {
                          return CircleAvatar(
                            backgroundImage: AssetImage('assets/bear.jpg'),
                            radius: 50,
                          );
                        }
                      }),
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 20,
                ),
                Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.name,
                        obscureText: false,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Họ và tên',
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (String? phoneNumber) {
                          if (phoneNumber == null || phoneNumber.isEmpty) {
                            return null;
                          } else {
                            // You may need to change this pattern to fit your requirement.
                            // I just copied the pattern from here: https://regexr.com/3c53v
                            const pattern =
                                r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
                            final regExp = RegExp(pattern);

                            if (!regExp.hasMatch(phoneNumber)) {
                              return 'Không đúng định dạng';
                            }
                            return null;
                          }
                        },
                        keyboardType: TextInputType.phone,
                        obscureText: false,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Số điện thoại',
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        initialValue: auth.currentUser?.email,
                        readOnly: true,
                        keyboardType: TextInputType.emailAddress,
                        obscureText: false,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Địa chỉ email',
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text('Giới tính'),
                      const SizedBox(
                        height: 10,
                      ),
                      DropdownMenu<String>(
                        dropdownMenuEntries: genders
                            .map((value) => DropdownMenuEntry<String>(
                                value: value, label: value))
                            .toList(),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        // validator: validateEmail,

                        readOnly: true,
                        keyboardType: TextInputType.datetime,
                        obscureText: false,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Sinh nhật',
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      OutlinedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Theme.of(context).colorScheme.primary),
                            foregroundColor: MaterialStateProperty.all(
                                Theme.of(context).colorScheme.background)),
                        onPressed: null,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
