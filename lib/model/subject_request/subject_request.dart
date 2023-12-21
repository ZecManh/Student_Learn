import 'package:cloud_firestore/cloud_firestore.dart';

import '../user/teach_schedules.dart';
import '../user/user.dart';

class SubjectRequest {
  String? learnerId;
  String? subject;
  String? state;
  String? teachMethod;
  TeachSchedules? schedules;
  String? address;
  Timestamp? createdTime;
  Timestamp? startTime;
  Timestamp? endTime;

  SubjectRequest(
      {this.learnerId,
      this.subject,
      this.state,
      this.teachMethod,
      this.schedules,
      this.address,
      this.createdTime,
      this.startTime,
      this.endTime});

  SubjectRequest.fromJson(Map<String, dynamic> json) {
    learnerId = json['learner_id'];
    subject = json['subject'];
    state = json['state'];
    teachMethod = json['teach_method'];
    schedules = (json['schedules'] != null)
        ? TeachSchedules.fromJson(json['schedules'])
        : null;
    address = json['address'] != null ? json['address'] : null;
    createdTime = json['created_time'];
    startTime = json['start_time'];
    endTime = json['end_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['learner_id'] = learnerId;
    data['subject'] = subject;
    data['state'] = state;
    data['teach_method'] = teachMethod;
    data['teach_schedules'] = (schedules != null) ? schedules!.toJson() : null;
    data['address'] = address;
    data['created_time'] = createdTime;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    return data;
  }

  @override
  String toString() {
    return 'SubjectRequest{learnerId: $learnerId, subject: $subject, state: $state, teachMethod: $teachMethod, schedules: $schedules, address: $address, createdTime: $createdTime, startTime: $startTime, endTime: $endTime}';
  }
}
