class TeachSchedules {
  List<Period>? monday;
  List<Period>? tuesday;
  List<Period>? wednesday;
  List<Period>? thursday;
  List<Period>? friday;
  List<Period>? saturday;
  List<Period>? sunday;

  TeachSchedules(
      {this.monday,
        this.tuesday,
        this.wednesday,
        this.thursday,
        this.friday,
        this.saturday,
        this.sunday});

  TeachSchedules.fromJson(Map<String, dynamic> json) {
    if (json['monday'] != null) {
      monday = <Period>[];
      json['monday'].forEach((v) {
        monday!.add(Period.fromJson(v));
      });
    }
    if (json['tuesday'] != null) {
      tuesday = <Period>[];
      json['tuesday'].forEach((v) {
        tuesday!.add( Period.fromJson(v));
      });
    }
    if (json['wednesday'] != null) {
      wednesday = <Period>[];
      json['wednesday'].forEach((v) {
        wednesday!.add( Period.fromJson(v));
      });
    }
    if (json['thursday'] != null) {
      thursday = <Period>[];
      json['thursday'].forEach((v) {
        thursday!.add( Period.fromJson(v));
      });
    }
    if (json['friday'] != null) {
      friday = <Period>[];
      json['friday'].forEach((v) {
        friday!.add( Period.fromJson(v));
      });
    }
    if (json['saturday'] != null) {
      saturday = <Period>[];
      json['saturday'].forEach((v) {
        saturday!.add( Period.fromJson(v));
      });
    }
    if (json['sunday'] != null) {
      sunday = <Period>[];
      json['sunday'].forEach((v) {
        sunday!.add( Period.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.monday != null) {
      data['monday'] = this.monday!.map((v) => v.toJson()).toList();
    }
    if (this.tuesday != null) {
      data['tuesday'] = this.tuesday!.map((v) => v.toJson()).toList();
    }
    if (this.wednesday != null) {
      data['wednesday'] = this.wednesday!.map((v) => v.toJson()).toList();
    }
    if (this.thursday != null) {
      data['thursday'] = this.thursday!.map((v) => v.toJson()).toList();
    }
    if (this.friday != null) {
      data['friday'] = this.friday!.map((v) => v.toJson()).toList();
    }
    if (this.saturday != null) {
      data['saturday'] = this.saturday!.map((v) => v.toJson()).toList();
    }
    if (this.sunday != null) {
      data['sunday'] = this.sunday!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'TeachSchedules{monday: $monday, tuesday: $tuesday, wednesday: $wednesday, thursday: $thursday, friday: $friday, saturday: $saturday, sunday: $sunday}';
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