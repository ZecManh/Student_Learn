class Address {
  String? province;
  String? district;
  String? ward;

  Address({this.province, this.district, this.ward});

  Address.fromJson(Map<String, dynamic> json) {
    province = json['province'];
    district = json['district'];
    ward = json['ward'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['province'] = province;
    data['district'] = district;
    data['ward'] = ward;
    return data;
  }
}
