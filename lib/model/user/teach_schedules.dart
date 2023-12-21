class TeachSchedules {
  Period? sunday;
  Period? saturday;
  Period? tuesday;
  Period? friday;
  Period? thursday;
  Period? wednesday;
  Period? monday;

  TeachSchedules(
      {this.sunday,
        this.saturday,
        this.tuesday,
        this.friday,
        this.thursday,
        this.wednesday,
        this.monday});

  TeachSchedules.fromJson(Map<String, dynamic> json) {
    monday =
    json['monday'] != null ? Period.fromJson(json['monday']) : null;
    tuesday =
    json['tuesday'] != null ? Period.fromJson(json['tuesday']) : null;
    wednesday =
    json['wednesday'] != null ? Period.fromJson(json['wednesday']) : null;
    thursday =
    json['thursday'] != null ? Period.fromJson(json['thursday']) : null;
    friday =
    json['friday'] != null ? Period.fromJson(json['friday']) : null;
    saturday = json['saturday'] != null
        ? Period.fromJson(json['saturday'])
        : null;
    sunday =
    json['sunday'] != null ? Period.fromJson(json['sunday']) : null;
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
    return 'TeachSchedules{sunday: $sunday, saturday: $saturday, tuesday: $tuesday, friday: $friday, thursday: $thursday, wednesday: $wednesday, monday: $monday}';
  }
}

class Period {
  String? startTime;
  String? endTime;

  Period({this.startTime, this.endTime});

  Period.fromJson(Map<String, dynamic> json) {
    startTime = json['start_time'];
    endTime = json['end_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    return data;
  }

  @override
  String toString() {
    return 'Period{startTime: $startTime, endTime: $endTime}';
  }
}