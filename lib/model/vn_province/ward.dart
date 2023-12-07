class Wards {
  String? name;
  int? code;
  String? divisionType;
  String? codename;
  int? districtCode;

  Wards(
      {this.name,
        this.code,
        this.divisionType,
        this.codename,
        this.districtCode});

  Wards.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
    divisionType = json['division_type'];
    codename = json['codename'];
    districtCode = json['district_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['code'] = code;
    data['division_type'] = divisionType;
    data['codename'] = codename;
    data['district_code'] = districtCode;
    return data;
  }
}