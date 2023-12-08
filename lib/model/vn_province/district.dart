import 'package:datn/model/vn_province/ward.dart';

class Districts {
  String? name;
  int? code;
  String? divisionType;
  String? codename;
  int? provinceCode;
  List<Wards>? wards;

  Districts(
      {this.name,
        this.code,
        this.divisionType,
        this.codename,
        this.provinceCode,
        this.wards});

  Districts.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
    divisionType = json['division_type'];
    codename = json['codename'];
    provinceCode = json['province_code'];
    if (json['wards'] != null) {
      wards = <Wards>[];
      json['wards'].forEach((v) {
        wards!.add(Wards.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['code'] = code;
    data['division_type'] = divisionType;
    data['codename'] = codename;
    data['province_code'] = provinceCode;
    if (wards != null) {
      data['wards'] = wards!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'Districts{name: $name, code: $code, divisionType: $divisionType, codename: $codename, provinceCode: $provinceCode, wards: $wards}';
  }
}