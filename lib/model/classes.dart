import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datn/model/subject_request/schedules.dart';


class TeachClass {
  String? learnerId;
  String? tutorId;
  Timestamp? createdTime;
  Timestamp? startTime;
  Timestamp? endTime;
  String? subject;
  String? state;
  String? teachMethod;
  Schedules? schedules;
  String? address;


  TeachClass(
      {this.learnerId,
        this.tutorId,
        this.subject,
        this.state,
        this.teachMethod,
        this.schedules,
        this.address,
        this.createdTime,
        this.startTime,
        this.endTime});


  TeachClass.fromJson(Map<String, dynamic> json) {
    learnerId = json['learner_id'];
    tutorId = json['tutor_id'];
    subject = json['subject'];
    state = json['state'];
    teachMethod = json['teach_method'];
    schedules = json['schedules'] != null ? Schedules.fromJson(json['schedules']) : null;
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
    if (schedules != null) {
      data['schedules'] = schedules!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'SubjectRequest{learnerId: $learnerId, tutorId: $tutorId, subject: $subject, state: $state, teachMethod: $teachMethod, schedules: $schedules, address: $address, createdTime: $createdTime, startTime: $startTime, endTime: $endTime}';
  }
}
