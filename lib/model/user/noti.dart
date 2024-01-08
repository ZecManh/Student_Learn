import 'package:cloud_firestore/cloud_firestore.dart';

class UserNotification {
  String? id;
  Timestamp? createdTime;
  String? title;
  String? state;

  UserNotification({this.createdTime, this.title, this.state});

  UserNotification.fromJson(Map<String, dynamic> json) {
    id = json['id'] != null ? (json['id']) : null;
    createdTime = json['created_time'] != null ? (json['created_time']) : null;
    title = json['title'] != null ? (json['title']) : null;
    state = json['state'] != null ? (json['state']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_time'] = createdTime;
    data['title'] = title;
    data['id'] = id;
    data['state'] = state;
    return data;
  }

  @override
  String toString() {
    return 'UserNotification{id: $id, createdTime: $createdTime, title: $title, state: $state}';
  }
}
