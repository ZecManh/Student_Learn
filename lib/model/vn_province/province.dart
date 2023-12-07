import 'district.dart';

class Province {
  String? name;
  int? code;
  String? divisionType;
  String? codename;
  int? phoneCode;
  List<Districts>? districts;

  Province(
      {this.name,
        this.code,
        this.divisionType,
        this.codename,
        this.phoneCode,
        this.districts});

  Province.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
    divisionType = json['division_type'];
    codename = json['codename'];
    phoneCode = json['phone_code'];
    if (json['districts'] != null) {
      districts = <Districts>[];
      json['districts'].forEach((v) {
        districts!.add(Districts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['code'] = code;
    data['division_type'] = divisionType;
    data['codename'] = codename;
    data['phone_code'] = phoneCode;
    if (districts != null) {
      data['districts'] = districts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}