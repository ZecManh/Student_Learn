import 'package:cloud_firestore/cloud_firestore.dart';
import '../user/teach_schedules.dart';


class SubjectRequest {
  String? learnerId;
  String? tutorId;
  String? subject;
  String? state;
  String? teachMethod;
  WeekSchedules? weekSchedules;
  String? address;
  Timestamp? createdTime;
  Timestamp? startTime;
  Timestamp? endTime;

  SubjectRequest(
      {this.learnerId,
      this.tutorId,
      this.subject,
      this.state,
      this.teachMethod,
      this.weekSchedules,
      this.address,
      this.createdTime,
      this.startTime,
      this.endTime});


  SubjectRequest.fromJson(Map<String, dynamic> json) {
    learnerId = json['learner_id'];
    tutorId = json['tutor_id'];
    subject = json['subject'];
    state = json['state'];
    teachMethod = json['teach_method'];
    weekSchedules = json['week_schedules'] != null ? WeekSchedules.fromJson(json['week_schedules']) : null;
    address = json['address'] != null ? json['address'] : null;
    createdTime = json['created_time'];
    startTime = json['start_time'];
    endTime = json['end_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['learner_id'] = learnerId;
    data['tutor_id'] = tutorId;
    data['subject'] = subject;
    data['state'] = state;
    data['teach_method'] = teachMethod;
    data['address'] = address;
    data['created_time'] = createdTime;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    if (weekSchedules != null) {
      data['week_schedules'] = weekSchedules!.toJson();
    }
    return data;
  }

  @override
  String toString() {

    return 'SubjectRequest{learnerId: $learnerId, tutorId: $tutorId, subject: $subject, state: $state, teachMethod: $teachMethod, weekSchedules: $weekSchedules, address: $address, createdTime: $createdTime, startTime: $startTime, endTime: $endTime}';

  }

}
