import 'package:datn/model/user/teach_schedules.dart';

class Schedules {
  TeachSchedules? weekSchedules;
  List<LessonSchedules>? lessonSchedules = [];

  Schedules({this.weekSchedules, this.lessonSchedules});

  Schedules.fromJson(Map<String, dynamic> json) {
    weekSchedules = json['week_schedules'] != null
        ? TeachSchedules.fromJson(json['week_schedules'])
        : null;
    // lessonSchedules =(json['lesson_schedules'] != null) ? json['lesson_schedules'].cast<LessonSchedules>() : null;
    if (json['lesson_schedules'] != null) {
      var jsonArray = json['lesson_schedules'] as List<dynamic>;
      jsonArray.forEach((element) {
        lessonSchedules!.add(LessonSchedules.fromJson(element));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (weekSchedules != null) {
      data['week_schedules'] = weekSchedules!.toJson();
    }

    if (lessonSchedules != null) {
      List<Map<String, dynamic>> listSchedules = [];
      lessonSchedules!.forEach((element) {
        listSchedules.add(element.toJson());
      });
      data['lesson_schedules'] = listSchedules;
    }
    ;
    print("DATA  ${data['lesson_schedules']} ");
    return data;
  }

  @override
  String toString() {
    return 'Schedules{weekSchedules: $weekSchedules, lessonSchedules: $lessonSchedules}';
  }
}
