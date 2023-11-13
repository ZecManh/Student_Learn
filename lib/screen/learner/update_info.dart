import 'package:datn/widget/outlined_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

List<String> genders = ['Nam', 'Nữ', 'Khác'];

class UpdateInfoScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UpdateInfoScreenState();
  }
}

class _UpdateInfoScreenState extends State<UpdateInfoScreen> {
  String dropDownGender = genders.first;
  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey();
  bool isEdit =false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    dateController.dispose();
    phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Thông tin chung'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Center(
          child: Column(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/bear.jpg'),
                radius: 50,
              ),
              SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    OutlinedButton.icon(onPressed: (){}, icon: Icon(isEdit?Icons.edit:Icons.edit), label: Text('Sửa')),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      controller: nameController,
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Họ và tên',
                      ),
                    ),
                    SizedBox(
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
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Số điện thoại',
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      readOnly: true,
                      keyboardType: TextInputType.emailAddress,
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Địa chỉ email',
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text('Giới tính'),
                    SizedBox(
                      height: 10,
                    ),
                    DropdownMenu<String>(
                      initialSelection: dropDownGender,
                      onSelected: (String? gender) {
                        setState(() {
                          dropDownGender = gender!;
                        });
                      },
                      dropdownMenuEntries: genders
                          .map((value) => DropdownMenuEntry<String>(
                              value: value, label: value))
                          .toList(),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      // validator: validateEmail,
                      controller: dateController,
                      readOnly: true,
                      keyboardType: TextInputType.datetime,
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Năm sinh',
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
                          setState(() {
                            dateController.text = formattedDate;
                          });
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    MyOutlinedButton(
                        callback: () {
                          print('cap nhat thong tin');

                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Cập nhật thành công'),
                              ),
                            );
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Cập nhật thất bại'),
                              ),
                            );
                          }
                          Form.of(context).validate();
                        },
                        content: 'Cập nhật')
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
