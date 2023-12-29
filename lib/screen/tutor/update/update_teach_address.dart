import 'package:datn/database/firestore/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:datn/model/user/user.dart' as model_user;
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../../../model/vn_province/district.dart';
import '../../../model/vn_province/province.dart';
import '../../../model/vn_province/ward.dart';

class UpdateTeachAddress extends StatefulWidget {
  const UpdateTeachAddress({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _UpdateTeachAddressState();
  }
}

class _UpdateTeachAddressState extends State<UpdateTeachAddress> {
  List<Province> provinces = [];
  List<Districts> districts = [];
  List<String> chosenDistricts = [];
  List<Wards> wards = [];
  Province? dropDownProvince;
  Districts? dropDownDistrict;
  Wards? dropDownWards;

  @override
  void initState() {
    super.initState();
    initInfo();
    getProvince();
    getHaNoiDistrics();
  }

  initInfo() {
    model_user.User sendUser =
        Provider.of<model_user.User>(context, listen: false);
    chosenDistricts = sendUser.teachAddress??[];
  }

  Future getProvince() async {
    final url = Uri.https('provinces.open-api.vn', '/api/p/');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var json = convert.utf8.decoder
          .convert(response.body.codeUnits); //convert to utf8
      var jsonResponse =
          convert.jsonDecode(json) as List<dynamic>; //json utf8 -> List
      List<Province> provinceFromJson = [];
      provinceFromJson = jsonResponse.map((e) {
        //list<dynamic> -> list<Province>
        return Province.fromJson(e);
      }).toList();
      provinceFromJson.forEach((element) {});
      setState(() {
        provinces = List.from(provinceFromJson);
        dropDownProvince = provinces.first;
      });
    } else {}
  }

  Future getHaNoiDistrics() async {
    final url = Uri.https('provinces.open-api.vn', '/api/p/1/', {
      'depth': '3',
    });
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonDecoded = convert.utf8.decoder.convert(response.body.codeUnits);
      var jsonResponse =
          convert.jsonDecode(jsonDecoded) as Map<String, dynamic>;
      Province province = Province.fromJson(jsonResponse);
      setState(() {
        districts = List.from(province.districts!);
        dropDownDistrict = districts[0];
      });
    }
  }

  Future getDistrictByProvince(int code) async {
    final url = Uri.https('provinces.open-api.vn', '/api/p/$code/', {
      'depth': '3',
    });
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonDecoded = convert.utf8.decoder.convert(response.body.codeUnits);
      var jsonResponse =
          convert.jsonDecode(jsonDecoded) as Map<String, dynamic>;
      Province province = Province.fromJson(jsonResponse);
      setState(() {
        districts = List.from(province.districts!);
        dropDownDistrict = districts[0];
      });
    }
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
              title: const Text('Khu vực dạy kèm'),
            ),
            body: SingleChildScrollView(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'Tỉnh / Thành Phố',
                            style: TextStyle(fontSize: 20),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          DropdownMenu<Province>(
                              enabled: false,
                              width: MediaQuery.of(context).size.width - 60,
                              initialSelection: dropDownProvince,
                              onSelected: (Province? newProvince) {
                                setState(() {
                                  dropDownProvince = newProvince!;
                                  getDistrictByProvince(newProvince.code!);
                                });
                              },
                              dropdownMenuEntries: provinces.map((item) {
                                return DropdownMenuEntry<Province>(
                                    value: item!,
                                    label: item.name!,
                                    style: ButtonStyle(
                                        textStyle: MaterialStateProperty.all(
                                            const TextStyle(
                                                color: Colors.white))));
                              }).toList()),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'Quận / Huyện',
                            style: TextStyle(fontSize: 20),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          DropdownMenu<Districts>(
                              width: MediaQuery.of(context).size.width - 60,
                              initialSelection: dropDownDistrict,
                              onSelected: (Districts? newDistricts) {
                                setState(() {
                                  dropDownDistrict = newDistricts!;
                                  chosenDistricts.add(newDistricts!.name!);
                                });
                              },
                              dropdownMenuEntries: districts.map((item) {
                                return DropdownMenuEntry<Districts>(
                                    value: item!,
                                    label: item.name!,
                                    style: ButtonStyle(
                                        textStyle: MaterialStateProperty.all(
                                            const TextStyle(
                                                color: Colors.white))));
                              }).toList()),
                          const SizedBox(
                            height: 20,
                          ),
                          Card(color: Theme.of(context).colorScheme.background,child: (chosenDistricts.length>0)?
                              Wrap(children: [
                                ...chosenDistricts.map((districtName) => Padding(padding: EdgeInsets.all(5),child: ElevatedButton.icon(style: ElevatedButton.styleFrom(backgroundColor:Theme.of(context).colorScheme.primary,foregroundColor:Theme.of(context).colorScheme.background  ,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),)),onPressed: () {
                                  setState(() {
                                    chosenDistricts.removeWhere((element) {return element == districtName;});
                                  });
                                },icon: Icon(Icons.remove),label: Text(districtName))))
                              ],)
                              :Text('')
                          ),
                          Center(
                            child: OutlinedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Theme.of(context).colorScheme.primary),
                                  foregroundColor: MaterialStateProperty.all(
                                      Theme.of(context)
                                          .colorScheme
                                          .background)),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Xác nhận'),
                                        content: const Text(
                                            'Bạn chắc chắn với sự thay đổi này?'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () => Navigator.pop(
                                                context, 'Cancel'),
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () async {

                                              firestoreService.updateTeachAddress(chosenDistricts);
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
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
