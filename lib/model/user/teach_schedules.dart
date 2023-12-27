import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:day_night_time_picker/lib/state/time.dart';

class WeekSchedules {
  Period? sunday;
  Period? saturday;
  Period? tuesday;
  Period? friday;
  Period? thursday;
  Period? wednesday;
  Period? monday;

  WeekSchedules(
      {this.sunday,
      this.saturday,
      this.tuesday,
      this.friday,
      this.thursday,
      this.wednesday,
      this.monday});

  WeekSchedules.fromJson(Map<String, dynamic> json) {
    monday = json['monday'] != null ? Period.fromJson(json['monday']) : null;
    tuesday = json['tuesday'] != null ? Period.fromJson(json['tuesday']) : null;
    wednesday =
        json['wednesday'] != null ? Period.fromJson(json['wednesday']) : null;
    thursday =
        json['thursday'] != null ? Period.fromJson(json['thursday']) : null;
    friday = json['friday'] != null ? Period.fromJson(json['friday']) : null;
    saturday =
        json['saturday'] != null ? Period.fromJson(json['saturday']) : null;
    sunday = json['sunday'] != null ? Period.fromJson(json['sunday']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (sunday != null) {
      data['sunday'] = sunday!.toJson();
    }
    if (saturday != null) {
      data['saturday'] = saturday!.toJson();
    }
    if (tuesday != null) {
      data['tuesday'] = tuesday!.toJson();
    }
    if (friday != null) {
      data['friday'] = friday!.toJson();
    }
    if (thursday != null) {
      data['thursday'] = thursday!.toJson();
    }
    if (wednesday != null) {
      data['wednesday'] = wednesday!.toJson();
    }
    if (monday != null) {
      data['monday'] = monday!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'WeekSchedules{sunday: $sunday, saturday: $saturday, tuesday: $tuesday, friday: $friday, thursday: $thursday, wednesday: $wednesday, monday: $monday}';
  }
}

class Period {
  HourInDay? startTime;
  HourInDay? endTime;

  Period({this.startTime, this.endTime});

  Period.fromJson(Map<String, dynamic> json) {
    if (json['start_time'] != null) {
      startTime = HourInDay.fromJson(json['start_time']);
    }
    if (json['end_time'] != null) {
      endTime = HourInDay.fromJson(json['end_time']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    if (startTime != null) {
      data['start_time'] = startTime!.toJson();
    }
    if (endTime != null) {
      data['end_time'] = endTime!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'Period{startTime: $startTime, endTime: $endTime}';
  }
}

class HourInDay {
  int? hour;
  int? minute;

  HourInDay({this.hour, this.minute});

  HourInDay.fromTime(Time time) {
    this.hour = time.hour;
    this.minute = time.minute;
  }

  HourInDay.fromJson(Map<String, dynamic> json) {
    hour = json['hour'];
    minute = json['minute'];
  }
  String format(){
    if(hour==null || minute == null){
      return '';
    }

    String hourString='';
    String minuteString = '';
    if(hour!<10){
      hourString = "0$hour";
    }else{
      hourString = hour.toString();
    }
    if(minute!<10){
      minuteString = "0$minute";
    }else{
      minuteString = minute.toString();
    }
    return "$hourString : $minuteString";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['hour'] = hour;
    data['minute'] = minute;
    return data;
  }

  @override
  String toString() {
    return 'HourInDay{hour: $hour, minute: $minute}';
  }
}

class LessonSchedules {
  Timestamp? startTime;
  Timestamp? endTime;
  Timestamp? attendanceTime;
  String? state;

  LessonSchedules(
      {this.startTime, this.endTime, this.attendanceTime, this.state});

  LessonSchedules.fromJson(Map<String, dynamic> json) {
    startTime = json['start_time'] != null ? (json['start_time']) : null;
    endTime = json['end_time'] != null ? (json['end_time']) : null;
    attendanceTime =
        json['attendance_time'] != null ? (json['attendance_time']) : null;
    state = json['state'] != null ? (json['state']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['attendance_time'] = attendanceTime;
    data['state'] = state;
    return data;
  }

  @override
  String toString() {
    return 'LessonSchedules{startTime: $startTime, endTime: $endTime, attendanceTime: $attendanceTime, state: $state}';
  }
}
