import 'dart:convert';

import 'package:dart_json_mapper/dart_json_mapper.dart';

export 'package:dart_json_mapper/dart_json_mapper.dart';

mixin PrettyJsonMixin {
  @override
  String toString() {
    const encoder = JsonEncoder();

    String result = encoder.convert(JsonMapper.toMap(this));

    return result;
  }
}
