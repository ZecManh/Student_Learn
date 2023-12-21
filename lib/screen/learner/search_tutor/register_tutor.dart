import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datn/database/firestore/firestore_service.dart';
import 'package:datn/model/user/teach_schedules.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:datn/model/user/user.dart' as model_user;
import 'package:intl/intl.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import '../../../model/vn_province/district.dart';
import '../../../model/vn_province/province.dart';

class RegisterTutor extends StatefulWidget {
  model_user.User tutor;

  RegisterTutor({required this.tutor, super.key});

  @override
  State<StatefulWidget> createState() {
    return _RegisterTutorState();
  }
}

class _RegisterTutorState extends State<RegisterTutor> {
  List<String> subjects = [];
  List<String> teachMethod = ["Online", "Offline"];
  late String initSubject;
  late String initTeachMethod;
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  Time mondayStartTime = Time(hour: 00, minute: 00, second: 00);
  Time mondayEndTime = Time(hour: 00, minute: 00, second: 00);
  Time tuesdayStartTime = Time(hour: 00, minute: 00, second: 00);
  Time tuesdayEndTime = Time(hour: 00, minute: 00, second: 00);
  Time wednesdayStartTime = Time(hour: 00, minute: 00, second: 00);
  Time wednesdayEndTime = Time(hour: 00, minute: 00, second: 00);
  Time thursdayStartTime = Time(hour: 00, minute: 00, second: 00);
  Time thursdayEndTime = Time(hour: 00, minute: 00, second: 00);
  Time fridayStartTime = Time(hour: 00, minute: 00, second: 00);
  Time fridayEndTime = Time(hour: 00, minute: 00, second: 00);
  Time saturdayStartTime = Time(hour: 00, minute: 00, second: 00);
  Time saturdayEndTime = Time(hour: 00, minute: 00, second: 00);
  Time sundayStartTime = Time(hour: 00, minute: 00, second: 00);
  Time sundayEndTime = Time(hour: 00, minute: 00, second: 00);

  bool isMondayChosen = false;
  bool isTuesdayChosen = false;
  bool isWednesdayChosen = false;
  bool isThursdayChosen = false;
  bool isFridayChosen = false;
  bool isSaturdayChosen = false;
  bool isSundayChosen = false;

  List<Districts> districts = [];
  Districts? dropDownDistrict;
  var addressTextController = TextEditingController();

  void onMondayStartTimeChanged(Time newTime) {
    setState(() {
      mondayStartTime = newTime;
    });
  }

  void onMondayEndTimeChanged(Time newTime) {
    setState(() {
      mondayEndTime = newTime;
    });
  }

  void onTuesdayStartTimeChanged(Time newTime) {
    setState(() {
      tuesdayStartTime = newTime;
    });
  }

  void onTuesdayEndTimeChanged(Time newTime) {
    setState(() {
      tuesdayEndTime = newTime;
    });
  }

  void onWednesdayStartTimeChanged(Time newTime) {
    setState(() {
      wednesdayStartTime = newTime;
    });
  }

  void onWednesdayEndTimeChanged(Time newTime) {
    setState(() {
      wednesdayEndTime = newTime;
    });
  }

  void onThursdayStartTimeChanged(Time newTime) {
    setState(() {
      thursdayStartTime = newTime;
    });
  }

  void onThursdayEndTimeChanged(Time newTime) {
    setState(() {
      thursdayEndTime = newTime;
    });
  }

  void onFridayStartTimeChanged(Time newTime) {
    setState(() {
      fridayStartTime = newTime;
    });
  }

  void onFridayEndTimeChanged(Time newTime) {
    setState(() {
      fridayEndTime = newTime;
    });
  }

  void onSaturdayStartTimeChanged(Time newTime) {
    setState(() {
      saturdayStartTime = newTime;
    });
  }

  void onSaturdayEndTimeChanged(Time newTime) {
    setState(() {
      saturdayEndTime = newTime;
    });
  }

  void onSundayStartTimeChanged(Time newTime) {
    setState(() {
      sundayStartTime = newTime;
    });
  }

  void onSundayEndTimeChanged(Time newTime) {
    setState(() {
      sundayEndTime = newTime;
    });
  }

