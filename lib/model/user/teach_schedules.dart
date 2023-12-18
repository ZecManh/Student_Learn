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
    json['monday'] != null ? new Period.fromJson(json['monday']) : null;
    tuesday =
    json['tuesday'] != null ? new Period.fromJson(json['tuesday']) : null;
    wednesday =
    json['wednesday'] != null ? new Period.fromJson(json['wednesday']) : null;
    thursday =
    json['thursday'] != null ? new Period.fromJson(json['thursday']) : null;
    friday =
    json['friday'] != null ? new Period.fromJson(json['friday']) : null;
    saturday = json['saturday'] != null
        ? new Period.fromJson(json['saturday'])
        : null;
    sunday =
    json['sunday'] != null ? new Period.fromJson(json['sunday']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sunday != null) {
      data['sunday'] = this.sunday!.toJson();
    }
    if (this.saturday != null) {
      data['saturday'] = this.saturday!.toJson();
    }
    if (this.tuesday != null) {
      data['tuesday'] = this.tuesday!.toJson();
    }
    if (this.friday != null) {
      data['friday'] = this.friday!.toJson();
    }
    if (this.thursday != null) {
      data['thursday'] = this.thursday!.toJson();
    }
    if (this.wednesday != null) {
      data['wednesday'] = this.wednesday!.toJson();
    }
    if (this.monday != null) {
      data['monday'] = this.monday!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    return data;
  }

  @override
  String toString() {
    return 'Period{startTime: $startTime, endTime: $endTime}';
  }
}