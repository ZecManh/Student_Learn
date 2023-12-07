import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datn/database/firestore/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:datn/model/user.dart' as model_user;

List<String> genders = ['Nam', 'Nữ', 'Khác'];

class UpdateAddress extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _UpdateAddressState();
  }
}

class _UpdateAddressState extends State<UpdateAddress> {
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController dateController;
  late TextEditingController emailController;
  String dropDownGender = genders.first;

  @override
  void initState() {
    super.initState();
    initInfo();

  }

  initInfo(){
    model_user.User sendUser=Provider.of<model_user.User>(context,listen:false);
    nameController = TextEditingController(
        text: (sendUser.displayName != null)
            ? (sendUser.displayName!)
            : ('Vui lòng cập nhật'));
    phoneController = TextEditingController(
        text:
        (sendUser.phone != null) ? (sendUser.phone!) : ('Vui lòng cập nhật'));
    emailController = TextEditingController(text: sendUser.email!);
    dateController = TextEditingController(
        text: (sendUser.born != null)
            ? (DateFormat('yyyy-MM-dd').format(sendUser.born!))
            : 'Vui lòng cập nhật');
    dropDownGender = (sendUser.gender != null) ? sendUser.gender! : 'Nam';
  }
  @override
  Widget build(BuildContext context) {
    FirestoreService firestoreService = FirestoreService();
    FirebaseAuth auth = FirebaseAuth.instance;
    return MultiProvider(
      providers: [
        StreamProvider<model_user.User>(
            create: (context) => firestoreService.user(auth.currentUser!.uid),
            initialData: model_user.User())
      ],
      child: Builder(
        builder: (context) {
          model_user.User user = Provider.of<model_user.User>(context);

          return Scaffold(
            appBar: AppBar(
              title: Text('Thông tin địa chỉ'),
            ),
            body: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Center(
                    child: Card(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: 20,
                        ),

                        TextFormField(
                          keyboardType: TextInputType.name,
                          controller: nameController,
                          obscureText: false,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Theme.of(context).colorScheme.background,
                            border: const OutlineInputBorder(),
                            labelText: 'Tỉnh thành',
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.name,
                          controller: phoneController,
                          obscureText: false,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Theme.of(context).colorScheme.background,
                            border: const OutlineInputBorder(),
                            labelText: 'Quận,Huyện',
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          enabled: false,
                          keyboardType: TextInputType.name,
                          controller: emailController,
                          obscureText: false,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Theme.of(context).colorScheme.background,
                            border: const OutlineInputBorder(),
                            labelText: 'Địa chỉ email',
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        DropdownMenu<String>(
                          menuStyle: MenuStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Theme.of(context).colorScheme.background)),
                          initialSelection: dropDownGender,
                          onSelected: (String? gender) {
                            dropDownGender = gender!;
                          },
                          dropdownMenuEntries: genders
                              .map(
                                (value) {
                                  return DropdownMenuEntry<String>(
                                      value: value, label: value);
                                }
                              )
                              .toList(),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                            controller: dateController,
                            readOnly: true,
                            keyboardType: TextInputType.datetime,
                            obscureText: false,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor:
                                  Theme.of(context).colorScheme.background,
                              border: const OutlineInputBorder(),
                              labelText: 'Sinh nhật',
                            ),
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1950),
                                  lastDate: DateTime.now());
                              if (pickedDate != null) {
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                dateController.text = formattedDate;
                              }
                            }),
                        SizedBox(height: 20,),
                        OutlinedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Theme.of(context).colorScheme.primary),
                              foregroundColor: MaterialStateProperty.all(
                                  Theme.of(context).colorScheme.background)),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Xác nhận'),
                                    content: Text(
                                        'Bạn chắc chắn với sự thay đổi này?'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'Cancel'),
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          DateTime date = DateTime.parse(
                                              dateController.text);
                                          firestoreService.updateInfo(
                                              auth.currentUser!.uid,
                                              nameController.text,
                                              phoneController.text,
                                              Timestamp.fromDate(date),
                                              dropDownGender);
                                          Navigator.pop(context, 'OK');
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  );
                                });
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Text(
                              'Cập nhật',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )),
              ),
            ),
          );
        },
      ),
    );
  }
}
