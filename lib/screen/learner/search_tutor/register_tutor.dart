import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datn/database/firestore/firestore_service.dart';
import 'package:datn/model/subject_request/schedules.dart';
import 'package:datn/model/teach_classes/teach_class.dart';
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

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  Map<String, Map<String, TimeOfDay>> studySchedule = {};

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

  DateTime mondayStartDateTime = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0, 0);
  DateTime mondayEndDateTime = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0, 0);
  DateTime tuesdayStartDateTime = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0, 0);
  DateTime tuesdayEndDateTime = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0, 0);
  DateTime wednesdayStartDateTime = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0, 0);
  DateTime wednesdayEndDateTime = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0, 0);
  DateTime thursdayStartDateTime = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0, 0);
  DateTime thursdayEndDateTime = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0, 0);
  DateTime fridayStartDateTime = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0, 0);
  DateTime fridayEndDateTime = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0, 0);
  DateTime saturdayStartDateTime = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0, 0);
  DateTime saturdayEndDateTime = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0, 0);
  DateTime sundayStartDateTime = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0, 0);
  DateTime sundayEndDateTime = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0, 0);

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

  bool checkTime() {
    if (isMondayChosen) {
      if (!mondayStartDateTime.isBefore(mondayEndDateTime)) {
        return false;
      }
    }
    if (isTuesdayChosen) {
      if (!tuesdayStartDateTime.isBefore(tuesdayEndDateTime)) {
        return false;
      }
    }
    if (isWednesdayChosen) {
      if (!wednesdayStartDateTime.isBefore(wednesdayEndDateTime)) {
        return false;
      }
    }
    if (isThursdayChosen) {
      if (!thursdayStartDateTime.isBefore(thursdayEndDateTime)) {
        return false;
      }
    }
    if (isFridayChosen) {
      if (!fridayStartDateTime.isBefore(fridayEndDateTime)) {
        return false;
      }
    }
    if (isSaturdayChosen) {
      if (!saturdayStartDateTime.isBefore(saturdayEndDateTime)) {
        return false;
      }
    }
    if (isSundayChosen) {
      print("sundayStartDateTime ${sundayStartDateTime.toString()}");
      print("sundayEndDateTime ${sundayEndDateTime.toString()}");

      if (!sundayStartDateTime.isBefore(sundayEndDateTime)) {
        return false;
      }
    }
    return true;
  }

  bool checkLesson() {
    LessonSchedules lessonSchedules = LessonSchedules();
    Map<String, Map<String, TimeOfDay>> studySchedule = {};
    if (isMondayChosen) {
      studySchedule["Monday"] = {
        'startTime': mondayStartTime,
        'endTime': mondayEndTime
      };
    }
    if (isTuesdayChosen) {
      studySchedule["Tuesday"] = {
        'startTime': tuesdayStartTime,
        'endTime': tuesdayEndTime
      };
    }
    if (isWednesdayChosen) {
      studySchedule["Wednesday"] = {
        'startTime': wednesdayStartTime,
        'endTime': wednesdayEndTime
      };
    }
    if (isThursdayChosen) {
      studySchedule["Thursday"] = {
        'startTime': thursdayStartTime,
        'endTime': thursdayEndTime
      };
    }
    if (isFridayChosen) {
      studySchedule["Friday"] = {
        'startTime': fridayStartTime,
        'endTime': fridayEndTime
      };
    }
    if (isSaturdayChosen) {
      studySchedule["Saturday"] = {
        'startTime': saturdayStartTime,
        'endTime': saturdayEndTime
      };
    }
    if (isSundayChosen) {
      studySchedule["Sunday"] = {
        'startTime': sundayStartTime,
        'endTime': sundayEndTime
      };
    }

    List<LessonSchedules> timetable =
        generateTimetable(startDate, endDate, studySchedule);
    print("TEST TIME TABLE");
    print("START DATE ${startDate}");
    print("END DATE ${endDate}");
    timetable.forEach((element) {
      print(
          "Start time ${DateTime.fromMillisecondsSinceEpoch(element.startTime!.millisecondsSinceEpoch)}");
      print(
          "End time ${DateTime.fromMillisecondsSinceEpoch(element.endTime!.millisecondsSinceEpoch)}");
    });
    if (timetable.length > 0) {
      return true;
    }
    return false;
  }

  String convertTime(Time time) {
    String timeString = "";
    int hour = time.hour;
    int minute = time.minute;
    timeString += hour.toString() + " : ";
    if (minute == 0) {
      timeString += "00";
    } else {
      timeString += minute.toString();
    }
    return timeString;
  }

  List<LessonSchedules> generateTimetable(DateTime startDate, DateTime endDate,
      Map<String, Map<String, TimeOfDay>> schedule) {
    List<LessonSchedules> timetable = [];
    DateTime currentDate = startDate;

    // print("START GENERATE TIMETABLE")
    // while (currentDate.isBefore(endDate.add(Duration(days: 1)))) {
    while (currentDate.isBefore(endDate)) {
      String dayOfWeek = DateFormat('EEEE')
          .format(currentDate); // Get the day of the week (e.g., Tuesday)

      if (schedule.containsKey(dayOfWeek)) {
        TimeOfDay startTime = schedule[dayOfWeek]!['startTime']!;
        TimeOfDay endTime = schedule[dayOfWeek]!['endTime']!;

        DateTime startTimeDateTime = DateTime(
          currentDate.year,
          currentDate.month,
          currentDate.day,
          startTime.hour,
          startTime.minute,
        );

        DateTime endTimeDateTime = DateTime(
          currentDate.year,
          currentDate.month,
          currentDate.day,
          endTime.hour,
          endTime.minute,
        );

        // while (startTimeDateTime.isBefore(endTimeDateTime)) {
        //  var endTime = startTimeDateTime.add(Duration(hours: endTimeDateTime.hour,minutes: endTimeDateTime.minute));
        //  timetable.add([startTimeDateTime,endTime]);
        //
        // }

        // timetable.add([startTimeDateTime, endTimeDateTime]);
        timetable.add(LessonSchedules(
            startTime: Timestamp.fromDate(startTimeDateTime),
            endTime: Timestamp.fromDate(endTimeDateTime)));
      }

      currentDate = currentDate.add(Duration(days: 1)); // Move to the next day
    }

    return timetable;
  }

  void onMondayStartTimeChanged(Time newTime) {
    setState(() {
      mondayStartTime = newTime;
      // mondayStartTime = Time(hour: newTime.hour,minute: newTime.minute);
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
                  const SizedBox(
                    height: 20,
                  ),
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
                                startDate = pickedDate;
                                print("START DATE " + startDate.toString());

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
                                pickedDate = DateTime(
                                    pickedDate.year,
                                    pickedDate.month,
                                    pickedDate.day,
                                    23,
                                    59,
                                    59);
                                endDate = pickedDate;
                                print("END DATE " + endDate.toString());
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
                                          if (isMondayChosen == false) {
                                            var deleteData =
                                                studySchedule.remove('Monday');
                                            mondayStartTime = Time(
                                                hour: 0, minute: 0, second: 0);
                                            mondayEndTime = Time(
                                                hour: 0, minute: 0, second: 0);
                                          }
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
                                        mondayStartDateTime = dateTime;
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
                                        mondayEndDateTime = dateTime;
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
                                          if (isTuesdayChosen == false) {
                                            studySchedule.remove('Tuesday');
                                            tuesdayStartTime = Time(
                                                hour: 0, minute: 0, second: 0);
                                            tuesdayEndTime = Time(
                                                hour: 0, minute: 0, second: 0);
                                          }
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
                                        tuesdayStartDateTime = dateTime;
                                        print(dateTime);
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
                                        tuesdayEndDateTime = dateTime;
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
                                          if (isWednesdayChosen == false) {
                                            studySchedule.remove('Wednesday');
                                            wednesdayStartTime = Time(
                                                hour: 0, minute: 0, second: 0);
                                            wednesdayEndTime = Time(
                                                hour: 0, minute: 0, second: 0);
                                          }
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
                                        wednesdayStartDateTime = dateTime;
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
                                        wednesdayEndDateTime = dateTime;

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
                                          print("Is isThursdayChosen $newVal");
                                          if (isThursdayChosen == false) {
                                            studySchedule.remove('Thursday');
                                            thursdayStartTime = Time(
                                                hour: 0, minute: 0, second: 0);
                                            thursdayEndTime = Time(
                                                hour: 0, minute: 0, second: 0);
                                          }
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
                                        thursdayStartDateTime = dateTime;
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
                                        thursdayEndDateTime = dateTime;

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
                                          if (isFridayChosen == false) {
                                            studySchedule.remove('Friday');
                                            fridayStartTime = Time(
                                                hour: 0, minute: 0, second: 0);
                                            fridayEndTime = Time(
                                                hour: 0, minute: 0, second: 0);
                                          }
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
                                        fridayStartDateTime = dateTime;
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
                                        fridayEndDateTime = dateTime;

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
                                          if (isSaturdayChosen == false) {
                                            studySchedule.remove('Saturday');
                                            saturdayStartTime = Time(
                                                hour: 0, minute: 0, second: 0);
                                            saturdayEndTime = Time(
                                                hour: 0, minute: 0, second: 0);
                                          }
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
                                        saturdayStartDateTime = dateTime;
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
                                        saturdayEndDateTime = dateTime;

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
                                          if (isSundayChosen == false) {
                                            studySchedule.remove('Sunday');
                                            sundayStartTime = Time(
                                                hour: 0, minute: 0, second: 0);
                                            sundayEndTime = Time(
                                                hour: 0, minute: 0, second: 0);
                                          }
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
                                        sundayStartDateTime = dateTime;
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
                                        sundayEndDateTime = dateTime;
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


                      if (startDateController.text != "" &&
                          startDateController.text != null &&
                          endDateController.text != "" &&
                          endDateController.text != null &&
                          startDate.isBefore(endDate) &&
                          checkTime() == true &&
                          checkLesson() == true) {
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
                                      WeekSchedules weekSchedules =
                                          WeekSchedules();
                                      LessonSchedules lessonSchedules =
                                          LessonSchedules();
                                      if (isMondayChosen) {
                                        studySchedule["Monday"] = {
                                          'startTime': mondayStartTime,
                                          'endTime': mondayEndTime
                                        };
                                        weekSchedules.monday = Period(
                                            startTime: HourInDay.fromTime(
                                                mondayStartTime),
                                            endTime: HourInDay.fromTime(
                                                mondayEndTime));
                                      }
                                      if (isTuesdayChosen) {
                                        studySchedule["Tuesday"] = {
                                          'startTime': tuesdayStartTime,
                                          'endTime': tuesdayEndTime
                                        };
                                        weekSchedules.tuesday = Period(
                                            startTime: HourInDay.fromTime(
                                                tuesdayStartTime),
                                            endTime: HourInDay.fromTime(
                                                tuesdayEndTime));
                                      }
                                      if (isWednesdayChosen) {
                                        studySchedule["Wednesday"] = {
                                          'startTime': wednesdayStartTime,
                                          'endTime': wednesdayEndTime
                                        };
                                        weekSchedules.wednesday = Period(
                                            startTime: HourInDay.fromTime(
                                                wednesdayStartTime),
                                            endTime: HourInDay.fromTime(
                                                wednesdayEndTime));
                                      }
                                      if (isThursdayChosen) {
                                        studySchedule["Thursday"] = {
                                          'startTime': thursdayStartTime,
                                          'endTime': thursdayEndTime
                                        };
                                        weekSchedules.thursday = Period(
                                            startTime: HourInDay.fromTime(
                                                thursdayStartTime),
                                            endTime: HourInDay.fromTime(
                                                thursdayEndTime));
                                      }
                                      if (isFridayChosen) {
                                        studySchedule["Friday"] = {
                                          'startTime': fridayStartTime,
                                          'endTime': fridayEndTime
                                        };
                                        weekSchedules.friday = Period(
                                            startTime: HourInDay.fromTime(
                                                fridayStartTime),
                                            endTime: HourInDay.fromTime(
                                                fridayEndTime));
                                      }
                                      if (isSaturdayChosen) {
                                        studySchedule["Saturday"] = {
                                          'startTime': saturdayStartTime,
                                          'endTime': saturdayEndTime
                                        };
                                        weekSchedules.saturday = Period(
                                            startTime: HourInDay.fromTime(
                                                saturdayStartTime),
                                            endTime: HourInDay.fromTime(
                                                saturdayEndTime));
                                      }
                                      if (isSundayChosen) {
                                        studySchedule["Sunday"] = {
                                          'startTime': sundayStartTime,
                                          'endTime': sundayEndTime
                                        };
                                        weekSchedules.sunday = Period(
                                            startTime: HourInDay.fromTime(
                                                sundayStartTime),
                                            endTime: HourInDay.fromTime(
                                                sundayEndTime));
                                      }
                                      studySchedule.forEach((key, value) {
                                        print("KEY ${key.toString()}");
                                        print("VALUE ${value.toString()}");
                                      });
                                      List<LessonSchedules> timetable =
                                          generateTimetable(startDate, endDate,
                                              studySchedule);
                                      studySchedule.forEach((key, value) {
                                        print(key + value.toString());
                                      });
                                      timetable.forEach((element) {
                                        print(element.toString());
                                      });

                                      Schedules schedules = Schedules(
                                          lessonSchedules: timetable,
                                          weekSchedules: weekSchedules);

                                      // var dateFormated = DateFormat('yyyy-MM-dd').format(pickedDate);
                                      Timestamp startTime = Timestamp.fromDate(
                                          DateTime.parse(
                                              startDateController.text));
                                      Timestamp endTime = Timestamp.fromDate(
                                          DateTime.parse(
                                              endDateController.text));

                                      FirestoreService firestoreService =
                                          FirestoreService();
                                      var finalAddress =
                                          (addressTextController.text != '')
                                              ? addressTextController.text +
                                                  " , " +
                                                  (dropDownDistrict!.name ?? '')
                                              : (dropDownDistrict!.name ?? '');
                                      var list = TeachClass.generateTimetable(
                                          startDate, endDate, weekSchedules);
                                      print("LESSON SCHEDULES");
                                      list.forEach((element) {
                                        print(element.toString());
                                      });
                                      var myTimestamp = Timestamp.now();
                                      var myDateTime =
                                          DateTime.fromMillisecondsSinceEpoch(
                                              myTimestamp
                                                  .millisecondsSinceEpoch);
                                      print(
                                          "MY DATE TIME ${myDateTime.toString()}");
                                      firestoreService.addSubjectRequest(
                                          widget.tutor.uid!,
                                          initSubject,
                                          initTeachMethod,
                                          weekSchedules,
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
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Vui lòng kiểm tra ngày giờ"),
                        ));
                      }
                    },
                    child: const Text('Xác nhận')))
          ],
        ),
      ),
    );
  }
}
