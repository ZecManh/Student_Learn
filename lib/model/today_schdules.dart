import 'package:datn/model/user/user.dart';

class TodaySchedules {
  TodaySchedules(
      {required this.startTime,
      required this.endTime,
      required this.subject,
      required this.teachMethod});

  DateTime startTime;
  DateTime endTime;
  String subject;
  Address? address;
  String teachMethod;

  @override
  String toString() {
    return 'TodaySchedules{startTime: $startTime, endTime: $endTime, subject: $subject, address: $address, teachMethod: $teachMethod}';
  }
}
