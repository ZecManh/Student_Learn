import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datn/database/firestore/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:datn/model/user/user.dart' as model_user;
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../../../model/user/user.dart';
import '../../../model/vn_province/district.dart';
import '../../../model/vn_province/province.dart';
import '../../../model/vn_province/ward.dart';

List<String> genders = ['Nam', 'Nữ', 'Khác'];

class UpdateAddress extends StatefulWidget {
  const UpdateAddress({super.key});

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
  List<Province> provinces = [];
  List<Districts> districts=[];
  List<Wards> wards=[];
  Province? dropDownProvince;
  Districts? dropDownDistrict;
  Wards? dropDownWards;

  @override
  void initState() {
    super.initState();
    initInfo();
    getProvince();
  }

  initInfo() {
    model_user.User sendUser =
        Provider.of<model_user.User>(context, listen: false);
    nameController = TextEditingController(
        text: (sendUser.displayName != null)
            ? (sendUser.displayName!)
            : ('Vui lòng cập nhật'));
    phoneController = TextEditingController(
        text: (sendUser.phone != null)
            ? (sendUser.phone!)
            : ('Vui lòng cập nhật'));
    emailController = TextEditingController(text: sendUser.email!);
    dateController = TextEditingController(
        text: (sendUser.born != null)
            // ? (DateFormat('yyyy-MM-dd').format(sendUser.born!))
            ? sendUser.born
            : 'Vui lòng cập nhật');
    dropDownGender = (sendUser.gender != null) ? sendUser.gender! : 'Nam';
  }

  Future getProvince() async {
    final url = Uri.https('provinces.open-api.vn', '/api/p/');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      // var jsonResponse = convert.jsonDecode(response.body) as List<dynamic>;
      // print('number of item response' + jsonResponse.length.toString());
      // List<Province> provinceFromJson = [];
      // provinceFromJson = jsonResponse.map((e) {
      //   return Province.fromJson(e);
      // }).toList();
      // provinceFromJson.forEach((element) {
      //   print(element.toString());
      // });
      //doan nay loi utf8

      // var decoded=utf8.decode(response.body.codeUnits);
      // print("decoded "+decoded);
      //doan nay ok https://stackoverflow.com/questions/51101471/how-can-i-convert-string-to-utf8-in-dart
      //https://copyprogramming.com/howto/utf-8-encoding-in-api-result-dart-flutter
      //utf8 for http request flutter

      var json = convert.utf8.decoder
          .convert(response.body.codeUnits); //convert to utf8
      var jsonResponse =
          convert.jsonDecode(json) as List<dynamic>; //json utf8 -> List
      List<Province> provinceFromJson = [];
      provinceFromJson = jsonResponse.map((e) {
        //list<dynamic> -> list<Province>
        return Province.fromJson(e);
      }).toList();
      provinceFromJson.forEach((element) {
        print(element.toString());
      });
      setState(() {
        provinces = List.from(provinceFromJson);
        dropDownProvince = provinces.first;
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  Future getDistrictByProvince(int code) async{
    final url=Uri.https('provinces.open-api.vn','/api/p/$code/',{'depth':'3',});
    print("url "+url.toString());
    var response=await http.get(url);
    if (response.statusCode == 200) {
      var jsonDecoded=convert.utf8.decoder.convert(response.body.codeUnits);
      var jsonResponse=convert.jsonDecode(jsonDecoded) as Map<String,dynamic>;
      Province province=Province.fromJson(jsonResponse);
      print(province.toString());
      setState(() {
        districts=List.from(province.districts!);
        dropDownDistrict=districts[0];
      });
    }{

    }
  }

  void getWardByProvince(int code) {

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
              child: Card(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child:  Row(
                      children: [ Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Text('Tỉnh / Thành Phố',style: TextStyle(fontSize: 20),),
                              SizedBox(
                                height: 10,
                              ),
                              DropdownMenu<Province>(
                                  width: MediaQuery.of(context).size.width-60,
                                  initialSelection: dropDownProvince,
                                  onSelected: (Province? newProvince) {
                                    setState(() {
                                      dropDownProvince = newProvince!;
                                      print(newProvince.toString());
                                      getDistrictByProvince(newProvince.code!);
                                    });
                                  },
                                  dropdownMenuEntries: provinces.map((item) {
                                    return DropdownMenuEntry<Province>(
                                        value: item!,
                                        label: item.name!,
                                        style: ButtonStyle(
                                            textStyle: MaterialStateProperty.all(
                                                TextStyle(color: Colors.white))));
                                  }).toList()),
                              SizedBox(height: 20,),
                              Text('Quận / Huyện',style: TextStyle(fontSize: 20),),
                             SizedBox(height: 10,),
                             DropdownMenu<Districts>(
                                    width: MediaQuery.of(context).size.width-60,
                                    initialSelection: dropDownDistrict,
                                    onSelected: (Districts? newDistricts) {
                                      setState(() {
                                        dropDownDistrict = newDistricts!;
                                        wards=newDistricts.wards!;
                                        print(newDistricts.toString());
                                      });
                                    },
                                    dropdownMenuEntries:
                                    districts.map((item){
                                      return DropdownMenuEntry<Districts>(value: item!, label: item.name!,style:ButtonStyle(
                                                    textStyle: MaterialStateProperty.all(
                                                        TextStyle(color: Colors.white))));
                                    }).toList()),
                              SizedBox(
                                height: 20,
                              ),
                              Text('Phường / Xã',style: TextStyle(fontSize: 20),),
                              SizedBox(height: 10,),
                              DropdownMenu<Wards>(
                                  width: MediaQuery.of(context).size.width-60,
                                  initialSelection: dropDownWards,
                                  onSelected: (Wards? newWards) {
                                    setState(() {
                                      dropDownWards = newWards!;
                                      print(newWards.toString());
                                    });
                                  },
                                  dropdownMenuEntries:
                                  wards.map((item){
                                    return DropdownMenuEntry<Wards>(value: item!, label: item.name!,style:ButtonStyle(
                                        textStyle: MaterialStateProperty.all(
                                            TextStyle(color: Colors.white))));
                                  }).toList()),
                              SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: OutlinedButton(
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
                                                  Address address=Address();
                                                  address.province=dropDownProvince?.name;
                                                  address.district=dropDownDistrict?.name;
                                                  address.ward=dropDownWards?.name;
                                                  firestoreService.updateAddress(auth.currentUser!.uid, address as model_user.Address);
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
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              // ...provinces
                              //     .map((e) => Text((e.name != null) ? e.name! : ''))
                              //     .toList()
                            ],
                          ),
                      ),
                      ]
                    ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