  @override
  void initState() {
    super.initState();
    subjects = widget.tutor.subjects ?? [];
    initSubject = subjects[0] ?? "";
    initTeachMethod = teachMethod[0];
    getHaNoiDistrics();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Đăng kí học")),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                      'Chọn môn học',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: DropdownMenu<String>(
                          initialSelection: subjects.first,
                          onSelected: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              initSubject = value!;
                            });
                          },
                          dropdownMenuEntries: subjects
                              .map<DropdownMenuEntry<String>>((String value) {
                            return DropdownMenuEntry<String>(
                                value: value, label: value);
                          }).toList(),
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
                  const SizedBox(
                    height: 20,
                  ),
                  const Center(
                    child: Text(
                      'Hình thức học',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: DropdownMenu<String>(
                          initialSelection: teachMethod.first,
                          onSelected: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              initTeachMethod = value!;
                            });
                          },
                          dropdownMenuEntries: teachMethod
                              .map<DropdownMenuEntry<String>>((String value) {
                            return DropdownMenuEntry<String>(
                                value: value, label: value);
                          }).toList(),
                        ),
                      ))
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Chọn địa chỉ',
                        style: TextStyle(fontSize: 20),
                      )),
                  Center(
                    child: DropdownMenu<Districts>(
                        width: MediaQuery.of(context).size.width - 40,
                        initialSelection: dropDownDistrict,
                        onSelected: (Districts? newDistricts) {
                          setState(() {
                            dropDownDistrict = newDistricts!;
                          });
                        },
                        dropdownMenuEntries: districts.map((item) {
                          return DropdownMenuEntry<Districts>(
                              value: item!,
                              label: item.name!,
                              style: ButtonStyle(
                                  textStyle: MaterialStateProperty.all(
                                      const TextStyle(color: Colors.white))));
                        }).toList()),
                  ),
                  const SizedBox(height: 20,),
                  TextFormField(
                    controller: addressTextController,
                    keyboardType: TextInputType.text,
                    obscureText: false,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Địa chỉ cụ thể',
                    ),
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
                  const Center(
                    child: Text(
                      'Thời gian học',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        TextFormField(
                            // validator: validateEmail,
                            controller: startDateController,
                            readOnly: true,
                            keyboardType: TextInputType.datetime,
                            obscureText: false,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Ngày bắt đầu học',
                            ),
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2030));
                              if (pickedDate != null) {
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                startDateController.text = formattedDate;
                              }
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                            // validator: validateEmail,
                            controller: endDateController,
                            readOnly: true,
                            keyboardType: TextInputType.datetime,
                            obscureText: false,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Ngày kết thúc học',
                            ),
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2030));
                              if (pickedDate != null) {
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                endDateController.text = formattedDate;
                              }
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Chọn lịch học dự kiến',
                          style: TextStyle(fontSize: 20),
                        ),
                        Card(
                          color: (isMondayChosen)
                              ? (Theme.of(context).colorScheme.primaryContainer)
                              : (Theme.of(context).colorScheme.onPrimary),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Row(children: [
                                    const Text(
                                      "Thứ 2",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Switch(
                                      value: isMondayChosen,
                                      onChanged: (newVal) {
                                        setState(() {
                                          isMondayChosen = newVal;
                                        });
                                      },
                                    )
                                  ]),
                                ),
                              ),
                              Text(
                                "${mondayStartTime.hour}:${mondayStartTime.minute} ${mondayStartTime.period.name}"
                                    .toUpperCase(),
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                              const SizedBox(height: 10),
                              TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    showPicker(
                                      showSecondSelector: true,
                                      context: context,
                                      value: mondayStartTime,
                                      onChange: onMondayStartTimeChanged,
                                      minuteInterval: TimePickerInterval.FIVE,
                                      // Optional onChange to receive value as DateTime
                                      onChangeDateTime: (DateTime dateTime) {
                                        // print(dateTime);
                                        debugPrint(
                                            "[debug datetime]:  $dateTime");
                                      },
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Chọn giờ",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Divider(),
                              const SizedBox(height: 10),
                              Text(
                                "${mondayEndTime.hour}:${mondayEndTime.minute} ${mondayEndTime.period.name}"
                                    .toUpperCase(),
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                              const SizedBox(height: 10),
                              TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    showPicker(
                                      showSecondSelector: true,
                                      context: context,
                                      value: mondayEndTime,
                                      onChange: onMondayEndTimeChanged,
                                      minuteInterval: TimePickerInterval.FIVE,
                                      // Optional onChange to receive value as DateTime
                                      onChangeDateTime: (DateTime dateTime) {
                                        // print(dateTime);
                                        debugPrint(
                                            "[debug datetime]:  $dateTime");
                                      },
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Chọn giờ",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                        Card(
                          color: (isTuesdayChosen)
                              ? (Theme.of(context).colorScheme.primaryContainer)
                              : (Theme.of(context).colorScheme.onPrimary),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Row(children: [
                                    const Text(
                                      "Thứ 3",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Switch(
                                      value: isTuesdayChosen,
                                      onChanged: (newVal) {
                                        setState(() {
                                          isTuesdayChosen = newVal;
                                        });
                                      },
                                    )
                                  ]),
                                ),
                              ),
                              Text(
                                "${tuesdayStartTime.hour}:${tuesdayStartTime.minute} ${tuesdayStartTime.period.name}"
                                    .toUpperCase(),
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                              const SizedBox(height: 10),
                              TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    showPicker(
                                      showSecondSelector: true,
                                      context: context,
                                      value: tuesdayStartTime,
                                      onChange: onTuesdayStartTimeChanged,
                                      minuteInterval: TimePickerInterval.FIVE,
                                      // Optional onChange to receive value as DateTime
                                      onChangeDateTime: (DateTime dateTime) {
                                        // print(dateTime);
                                        debugPrint(
                                            "[debug datetime]:  $dateTime");
                                      },
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Chọn giờ",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Divider(),
                              const SizedBox(height: 10),
                              Text(
                                "${tuesdayEndTime.hour}:${tuesdayEndTime.minute} ${tuesdayEndTime.period.name}"
                                    .toUpperCase(),
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                              const SizedBox(height: 10),
                              TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    showPicker(
                                      showSecondSelector: true,
                                      context: context,
                                      value: tuesdayEndTime,
                                      onChange: onTuesdayEndTimeChanged,
                                      minuteInterval: TimePickerInterval.FIVE,
                                      // Optional onChange to receive value as DateTime
                                      onChangeDateTime: (DateTime dateTime) {
                                        // print(dateTime);
                                        debugPrint(
                                            "[debug datetime]:  $dateTime");
                                      },
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Chọn giờ",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                        Card(
                          color: (isWednesdayChosen)
                              ? (Theme.of(context).colorScheme.primaryContainer)
                              : (Theme.of(context).colorScheme.onPrimary),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Row(children: [
                                    const Text(
                                      "Thứ 4",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Switch(
                                      value: isWednesdayChosen,
                                      onChanged: (newVal) {
                                        setState(() {
                                          isWednesdayChosen = newVal;
                                        });
                                      },
                                    )
                                  ]),
                                ),
                              ),
                              Text(
                                "${wednesdayStartTime.hour}:${wednesdayStartTime.minute} ${wednesdayStartTime.period.name}"
                                    .toUpperCase(),
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                              const SizedBox(height: 10),
                              TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    showPicker(
                                      showSecondSelector: true,
                                      context: context,
                                      value: wednesdayStartTime,
                                      onChange: onWednesdayStartTimeChanged,
                                      minuteInterval: TimePickerInterval.FIVE,
                                      // Optional onChange to receive value as DateTime
                                      onChangeDateTime: (DateTime dateTime) {
                                        // print(dateTime);
                                        debugPrint(
                                            "[debug datetime]:  $dateTime");
                                      },
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Chọn giờ",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Divider(),
                              const SizedBox(height: 10),
                              Text(
                                "${wednesdayEndTime.hour}:${wednesdayEndTime.minute} ${wednesdayEndTime.period.name}"
                                    .toUpperCase(),
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                              const SizedBox(height: 10),
                              TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    showPicker(
                                      showSecondSelector: true,
                                      context: context,
                                      value: wednesdayEndTime,
                                      onChange: onWednesdayEndTimeChanged,
                                      minuteInterval: TimePickerInterval.FIVE,
                                      // Optional onChange to receive value as DateTime
                                      onChangeDateTime: (DateTime dateTime) {
                                        // print(dateTime);
                                        debugPrint(
                                            "[debug datetime]:  $dateTime");
                                      },
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Chọn giờ",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                        Card(
                          color: (isThursdayChosen)
                              ? (Theme.of(context).colorScheme.primaryContainer)
                              : (Theme.of(context).colorScheme.onPrimary),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Row(children: [
                                    const Text(
                                      "Thứ 5",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Switch(
                                      value: isThursdayChosen,
                                      onChanged: (newVal) {
                                        setState(() {
                                          isThursdayChosen = newVal;
                                        });
                                      },
                                    )
                                  ]),
                                ),
                              ),
                              Text(
                                "${thursdayStartTime.hour}:${thursdayStartTime.minute} ${thursdayStartTime.period.name}"
                                    .toUpperCase(),
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                              const SizedBox(height: 10),
                              TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    showPicker(
                                      showSecondSelector: true,
                                      context: context,
                                      value: thursdayStartTime,
                                      onChange: onThursdayStartTimeChanged,
                                      minuteInterval: TimePickerInterval.FIVE,
                                      // Optional onChange to receive value as DateTime
                                      onChangeDateTime: (DateTime dateTime) {
                                        // print(dateTime);
                                        debugPrint(
                                            "[debug datetime]:  $dateTime");
                                      },
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Chọn giờ",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Divider(),
                              const SizedBox(height: 10),
                              Text(
                                "${thursdayEndTime.hour}:${thursdayEndTime.minute} ${thursdayEndTime.period.name}"
                                    .toUpperCase(),
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                              const SizedBox(height: 10),
                              TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    showPicker(
                                      showSecondSelector: true,
                                      context: context,
                                      value: thursdayEndTime,
                                      onChange: onThursdayEndTimeChanged,
                                      minuteInterval: TimePickerInterval.FIVE,
                                      // Optional onChange to receive value as DateTime
                                      onChangeDateTime: (DateTime dateTime) {
                                        // print(dateTime);
                                        debugPrint(
                                            "[debug datetime]:  $dateTime");
                                      },
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Chọn giờ",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                        Card(
                          color: (isFridayChosen)
                              ? (Theme.of(context).colorScheme.primaryContainer)
                              : (Theme.of(context).colorScheme.onPrimary),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Row(children: [
                                    const Text(
                                      "Thứ 6",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Switch(
                                      value: isFridayChosen,
                                      onChanged: (newVal) {
                                        setState(() {
                                          isFridayChosen = newVal;
                                        });
                                      },
                                    )
                                  ]),
                                ),
                              ),
                              Text(
                                "${fridayStartTime.hour}:${fridayStartTime.minute} ${fridayStartTime.period.name}"
                                    .toUpperCase(),
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                              const SizedBox(height: 10),
                              TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    showPicker(
                                      showSecondSelector: true,
                                      context: context,
                                      value: fridayStartTime,
                                      onChange: onFridayStartTimeChanged,
                                      minuteInterval: TimePickerInterval.FIVE,
                                      // Optional onChange to receive value as DateTime
                                      onChangeDateTime: (DateTime dateTime) {
                                        // print(dateTime);
                                        debugPrint(
                                            "[debug datetime]:  $dateTime");
                                      },
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Chọn giờ",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Divider(),
                              const SizedBox(height: 10),
                              Text(
                                "${fridayEndTime.hour}:${fridayEndTime.minute} ${fridayEndTime.period.name}"
                                    .toUpperCase(),
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                              const SizedBox(height: 10),
                              TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    showPicker(
                                      showSecondSelector: true,
                                      context: context,
                                      value: fridayEndTime,
                                      onChange: onFridayEndTimeChanged,
                                      minuteInterval: TimePickerInterval.FIVE,
                                      // Optional onChange to receive value as DateTime
                                      onChangeDateTime: (DateTime dateTime) {
                                        // print(dateTime);
                                        debugPrint(
                                            "[debug datetime]:  $dateTime");
                                      },
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Chọn giờ",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                        Card(
                          color: (isSaturdayChosen)
                              ? (Theme.of(context).colorScheme.primaryContainer)
                              : (Theme.of(context).colorScheme.onPrimary),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Row(children: [
                                    const Text(
                                      "Thứ 7",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Switch(
                                      value: isSaturdayChosen,
                                      onChanged: (newVal) {
                                        setState(() {
                                          isSaturdayChosen = newVal;
                                        });
                                      },
                                    )
                                  ]),
                                ),
                              ),
                              Text(
                                "${saturdayStartTime.hour}:${saturdayStartTime.minute} ${saturdayStartTime.period.name}"
                                    .toUpperCase(),
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                              const SizedBox(height: 10),
                              TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    showPicker(
                                      showSecondSelector: true,
                                      context: context,
                                      value: saturdayStartTime,
                                      onChange: onSaturdayStartTimeChanged,
                                      minuteInterval: TimePickerInterval.FIVE,
                                      // Optional onChange to receive value as DateTime
                                      onChangeDateTime: (DateTime dateTime) {
                                        // print(dateTime);
                                        debugPrint(
                                            "[debug datetime]:  $dateTime");
                                      },
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Chọn giờ",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Divider(),
                              const SizedBox(height: 10),
                              Text(
                                "${saturdayEndTime.hour}:${saturdayEndTime.minute} ${saturdayEndTime.period.name}"
                                    .toUpperCase(),
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                              const SizedBox(height: 10),
                              TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    showPicker(
                                      showSecondSelector: true,
                                      context: context,
                                      value: saturdayEndTime,
                                      onChange: onSaturdayEndTimeChanged,
                                      minuteInterval: TimePickerInterval.FIVE,
                                      // Optional onChange to receive value as DateTime
                                      onChangeDateTime: (DateTime dateTime) {
                                        // print(dateTime);
                                        debugPrint(
                                            "[debug datetime]:  $dateTime");
                                      },
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Chọn giờ",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                        Card(
                          color: (isSundayChosen)
                              ? (Theme.of(context).colorScheme.primaryContainer)
                              : (Theme.of(context).colorScheme.onPrimary),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Row(children: [
                                    const Text(
                                      "Chủ nhật",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Switch(
                                      value: isSundayChosen,
                                      onChanged: (newVal) {
                                        setState(() {
                                          isSundayChosen = newVal;
                                        });
                                      },
                                    )
                                  ]),
                                ),
                              ),
                              Text(
                                "${sundayStartTime.hour}:${sundayStartTime.minute} ${sundayStartTime.period.name}"
                                    .toUpperCase(),
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                              const SizedBox(height: 10),
                              TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    showPicker(
                                      showSecondSelector: true,
                                      context: context,
                                      value: sundayStartTime,
                                      onChange: onSundayStartTimeChanged,
                                      minuteInterval: TimePickerInterval.FIVE,
                                      // Optional onChange to receive value as DateTime
                                      onChangeDateTime: (DateTime dateTime) {
                                        // print(dateTime);
                                        debugPrint(
                                            "[debug datetime]:  $dateTime");
                                      },
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Chọn giờ",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Divider(),
                              const SizedBox(height: 10),
                              Text(
                                "${sundayEndTime.hour}:${sundayEndTime.minute} ${sundayEndTime.period.name}"
                                    .toUpperCase(),
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                              const SizedBox(height: 10),
                              TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    showPicker(
                                      showSecondSelector: true,
                                      context: context,
                                      value: sundayEndTime,
                                      onChange: onSundayEndTimeChanged,
                                      minuteInterval: TimePickerInterval.FIVE,
                                      // Optional onChange to receive value as DateTime
                                      onChangeDateTime: (DateTime dateTime) {
                                        // print(dateTime);
                                        debugPrint(
                                            "[debug datetime]:  $dateTime");
                                      },
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Chọn giờ",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Center(
                child: OutlinedButton(
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
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    TeachSchedules schedules = TeachSchedules();
                                    if (isMondayChosen) {
                                      schedules.monday = Period(
                                          startTime: mondayStartTime.toString(),
                                          endTime: mondayEndTime.toString());
                                    }
                                    if (isTuesdayChosen) {
                                      schedules.tuesday = Period(
                                          startTime:
                                              tuesdayStartTime.toString(),
                                          endTime: tuesdayEndTime.toString());
                                    }
                                    if (isWednesdayChosen) {
                                      schedules.wednesday = Period(
                                          startTime:
                                              wednesdayStartTime.toString(),
                                          endTime: wednesdayEndTime.toString());
                                    }
                                    if (isThursdayChosen) {
                                      schedules.thursday = Period(
                                          startTime:
                                              thursdayStartTime.toString(),
                                          endTime: thursdayEndTime.toString());
                                    }
                                    if (isFridayChosen) {
                                      schedules.friday = Period(
                                          startTime: fridayStartTime.toString(),
                                          endTime: fridayEndTime.toString());
                                    }
                                    if (isSaturdayChosen) {
                                      schedules.saturday = Period(
                                          startTime:
                                              saturdayStartTime.toString(),
                                          endTime: saturdayEndTime.toString());
                                    }
                                    if (isSundayChosen) {
                                      schedules.sunday = Period(
                                          startTime: sundayStartTime.toString(),
                                          endTime: sundayEndTime.toString());
                                    }

                                    model_user.Address address =
                                        model_user.Address(
                                            province: "Hà Nội",
                                            district: "Ứng Hoà",
                                            ward: "Hoà Nam");
                                    // var dateFormated = DateFormat('yyyy-MM-dd').format(pickedDate);
                                    Timestamp startTime = Timestamp.fromDate(
                                        DateTime.parse(
                                            startDateController.text));
                                    Timestamp endTime = Timestamp.fromDate(
                                        DateTime.parse(endDateController.text));

                                    FirestoreService firestoreService =
                                        FirestoreService();
                                    var finalAddress = addressTextController.text +" , " + (dropDownDistrict!.name??'');

                                    firestoreService.addSubjectRequest(widget.tutor.uid!,
                                        initSubject,
                                        initTeachMethod,
                                        schedules,
                                        finalAddress,
                                        startTime,
                                        endTime);
                                    Navigator.pop(context, 'OK');
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          });
                    },
                    child: const Text('Xác nhận')))
          ],
        ),
      ),
    );
  }
}
