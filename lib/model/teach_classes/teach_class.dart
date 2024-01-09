import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datn/model/subject_request/schedules.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../user/teach_schedules.dart';

class TeachClass {
  String? id;
  String? learnerId;
  String? tutorId;
  Timestamp? createdTime;
  Timestamp? startTime;
  Timestamp? endTime;
  String? teachMethod;
  String? subject;
  Schedules? schedules;
  String? address;
  String? state;

  TeachClass(
      {this.id,
      this.learnerId,
      this.tutorId,
      this.subject,
      this.state,
      this.teachMethod,
      this.schedules,
      this.address,
      this.createdTime,
      this.startTime,
      this.endTime,
      });
  TeachClass.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    learnerId = json['learner_id'];
    tutorId = json['tutor_id'];
    subject = json['subject'];
    state = json['state'];
    teachMethod = json['teach_method'];
    schedules = json['schedules'] != null
        ? Schedules.fromJson(json['schedules'])
        : null;
    address = json['address'] != null ? json['address'] : null;
    createdTime = json['created_time'];
    startTime = json['start_time'];
    endTime = json['end_time'];

    print(toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['learner_id'] = learnerId;
    data['tutor_id'] = tutorId;
    data['subject'] = subject;
    data['state'] = state;
    data['teach_method'] = teachMethod;
    data['address'] = address;
    data['created_time'] = createdTime;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    if (schedules != null) {
      data['schedules'] = schedules!.toJson();
    }

    return data;
  }

  static List<LessonSchedules> generateTimetable(
      DateTime startDate, DateTime endDate, WeekSchedules schedule) {
    List<LessonSchedules> timetable = [];
    DateTime currentDate = startDate;
    Map<String, Period> mapSchedules = {};

    if (schedule.monday != null) {
      mapSchedules.addAll({"Monday": schedule.monday!});
    }
    if (schedule.tuesday != null) {
      mapSchedules.addAll({"Tuesday": schedule.tuesday!});
    }
    if (schedule.wednesday != null) {
      mapSchedules.addAll({"Wednesday": schedule.wednesday!});
    }
    if (schedule.thursday != null) {
      mapSchedules.addAll({"Thursday": schedule.thursday!});
    }
    if (schedule.friday != null) {
      mapSchedules.addAll({"Friday": schedule.friday!});
    }
    if (schedule.saturday != null) {
      mapSchedules.addAll({"Saturday": schedule.saturday!});
    }
    if (schedule.sunday != null) {
      mapSchedules.addAll({"Sunday": schedule.sunday!});
    }
    while (currentDate.isBefore(endDate.add(Duration(days: 1)))) {
      String dayOfWeek = DateFormat('EEEE')
          .format(currentDate); // Get the day of the week (e.g., Tuesday)

      if (mapSchedules.containsKey(dayOfWeek)) {
        HourInDay startTime = mapSchedules[dayOfWeek]!.startTime!;
        HourInDay endTime = mapSchedules[dayOfWeek]!.endTime!;

        DateTime startTimeDateTime = DateTime(
          currentDate.year,
          currentDate.month,
          currentDate.day,
          startTime.hour!,
          startTime.minute!,
        );

        DateTime endTimeDateTime = DateTime(
          currentDate.year,
          currentDate.month,
          currentDate.day,
          endTime.hour!,
          endTime.minute!,
        );

        timetable.add(LessonSchedules(
            startTime: Timestamp.fromDate(startTimeDateTime),
            endTime: Timestamp.fromDate(endTimeDateTime)));
      }

      currentDate = currentDate.add(Duration(days: 1)); // Move to the next day
    }

    return timetable;
  }

  static List<LessonSchedules> generateTimetableTimestamp(
      Timestamp startTimestamp,
      Timestamp endTimestamp,
      WeekSchedules schedule) {
    DateTime startDate = DateTime.fromMillisecondsSinceEpoch(
        startTimestamp.millisecondsSinceEpoch);
    DateTime endDate = DateTime.fromMillisecondsSinceEpoch(
        endTimestamp.millisecondsSinceEpoch);
    List<LessonSchedules> timetable = [];
    DateTime currentDate = startDate;
    Map<String, Period> mapSchedules = {};

    if (schedule.monday != null) {
      mapSchedules.addAll({"Monday": schedule.monday!});
    }
    if (schedule.tuesday != null) {
      mapSchedules.addAll({"Tuesday": schedule.tuesday!});
    }
    if (schedule.wednesday != null) {
      mapSchedules.addAll({"Wednesday": schedule.wednesday!});
    }
    if (schedule.thursday != null) {
      mapSchedules.addAll({"Thursday": schedule.thursday!});
    }
    if (schedule.friday != null) {
      mapSchedules.addAll({"Friday": schedule.friday!});
    }
    if (schedule.saturday != null) {
      mapSchedules.addAll({"Saturday": schedule.saturday!});
    }
    if (schedule.sunday != null) {
      mapSchedules.addAll({"Sunday": schedule.sunday!});
    }
    while (currentDate.isBefore(endDate.add(Duration(days: 1)))) {
      String dayOfWeek = DateFormat('EEEE')
          .format(currentDate); // Get the day of the week (e.g., Tuesday)

      if (mapSchedules.containsKey(dayOfWeek)) {
        HourInDay startTime = mapSchedules[dayOfWeek]!.startTime!;
        HourInDay endTime = mapSchedules[dayOfWeek]!.endTime!;

        DateTime startTimeDateTime = DateTime(
          currentDate.year,
          currentDate.month,
          currentDate.day,
          startTime.hour!,
          startTime.minute!,
        );

        DateTime endTimeDateTime = DateTime(
          currentDate.year,
          currentDate.month,
          currentDate.day,
          endTime.hour!,
          endTime.minute!,
        );

        timetable.add(LessonSchedules(
            startTime: Timestamp.fromDate(startTimeDateTime),
            endTime: Timestamp.fromDate(endTimeDateTime)));
      }

      currentDate = currentDate.add(Duration(days: 1)); // Move to the next day
    }

    return timetable;
  }

  @override
  String toString() {
    return 'TeachClass{id: $id, learnerId: $learnerId, tutorId: $tutorId, createdTime: $createdTime, startTime: $startTime, endTime: $endTime, teachMethod: $teachMethod, subject: $subject, schedules: $schedules, address: $address, state: $state}';
  }

}
